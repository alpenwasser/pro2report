private void overShootOptimization() {
    double max = yt[0][Calc.max(yt[0])];
    PhaseResponseMethod phaseResponseMethod = (PhaseResponseMethod) controller;
    double Krk = phaseResponseMethod.getControllerValues()[PhaseResponseMethod.KrkPOS];

    // Grobskalierung mit dem Faktor 1.15
    if (max - 0.1 > controller.overShoot / 100.0 + 1.0) {
        while (max > controller.overShoot / 100.0 + 1.0) {
            Krk = phaseResponseMethod.getControllerValues()[PhaseResponseMethod.KrkPOS];
            phaseResponseMethod.setKrk(Krk / 1.15);
            calculateStepResponse();
            max = yt[0][Calc.max(yt[0])];
        }
    } else {
        while (max + 0.1 < controller.overShoot / 100.0 + 1.0 & Krk < 1000) {
            Krk = phaseResponseMethod.getControllerValues()[PhaseResponseMethod.KrkPOS];
            phaseResponseMethod.setKrk(Krk * 1.15);
            calculateStepResponse();
            max = yt[0][Calc.max(yt[0])];
        }
    }

    // Feinskalierung mit dem Faktor 1.05
    if (max > controller.overShoot / 100.0 + 1.0) {
        while (max > controller.overShoot / 100.0 + 1.0) {
            Krk = phaseResponseMethod.getControllerValues()[PhaseResponseMethod.KrkPOS];
            phaseResponseMethod.setKrk(Krk / 1.05);
            calculateStepResponse();
            max = yt[0][Calc.max(yt[0])];
        }
    } else {
        while (max < controller.overShoot / 100.0 + 1.0 & Krk < 1000) {
            Krk = phaseResponseMethod.getControllerValues()[PhaseResponseMethod.KrkPOS];
            phaseResponseMethod.setKrk(Krk * 1.05);
            calculateStepResponse();
            max = yt[0][Calc.max(yt[0])];
        }
    }
}
