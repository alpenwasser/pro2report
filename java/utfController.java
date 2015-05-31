/**
	 * 
	 * Berechnte Zähler und Nennerpolynom eines Reglers
	 * 
	 * 
	 * 
	 * @param controllerTyp
	 * 
	 * @param Krk
	 * 
	 * @param Tnk
	 * 
	 * @param Tvk
	 * 
	 * @param Tp
	 * 
	 * @return koeffizienten
	 */

	public static double[][] utfController(int controllerTyp, double Krk,
			double Tnk, double Tvk, double Tp) {

		double[][] res;

		switch (controllerTyp) {

		// PI-Regler

		case Controller.PI:

			res = new double[2][2];

			// Zaehler
			res[0][0] = Krk * Tnk;
			res[0][1] = Krk;

			// Nenner
			res[1][0] = Tnk;
			res[1][1] = 0;

			break;

		// PID-Regler

		case Controller.PID:

			res = new double[2][];
			res[0] = new double[3];
			res[1] = new double[2];

			// Zaehler
			double[] conv = Calc.diskConv(new double[] { Tvk, 1.0 },
					new double[] { Tnk, 1.0 });
			for (int i = 0; i < 3; i++) {
				res[0][i] = Krk * conv[i];
			}

			// Nenner
			res[1][0] = Tnk;
			res[1][1] = 0;

			break;

		default:

			res = new double[0][0];

			break;

		}

		return res;
	}

