public static double[][] schrittIfft(double[] zah, double[] nen, double fs, int n) {

    double T = 1 / fs; // Periode
    Complex[] H;

    // Frequenzachse berechnen
    double[] w = linspace(0.0, fs * Math.PI, n / 2); // Kreisfrequenz

    // Frequenzgang berechnen
    H = freqs(zah, nen, w);

    // Symmetrischen Vektor fuer Ifft erstellen:
    Complex[] tmp = new Complex[H.length];
    tmp = colonColon(H, (n / 2) - 1, -1, 1);

    for (int i = 0; i < tmp.length; i++) {
        tmp[i] = tmp[i].conjugate();
    }

    Complex x = new Complex(0);
    H = concat(colonColon(H, 0, 1, (n / 2) - 1), new Complex[] { x }, tmp);

    // Impulsantwort berechen
    Complex[] h;// = new Complex[H.length];
    FastFourierTransformer f = new FastFourierTransformer(DftNormalization.STANDARD);
    h = f.transform(H, TransformType.INVERSE);

    // Realteil von h extrahieren.
    double[] hReal = new double[h.length];

    for (int i = 0; i < h.length; i++) {
        hReal[i] = h[i].getReal();
    }

    // Schrittantwort berechnen
    // double[] y = Calc.diskConvOnes(hReal, n);
    double[] y = new double[n];
    y[0] = hReal[0];
    for (int i = 1; i < y.length; i++) {
        y[i] = y[i - 1] + hReal[i];
    }

    // Resultate ausschneiden. Halbiert die Laenge von y.
    double[] yShort = colonColon(y, 0, 1, (int) ((y.length / 2) - 1));

    // Zeitachse generieren:
    double[] t;
    t = linspace(0.0, (yShort.length - 1) * T, yShort.length);

    // Fuer Output zusammmensetzen:
    double[][] res = new double[2][yShort.length];

    for (int j = 0; j < res[0].length; j++) {
        res[0][j] = yShort[j];
    }
    for (int i = 0; i < res[1].length; i++) {
        res[1][i] = t[i];
    }
    return res;
}
