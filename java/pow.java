	static public Complex pow(Complex a, double x) {
		return new Complex(
				Math.pow(a.abs(), x) * Math.cos(x * a.getArgument()), Math.pow(
						a.abs(), x) * Math.sin(x * a.getArgument()));
	}

