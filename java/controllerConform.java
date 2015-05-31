	/**
	 * 
	 * Gibt werte Reglerkonform als Array zurück.
	 * 
	 * 
	 * 
	 * @return
	 */

	public static double[] controllerConform(double Krk, double Tnk,

	double Tvk, double Tp, int controllerTyp) {

		double[] res = new double[3];

		if (controllerTyp == 2) {

			res[0] = Krk;

			res[1] = Tnk;

			res[2] = 0;

		}

		if (controllerTyp == 3) {

			res[0] = Krk * (1 + Tvk / Tnk); // Kr

			res[1] = Tnk + Tvk - Tp; // Tn

			res[2] = ((Tnk * Tvk) / (Tnk + Tvk - Tp)) - Tp; // Tv

		}

		return res;

	}

