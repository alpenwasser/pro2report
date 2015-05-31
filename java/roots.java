	/**
	 * Berechnet Nullstellen
	 * 
	 * @param p
	 * @return
	 */
	public static final Complex[] roots(double[] p) {
		final LaguerreSolver solver = new LaguerreSolver();
		double[] flip = new double[p.length];

		// To be conform with Matlab ...
		for (int i = 0; i < flip.length; i++) {
			flip[p.length - i - 1] = p[i];
		}

		return solver.solveAllComplex(flip, 0.0);
	}

