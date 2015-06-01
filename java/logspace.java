/**
 * 
 * Berechnet logspace mittels startValue, endValue und count. Generiert ein
 * 
 * Array mit "count" Punkten logarithmisch zwischen 10^startValue und
 * 
 * 10^endValue aufgespannt. Gibt ein Array mit den entsprechenden Werten
 * 
 * zurück.
 * 
 * 
 * 
 * @param startValue
 * 
 * @param endValue
 * 
 * @param length
 * 
 * @return
 */

public static double[] logspace(double startValue, double endValue,

int count) {

	double logarithmicBase = 10;

	double delta = (endValue - startValue) / (count);

	double accDelta = 0.0;

	double[] array = new double[count + 1];

	for (int i = 0; i < array.length; i++) {

		array[i] = Math.pow(logarithmicBase, startValue + accDelta);

		accDelta += delta;

	}

	return array;

}
