	/**
	 * 
	 * Gibt die Werte des Array x in gewünschter Reihenfolge zurück (z.B.
	 * 
	 * invertiert). Double-Version
	 * 
	 * 
	 * 
	 * @param x
	 * 
	 * @param start
	 * 
	 * @param stepsize
	 * 
	 * @param stop
	 * 
	 * @return
	 */

	public static double[] colonColon(double[] x, int start, int stepsize,
			int stop) {

		double[] y = new double[(int) ((stop - start) / stepsize) + 1];

		// TODO: Vergleich so richtitg oder +1 und dann <

		int k = start;

		for (int i = 0; i < y.length; i++) {

			y[i] = x[k];

			k = k + stepsize;

		}

		return y;
	}

