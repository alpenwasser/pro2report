	/**
	 * 
	 * Ausmultiplizieren von Polynomen der Form: (1+x_1)*(1+x_2)*...
	 * 
	 * 
	 * 
	 * @param x
	 * 
	 *            double[]
	 * 
	 * @return res
	 */

	public static double[] poly(double[] x) {

		double[] res = { x[0], 1.0 };

		for (int i = 1; i < x.length; i++) {
			double[] c = { x[i], 1.0 };
			res = diskConv(c, res);
		}
		return res;
	}

