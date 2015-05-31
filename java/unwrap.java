static public double unwrap(double previousAngle, double angle) {
    // Angle wrap/Sprünge hinzufügen
    double wrapedAngle = angle % (2 * Math.PI);

    // Differenz Bilden von vorigem wraped Winkel und aktuellen wraped
    // Winkel
    double angleDiff = previousAngle % (2 * Math.PI) - wrapedAngle;

    // Je nach Differenz Winkelangabe drehen oder nicht
    double angleNew;
    if (Math.abs(angleDiff) > Math.PI)
        angleNew = -2 * Math.PI + angle;
    else
        angleNew = wrapedAngle;

    // Neuer Winkel anzahl Wraps dazuzählen
    return angleNew + (previousAngle - (previousAngle % (2 * Math.PI)));
}
