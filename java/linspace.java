/**
 * 
 * Berechnet linspace mittels startValue, endValue und length. Gibt ein
 * Array mit den entsprechenden Werten zurueck.
 * 
 * @param startValue
 * 
 * @param endValue
 * 
 * @param count
 * 
 * @return
 */

public static double[] linspace(double startValue, double endValue,int count) {
    double delta = (endValue - startValue) / (count - 1);
    double[] array = new double[count];
    for (int i = 0; i < array.length; i++) {
        array[i] = startValue + delta * i;
    }
    return array;
}
