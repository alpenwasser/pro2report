	/**
	 * 
	 * Berechnet den Frequenzgang aufgrund von Zähler- und Nennerpolynom b resp.
	 * 
	 * a sowie der w-Achse.
	 * 
	 * 
	 * 
	 * @param b
	 * 
	 *            Zählerpolynom
	 * 
	 * @param a
	 * 
	 *            Nennerpolynom
	 * 
	 * @param w
	 * 
	 *            w-Achse
	 * 
	 * @return Komplexwertiger Frequenzgang.
	 */

	public static final Complex[] freqs(double[] b, double[] a, double[] w) {
		Complex[] res = new Complex[w.length];

		for (int k = 0; k < res.length; k++) {
			Complex jw = new Complex(0, w[k]);

			Complex zaehler = new Complex(0, 0);
			for (int i = 0; i < b.length; i++) {
				zaehler = zaehler.add(Calc.pow(jw, b.length - i - 1).multiply(
						b[i]));
			}

			Complex nenner = new Complex(0, 0);
			for (int i = 0; i < a.length; i++) {
				nenner = nenner.add(Calc.pow(jw, a.length - i - 1).multiply(
						a[i]));

			}
			if (nenner.abs() == 0.0) {
				res[k] = new Complex(0.0, 0.0);
			} else {
				res[k] = zaehler.divide(nenner);
			}
		}
		return res;
	}

