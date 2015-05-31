	/**
	 * 
	 * Spline Interpolation mittels SplineNAK.
	 * 
	 * @param x
	 * 
	 * @param y
	 * 
	 * @param v
	 * 
	 * @return
	 */

	public static double spline(double[] x, double[] y, double v) {

		double res;

		int t = x.length;

		double[] b = new double[t];

		double[] c = new double[t];

		double[] d = new double[t];

		SplineNAK.cubic_nak(t, x, y, b, c, d);

		res = SplineNAK.spline_eval(t, x, y, b, c, d, v);

		return res;

	}

