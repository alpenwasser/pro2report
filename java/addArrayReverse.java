	/**
	 * Addiert ein Array b mit dem Array a so zusammen, dass b in die hintersten
	 * Positionen von a addiert wird.
	 * 
	 * @param a
	 * @param b
	 * @return
	 */
	public static double[] addArrayReverse(double[] a, double[] b) {

		int index = b.length - 1;
		for (int i = a.length - 1; i > a.length - b.length - 1; i--) {
			a[i] += b[index];
			index--;
		}

		return a;
	}

