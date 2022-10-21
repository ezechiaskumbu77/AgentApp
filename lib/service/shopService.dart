import 'dart:convert';

import 'package:delivery_owner/models/Shop.dart';
import 'package:delivery_owner/service/UserData.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../ressources/localeDB.dart';
import '../models/user.dart';

final String BASE_URL = "https://admin.ppc-drc.com/api/v1/";
final String LOGIN_URL = "auth/login";
class CreateService {

  LocalDB db = LocalDB();
  Dio dio = new Dio();


  create(ShopModel shop) async {
    try{
      UserData userdata = UserData();

      UserModel userM = await userdata.getUser();
      //    final respOwner =  await  dio.get('https://admin.ppc-drc.com/api/v1/shopowner?ownerUser=${userM.id}', );




      final response =  await  dio.post('https://admin.ppc-drc.com/api/v1/shop', data: {
        "name" : shop.name, "shopOnwer" : shop.shopOnwer ,"shopManager" : shop.shopManager ,"description" : shop.description ,"capacity" : shop.capacity ,"address" : shop.address , "createdBy" : userM.id, "ville" : shop.ville , "province" : shop.province, "commune" : shop.commune
      });


      if(response.data['success']){

        print("see the data ${response.data}");



        Fluttertoast.showToast(
            msg: "le shop est bien crée",
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

      print("see the data ${e.response.data}");
      Fluttertoast.showToast(
          msg: e.response == null ? "Activer votre connexion" : e.response.data['error'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }

  }


  update(ShopModel shop) async {
    try{
      // UserData userdata = UserData();
      //
      // UserModel userM = await userdata.getUser();
      final respOwner =  await  dio.put('https://admin.ppc-drc.com/api/v1/shop/${shop.id}',  data: {
        "name" : shop.name,"description" : shop.description ,"capacity" : shop.capacity ,"address" : shop.address, "ville" : shop.ville , "province" : shop.province, "commune" : shop.commune
      });


      if(respOwner.data['success']){

        print("see the data ${respOwner.data}");



        Fluttertoast.showToast(
            msg: "Modification reussie",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0
        );

        return true ;


      }

      return false ;
    }

    on DioError catch(e) {

      print("see the data ${e.response.data}");
      Fluttertoast.showToast(
          msg: e.response == null ? "Activer votre connexion" : e.response.data['error'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Color(0xffFF0000),
          textColor: Colors.white,
          fontSize: 16.0
      );
    }

  }


  delete(UserModel userUp) async {
    try{
      UserData userdata = UserData();

      UserModel userM = await userdata.getUser();
      final respOwner =  await  dio.delete('https://admin.ppc-drc.com/api/v1/user/${userUp.id}');


      if(respOwner.data['success']){

        print("see the data ${respOwner.data}");



        Fluttertoast.showToast(
            msg: "Suppression reussie",
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

      print("see the data ${e.response.data}");
      Fluttertoast.showToast(
          msg: e.response == null ? "Activer votre connexion" : e.response.data['error'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Color(0xffFF0000),
          textColor: Colors.white,
          fontSize: 16.0
      );
    }

  }








  createPhone (phone)async {


    try{
      final   response =  await  dio.post('https://admin.ppc-drc.com/api/v1/authm/find/', data: {
        "phone" : phone,
      });



      if(response.data['success']){
        //    print( response.data['success']) ;

        await  db.save("id", response.data['user']['_id']);

        Fluttertoast.showToast(
            msg: "Ce numéro a déjà un utilisateur, trouver un autre numero ",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );
        return {'success' : true , 'find': true ,  'error': false} ;

        // return true ;

      }

      return {'success' : false , 'find': false , 'error': false} ;
    }

    on DioError catch(e) {

      if(e.response.statusCode != 404){
        Fluttertoast.showToast(
            msg: e.response == null ? "Activer votre connexion" : e.response.data['error'],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );

        return {'success' : false , 'find': false , 'error': false} ;
      } else {
        Fluttertoast.showToast(
            msg:"Le numéro n'a pas d'utilisateur",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );
        return {'success' : true , 'find': false , 'error': false} ;
      }


      // if(e.response.statusCode == 404)



    }






  }







}