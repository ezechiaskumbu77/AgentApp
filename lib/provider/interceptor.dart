
import 'package:dio/dio.dart';
import '../service/UserData.dart';
import '../models/user.dart';



class AppInterceptors extends Interceptor {

  UserModel userM = UserModel() ;
  UserData userD = UserData();
  String token ;


  @override
  Future<dynamic> onRequest(RequestOptions options) async {

      print("interceptor begin");
      bool isAuth = await userD.isAuth();
      print("is auth yes $isAuth");
      if (!isAuth) {
        return null ;
      } else {
        userM = await userD.getUser();

        token = await userD.getToken();

        options.headers.addAll({"Authorization": "Bearer $token"});
        print("finished interceptor");

        return options;
      }



  }

  // @override
  // Future<dynamic> onError(DioError dioError) {
  //   if (dioError.message.contains("ERROR_001")) {
  //     // this will push a new route and remove all the routes that were present
  //     // navigatorKey.currentState.pushNamedAndRemoveUntil(
  //     //     "/login", (Route<dynamic> route) => false);
  //   }
  //
  //   return dioError;
  // }
  //
  // @override
  // Future<dynamic> onResponse(Response options) async {
  //   if (options.headers.value("verifyToken") != null) {
  //     //if the header is present, then compare it with the Shared Prefs key
  //     SharedPreferences prefs = await SharedPreferences.getInstance();
  //     var verifyToken = prefs.get("VerifyToken");
  //
  //     // if the value is the same as the header, continue with the request
  //     if (options.headers.value("verifyToken") == verifyToken) {
  //       return options;
  //     }
  //   }
  //
  //   return DioError(request: options.request, message: "User is no longer active");
  // }
}