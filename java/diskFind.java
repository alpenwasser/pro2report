	/**
	 * Sucht den Wert im Array x der am nächsten bei xx liegt und gibt den
	 * 
	 * ArrayIndex zurück. Es kann davon ausgegangen werden, dass x monoton
	 * steigend bzw. fallend ist.
	 * 
	 * @param array
	 * @param referenceValue
	 * @return previous Index
	 */

	public static int diskFind(double[] array, double referenceValue) {

		int length = array.length;
		int index = 0;
		int lower_index = 0;
		int upper_index = length - 1;
		int iterations = (int) (Math.log((double) (length)) / Math
				.log((double) (2))) + 2;

		if (array[0] > array[length - 1]) {

			// Monoton fallend

			if (referenceValue > array[0]) {

				// Reference Value is larger than largest array value.

				return 0;

			} else if (referenceValue < array[length - 1]) {

				// Reference Value is smaller than smallest array value.

				return length - 1;

			}

			for (int i = 0; i < iterations; i++) {

				index = (int) (Math.ceil((upper_index - lower_index) / 2
						+ lower_index));

				double value = array[index];

				if (value > referenceValue) {

					lower_index = index;

				} else if (value < referenceValue) {

					upper_index = index;

				} else {

					break;

				}
			}

		} else {

			// Monoton steigend

			if (referenceValue < array[0]) {

				// Reference Value is smaller than largest array value.

				return 0;

			} else if (referenceValue > array[length - 1]) {

				// Reference Value is largest than smallest array value.

				return length - 1;

			}

			for (int i = 0; i < iterations; i++) {

				index = (int) (Math
						.ceil((double) ((upper_index - lower_index) / 2 + lower_index)));

				double value = array[index];

				if (value < referenceValue) {

					lower_index = index;

				} else if (value > referenceValue) {

					upper_index = index;

				} else {

					break;

				}
			}
		}
		return index;

	}

