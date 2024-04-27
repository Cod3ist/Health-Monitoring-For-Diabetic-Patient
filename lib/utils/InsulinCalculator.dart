class InsulinCalculator{
  double _result = 0.0;
  double get result => _result;

  double? calculate(double target, double current, int ICR, int ISF, int carbs) {
    target = target * 0.0555;
    current = current * 0.0555;

    _result = ((carbs / ICR) + ((current - target) / ISF));
  }
}

