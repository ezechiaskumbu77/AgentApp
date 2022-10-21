

import 'dart:convert';

import 'package:path/path.dart';
import 'package:async/async.dart';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:delivery_owner/models/ProductStock.dart';
import 'package:delivery_owner/models/Shop.dart';
import 'package:delivery_owner/models/user.dart';
import 'package:delivery_owner/ressources/localeDB.dart';
import 'package:delivery_owner/service/UserData.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:delivery_owner/provider/interceptor.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime_type/mime_type.dart';

import 'package:http/http.dart' as http;


final String BASE_URL = 'https://admin.ppc-drc.com/api/v1/';
final String LOGIN_URL = 'auth/login';


class UserDio {

 // DioCacheManager _dioCacheManager = DioCacheManager(CacheConfig());

  UserModel userM = UserModel() ;
  UserData userD = UserData();
  String token ;
  LocalDB db = LocalDB();
  Dio dio = new Dio();

  Options _cacheOptions = buildCacheOptions(Duration(days: 7), forceRefresh: true);


  upload (File file) async {

      print('get all start');
      bool isAuth = await userD.isAuth();
      print('is auth $isAuth');
      if (!isAuth) {
        return null ;
      } else {
        userM = await userD.getUser();


        token = await userD.getToken();
      }




      var stream =
      new http.ByteStream(DelegatingStream.typed(file.openRead()));
      // get file length
      var length = await file.length(); //imageFile is your image file
      var headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer ' + token
      }; // ignore this headers if there is no authentication

      // string to uri
      var uri = Uri.parse('https://admin.ppc-drc.com/api/v1/user/${userM.id}/photo');

      // create multipart request
      var request = new http.MultipartRequest('POST', uri);

      // multipart that takes file
      var multipartFileSign = new http.MultipartFile('file', stream, length,
          filename: basename(file.path));

      // add file to multipart
      request.files.add(multipartFileSign);

      //add headers
      request.headers.addAll(headers);

      // sendt

        var response = await request.send();

        print(response.statusCode);

        if(!(response.statusCode==200)){
          return null;
        }


        UserModel uu  = null;

      // listen for response
      return  response;

        print('it\'s execute this');





  // print(repo.toString());


      /////////////////////////////////

    //
    //
    //   String fileName = file.path.split('/').last;
    //   print('file name='+fileName);
    //
    //
    //
    //   dio.options.headers['Content-Type'] = 'multipart/form-data';
    //   dio.options.headers['accept'] = '*/*';
    //   //
    //   // FormData formData= FormData.fromMap({
    //   //
    //   //
    //   //   'file': await MultipartFile.fromFile(
    //   //     file.path,
    //   //     filename: fileName,
    //   //   contentType: MediaType('image', 'jpg')
    //   //
    //   //   ),
    //   // //  'type' : 'image/jpg'
    //   // });
    //
    //
    //
    //
    //   print('POST:BODY='+formData.toString());
    //
    //
    //   dio.interceptors.add(AppInterceptors());
    //   final response =  await  dio.post('https://admin.ppc-drc.com/api/v1/user/${userM.id}/photo' ,  data: formData);
    //
    //
    //
    //
    //   if(response.data['success']){
    //
    //     print('see the data ${response.data}');
    //     Fluttertoast.showToast(
    //         msg: 'l'image est bien uploadé',
    //         toastLength: Toast.LENGTH_SHORT,
    //         gravity: ToastGravity.BOTTOM,
    //         backgroundColor: Colors.red,
    //         textColor: Colors.white,
    //         fontSize: 16.0
    //     );
    //
    //     return true ;
    //
    //   }
    //
    //   return false ;
    // }
    //
    // on DioError catch(e) {
    //
    //   print('see the data ${e.response.data}');
    //   Fluttertoast.showToast(
    //       msg: 'Error' ,//  e.response == null ? 'Activer votre connexion' : e.response.data['error'],
    //       toastLength: Toast.LENGTH_SHORT,
    //       gravity: ToastGravity.BOTTOM,
    //       backgroundColor: Colors.red,
    //       textColor: Colors.white,
    //       fontSize: 16.0
    //   );
    //
    //
    //   return false ;
    // }


  }


  fetchAll(ShopModel shop) async {
    try{
      // UserData userdata = UserData();
      //
      // UserModel userM = await userdata.getUser();

      dio.interceptors.add(AppInterceptors());
      final respOwner =  await  dio.get('https://admin.ppc-drc.com/api/v1/productstock?shop=${shop.id}&isDeleted=false', options: _cacheOptions);


      print('see the Stock product  ${respOwner.data}');
     final res = respOwner.data;
      print('return data');

      if(res['success']  && (res['count'] > 0)){
        print('return data');

        return ProductStockModelFromJson(res['data']);
      }
      return null ;
    }

    on DioError catch(e) {

      print('see the error data ${e.response.data}');
      Fluttertoast.showToast(
          msg: e.response == null ? 'Activer votre connexion' : e.response.data['error'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Color(0xffFF0000),
          textColor: Colors.white,
          fontSize: 16.0
      );
    }

  }


  create(ProductStockModel productStock) async {
    try{



      dio.interceptors.add(AppInterceptors());
      final response =  await  dio.post('https://admin.ppc-drc.com/api/v1/productstock', data: {
        'name' : productStock.name, 'description' : productStock.description ,'deviseType' : productStock.deviseType ,'price' : productStock.price ,'startingInvertory' : productStock.startingInvertory ,'shop' : productStock.shop, 'inventorOnHand' : productStock.startingInvertory
      });

      if(response.data['success']){

        print('see the data ${response.data}');
        Fluttertoast.showToast(
            msg: 'le produit est bien crée',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );

        return true ;

      }

      return false ;
    }

    on DioError catch(e) {

      print('see the data ${e.response.data}');
      Fluttertoast.showToast(
          msg: e.response == null ? 'Activer votre connexion' : e.response.data['error'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );


      return false ;
    }


  }

  update(UserModel user) async {
    try{


        print('get all start');
        bool isAuth = await userD.isAuth();
        print('is auth $isAuth');
        if (!isAuth) {
          return null ;
        } else {
          userM = await userD.getUser();


          token = await userD.getToken();
        }



      dio.interceptors.add(AppInterceptors());
      final response =  await  dio.put('https://admin.ppc-drc.com/api/v1/user/${userM.id}', data: {
        'name' : user.name, 'birthday' : user.birthday ,'address' : user.address ,'sexe' : user.sexe
      });

      if(response.data['success']){

        print('see the data ${response.data}');
        Fluttertoast.showToast(
            msg: 'le produit est bien Modifié',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );

        return true ;

      }

      return false ;
    }

    on DioError catch(e) {

      print('see the data ${e.response.data}');
      Fluttertoast.showToast(
          msg: e.response == null ? 'Activer votre connexion' : e.response.data['error'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );


      return false ;
    }


  }



  delete(String idProduct) async {


    try{


      dio.interceptors.add(AppInterceptors());
      final respOwner =  await  dio.delete('https://admin.ppc-drc.com/api/v1/productstock/${idProduct}');


      if(respOwner.data['success']){

        print('see the data ${respOwner.data}');



        Fluttertoast.showToast(
            msg: 'Suppression reussie',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Color(0xffFF0000),
            textColor: Colors.white,
            fontSize: 16.0
        );

        return true ;


      }

      return false ;
    }

    on DioError catch(e) {

      print('see the data ${e.response.data}');
      Fluttertoast.showToast(
          msg: e.response == null ? 'Activer votre connexion' : e.response.data['error'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Color(0xffFF0000),
          textColor: Colors.white,
          fontSize: 16.0
      );
    }

  }





}