import 'package:flutter_test/flutter_test.dart';
import 'package:healthcare_monitoring_diabetic_patients/utils/validate.dart';

void main(){
  //Negative test cases
  test(
    'enter an invalid BGL value, (case 1) negative value',
    (){
      String val = '-1';
      bool output = !Validate().checkBGLevel(val);
      expect(output, false);
    }
  );

  test(
      'enter an invalid BGL , (case 2) low positive value',
          (){
        String val = '15';
        bool output = !Validate().checkBGLevel(val);
        expect(output, false);
      }
  );

  test(
      'enter an invalid BGL , (case 3) high positive value',
          (){
        String val = '550';
        bool output = !Validate().checkBGLevel(val);
        expect(output, false);
      }
  );

  test(
      'enter an invalid Age , (case 1) negative value',
          (){
        String val = '-10';
        bool output = !Validate().checkAge(val);
        expect(output, false);
      }
  );

  test(
      'enter an invalid Age , (case 2) zero',
          (){
        String val = '0';
        bool output = !Validate().checkAge(val);
        expect(output, false);
      }
  );

  test(
      'enter an invalid Height , (case 1) negative value',
          (){
        String val = '-10';
        bool output = !Validate().checkHeight(val);
        expect(output, false);
      }
  );

  test(
      'enter an invalid Height , (case 2) low positive value',
          (){
        String val = '10';
        bool output = !Validate().checkHeight(val);
        expect(output, false);
      }
  );

  test(
      'enter an invalid Height , (case 3) high positive value',
          (){
        String val = '2550';
        bool output = !Validate().checkHeight(val);
        expect(output, false);
      }
  );

  test(
      'enter an invalid Weight , (case 1) negative value',
          (){
        String val = '-90';
        bool output = !Validate().checkHeight(val);
        expect(output, false);
      }
  );

  test(
      'enter an invalid Weight , (case 2) low positive value',
          (){
        String val = '20';
        bool output = !Validate().checkHeight(val);
        expect(output, false);
      }
  );

  test(
      'enter an invalid Weight , (case 3) high positive value',
          (){
        String val = '300';
        bool output = !Validate().checkHeight(val);
        expect(output, false);
      }
  );

  test(
      'enter a recent year',
          (){
        int year = 2018;
        bool output = !Validate().checkBirthDate(year);
        expect(output, false);
      }
  );


  //Positive test cases
  test(
      'enter a valid BGL',
          (){
        String val = '112';
        bool output = !Validate().checkBGLevel(val);
        expect(output, true);
      }
  );

  test(
      'enter a valid Age',
          (){
        String val = '55';
        bool output = !Validate().checkAge(val);
        expect(output, true);
      }
  );

  test(
      'enter a valid Height',
          (){
        String val = '160';
        bool output = !Validate().checkBGLevel(val);
        expect(output, true);
      }
  );

  test(
      'enter a valid Weight',
          (){
        String val = '86';
        bool output = !Validate().checkBGLevel(val);
        expect(output, true);
      }
  );

  test(
      'enter a valid Weight',
      (){
        int year = 2003;
        bool output = !Validate().checkBirthDate(year);
        expect(output, true);
      }
  );
}