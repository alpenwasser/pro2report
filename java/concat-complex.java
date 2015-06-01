	/**
	 * 
	 * Setzt drei Arrays zu einem zusammen. Complex-Version
	 * 
	 * @param x
	 * 
	 * @param y
	 * 
	 * @param z
	 * 
	 * @return
	 */

	public static Complex[] concat(Complex[] x, Complex[] y, Complex[] z) {

		Complex[] res = new Complex[x.length + y.length + z.length];

		for (int i = 0; i < x.length; i++) {

			res[i] = x[i];

		}

		for (int i = 0; i < y.length; i++) {

			res[i + x.length] = y[i];

		}

		for (int i = 0; i < z.length; i++) {

			res[i + x.length + y.length] = z[i];

		}

		return res;

	}

