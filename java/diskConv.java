	/**
	 * 
	 * Berechnet die diskrete Faltung
	 * 
	 * @param b
	 *            = Nenner
	 * @param a
	 *            = Zähler
	 * @return c = die Faltung
	 */

	public static double[] diskConv(double[] a, double[] b) {

		double[] c = new double[a.length + b.length - 1];

		for (int n = 0; n < c.length; n++) {

			for (int i = Math.max(0, n - a.length + 1); i <= Math.min(
					b.length - 1, n); i++) {

				c[n] += b[i] * a[n - i];
			}
		}

		return c;
	}

