public static double diskDiff(double[] x, double[] y, int index) {
    if (index > 0 & index < x.length - 1) {
        double diff2 = (y[index + 1] - y[index]) / (x[index + 1] - x[index]);
        double diff1 = (y[index] - y[index - 1]) / (x[index] - x[index - 1]);
        double diff = (diff1 + diff2) / 2;
        return diff;
    } else if (index == 0)
        return (y[index + 1] - y[index]) / (x[index + 1] - x[index]);
    else if (index == x.length)
        return (y[index] - y[index - 1]) / (x[index] - x[index - 1]);
    else
        return 0;
}
