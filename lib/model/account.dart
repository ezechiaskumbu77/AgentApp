import 'package:delivery_owner/main.dart';
import 'package:delivery_owner/model/pref.dart'; 


class Account{





  String userName = "Osée Moya";
  String email = "osee@gmail.com";
  String phone = "+243904911250";
  String userAvatar = "https://secure-sea-91184.herokuapp.com/uploads/photo_user.png";
  String token = "";


  int notifyCount = 6;
  String currentOrder = "";
  String openOrderOnMap = "";
  String backRoute = "";
  String backRouteMap = "";

  bool initUser = true;

  okUserEnter(String name, String password, String avatar, String _email, String _token){
    initUser = true;
    userName = name;
    userAvatar = avatar;
    email = _email;
    token = _token;
    pref.set(Pref.userEmail, _email);
    pref.set(Pref.userPassword, password);
    pref.set(Pref.userAvatar, avatar);
    dprint("User Auth! Save email=$email pass=$password");
  }

  logOut(){
//    _initUser = false;
//    pref.clearUser();
//    userName = "";
//    userAvatar = "";
//    email = "";
//    token = "";
  }

  isAuth(){
    return initUser;
  }

  Function _redrawMainWindow;

  setRedraw(Function callback){
    _redrawMainWindow = callback;
  }

  redraw(){
    if (_redrawMainWindow != null)
      _redrawMainWindow();
  }

}
