class ValidationMixin {
  String validateEmail(String value) {
    if(!value.contains('@')){
      return "please enter a valid email";
    };

    return null ;
  }

  String emptyCheck(String value) {
    if(value==""){

      return "Le champ ne doit pas vide";
    };

    return null ;
  }

  String validatePassword(String value) {
    if(value.length < 6){
      return "Password is Not valid";
    }

    return null;
  }
}