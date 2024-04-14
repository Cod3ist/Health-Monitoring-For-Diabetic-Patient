import 'package:flutter_test/flutter_test.dart';
import 'package:healthcare_monitoring_diabetic_patients/utils/counter.dart';

void main(){
  test(
    'initial value of counter should be 0',
    (){
      final Counter counter = Counter();
      final val = counter.value;
      expect(val, 0);
    }
  );

  test(
    'incrementCounter test',
    (){
      final Counter counter = Counter();
      counter.incrementCounter();
      final val = counter.value;
      expect(val, 1);
    }
  );

  test(
    'restartCounter test',
    (){
      final Counter counter = Counter();
      counter.incrementCounter();
      counter.restartCounter();
      final val = counter.value;
      expect(val, 0);
    }
  );
}