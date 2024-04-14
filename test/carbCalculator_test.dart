import 'package:flutter_test/flutter_test.dart';
import 'package:healthcare_monitoring_diabetic_patients/utils/carbCalculator.dart';

void main(){
  test(
    'initial value of result should be 0',
    (){
      final CarbCalculator calculator = CarbCalculator();
      final val = calculator.result;
      expect(val, 0.0);
    }
  );
  
  test(
    'check if the calculator is working accurately',
    (){
      final CarbCalculator calculator = CarbCalculator();
      calculator.calculate(127, 125, 35, 6, 23);
      final val = calculator.result;
      expect(val.toStringAsFixed(2), '0.64');
    }
  );
}