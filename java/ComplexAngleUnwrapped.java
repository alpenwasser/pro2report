static public double[] ComplexAngleUnwraped(Complex[] a) {
    double[] b = new double[a.length];
    b[0] = a[0].getArgument();
    for (int i = 1; i < b.length; i++) {
        b[i] = unwrap(b[i - 1], a[i].getArgument());
    }
    return b;
}
