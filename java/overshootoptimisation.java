private void overShootOptimazation() {
    double max = yt[0][Calc.diskMax(yt[0])];
    PhaseResponseMethod phaseResponseMethod = (PhaseResponseMethod) controller;
    double Krk = phaseResponseMethod.getControllerValues()[PhaseResponseMethod.KrkPOS];
    if (max > controller.overShoot / 100.0 + 1.0) {
        while (max > controller.overShoot / 100.0 + 1.0) {
            Krk = phaseResponseMethod.getControllerValues()[PhaseResponseMethod.KrkPOS];
            phaseResponseMethod.setKrk(Krk / 1.05);
            calculateStepResponse();
            max = yt[0][Calc.diskMax(yt[0])];
        }
    } else {
        while (max < controller.overShoot / 100.0 + 1.0 & Krk < 1000) {
            Krk = phaseResponseMethod.getControllerValues()[PhaseResponseMethod.KrkPOS];
            phaseResponseMethod.setKrk(Krk * 1.05);
            calculateStepResponse();
            max = yt[0][Calc.diskMax(yt[0])];
        }
    }
}
