	/**
	 * 
	 * Gibt Werte Bodekonform zurück.
	 * 
	 * 
	 * 
	 * @return
	 */

	public static double[] bodeConform(double Kr, double Tn, double Tv,

	double Tp, int controllerTyp) {

		double[] res = new double[3];

		if (controllerTyp == 2) { // PI-Regler

			res[0] = Kr;

			res[1] = Tn;

			res[2] = 0;

		}

		if (controllerTyp == 3) { // PID-Regler

			double e = Math.sqrt(1 - ((4 * Tn * (Tv - Tp)) / (Math.pow(

			(Tn + Tp), 2))));

			res[1] = 0.5 * (Tn + Tp) * (1 + e); // Tnk

			res[0] = 0.5 * Kr * (1 + (Tp / res[1]) * (1 + e)); // Krk

			res[2] = 0.5 * (Tn + Tp) * (1 - e); // Tvk

		}

		return res;

	}

