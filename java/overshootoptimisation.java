private void overShootOptimization() {
    PhaseResponseMethod phaseResponseMethod = (PhaseResponseMethod) controller;
    double max = yt[0][Calc.max(yt[0])];

    // Grobskalierung
    int order = path.getT().length;
    double maxSoll = controller.overShoot / 100 + 1.0;
    double KrkNew;
    double Krk = phaseResponseMethod.getControllerValues()[PhaseResponseMethod.KrkPOS];
    int count = 0;
    // Falls max kleiner Soll
    if (maxSoll - max > 0.08) {
        while (maxSoll - max > 0.08 & count < 10) {
            count++;
            KrkNew = Krk * maxSoll / max * (8.0 / order);
            phaseResponseMethod.setKrk(KrkNew);
            calculateStepResponse();
            double maxNew = yt[0][Calc.max(yt[0])];

            // Kontrolle ob erfolgreich vergroessert sonst Abbruch
            if (maxNew > max) {
                max = maxNew;
                Krk = phaseResponseMethod.getControllerValues()[PhaseResponseMethod.KrkPOS];
            } else {
                count = 100;
            }
        }
        // Falls max groesser Soll
    } else if (maxSoll - max < -0.08) {
        while (maxSoll - max < -0.08 & count < 5) {
            count++;
            KrkNew = Krk * maxSoll / max * (order / 8.0);
            phaseResponseMethod.setKrk(KrkNew);
            calculateStepResponse();
            double maxNew = yt[0][Calc.max(yt[0])];

            // Kontrolle ob erfolgreich verkleinert sonst Abbruch
            if (maxNew < max) {
                max = maxNew;
                Krk = phaseResponseMethod.getControllerValues()[PhaseResponseMethod.KrkPOS];
            } else {
                count = 100;
            }
        }
    }

    int countMax = 100;
    if (pointnumber < 8193)
        countMax = 200;
    // Feinskalierung mit dem Faktor 1.05
    count = 0;
    if (max > maxSoll) {
        while (max > maxSoll & Krk > 1e-19 & count < countMax) {
            count++;
            phaseResponseMethod.setKrk(Krk / 1.05);
            calculateStepResponse();
            max = yt[0][Calc.max(yt[0])];
            Krk = phaseResponseMethod.getControllerValues()[PhaseResponseMethod.KrkPOS];
        }
    } else {
        while (max < maxSoll & Krk < 1e16 & count < countMax) {
            count++;
            phaseResponseMethod.setKrk(Krk * 1.05);
            calculateStepResponse();
            max = yt[0][Calc.max(yt[0])];
            Krk = phaseResponseMethod.getControllerValues()[PhaseResponseMethod.KrkPOS];
        }
    }
}
