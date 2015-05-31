	/**
	 * 
	 * Sucht den Höchstwert von x und gibt dessen Index zurück. Kommt die der
	 * 
	 * Höchstwert mehrfach vor, wird der Index des ersten Wertes ausgegeben.
	 * 
	 * 
	 * @param array
	 * 
	 * @return
	 */

	public static int diskMax(double[] array) {

		double largest = array[0];

		int index = 0;

		for (int i = 1; i < array.length; i++) {

			if (array[i] > largest) {

				largest = array[i];

				index = i;

			}

		}

		return index;

	}

