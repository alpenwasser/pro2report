private void calculateTnkTvk() {
    double dPhiS = Calc.diskDiff(omega, phiS, omegaControllerIndex);
    double beta_u = Math.pow(10, -12);
    double beta_o = 1;
    double beta;
    double dPhiR,
    dPhiO;

    for (int iteration = 0; iteration < 20; iteration++) {
        beta = (beta_o - beta_u) / 2 + beta_u;
        Tvk = 1 / (omegaController / beta);
        Tnk = 1 / (omegaController * beta);

        for (int i = 0; i < pointNumber; i++) {
            Hr[i] = new Complex(1, omega[i] * Tnk).multiply(
                    new Complex(1, omega[i] * Tvk)).divide(
                    new Complex(0, omega[i] * Tnk));
            Ho[i] = Hs[i].multiply(Hr[i]);
        }
        phiR = Calc.ComplexAngleUnwraped(Hr);

        dPhiR = Calc.diskDiff(omega, phiR, omegaControllerIndex);
        dPhiO = dPhiS + dPhiR;

        if (dPhiO * omegaController < -0.5) {
            beta_u = beta;
        } else {
            beta_o = beta;
        }
    }
}
