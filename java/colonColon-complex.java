	/**
	 * 
	 * Gibt die Werte des Array x in gewünschter Reihenfolge zurück (z.B.
	 * invertiert). Complex-Version!
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

	public static Complex[] colonColon(Complex[] x, int start, int stepsize,
			int stop) {

		Complex[] y = new Complex[(int) ((stop - start) / stepsize) + 1];

		// TODO: Vergleich so richtitg oder +1 und dann <

		int k = start;

		for (int i = 0; i < y.length; i++) {

			y[i] = x[k];

			k = k + stepsize;

		}

		return y;

	}
