class Validate{
  bool checkBGLevel(String value){
    if (int.parse(value)<70 || int.parse(value)>200){
      return true;
    } else {
      return false;
    }
  }

  bool checkAge(String age){
    if (int.parse(age)<=0 || int.parse(age)>130){
      return true;
    } else {
      return false;
    }
  }

  bool checkHeight(String height){
    if (int.parse(height)<40 || int.parse(height)>200){
      return true;
    } else {
      return false;
    }
  }

  bool checkWeight(String weight){
    if (int.parse(weight)<30 || int.parse(weight)>200){
      return true;
    } else {
      return false;
    }
  }

  bool checkBirthDate(int year){
    var val = DateTime.now().year - year;
    if (val<10){
      return true;
    } else {
      return false;
    }
  }

}