import 'dart:convert';

import 'package:delivery_owner/service/UserData.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../ressources/localeDB.dart';
import '../models/user.dart';

final String BASE_URL = "https://admin.ppc-drc.com/api/v1/";
final String LOGIN_URL = "auth/login";
class ShopManagerService {

  LocalDB db = LocalDB();
  Dio dio = new Dio();


  create(UserModel userMM) async {
    try{
      UserData userdata = UserData();

      UserModel userM = await userdata.getUser();
      final respOwner =  await  dio.get('https://admin.ppc-drc.com/api/v1/shopowner?ownerUser=${userM.id}', );
      if(respOwner.data['count'] != 1){


        Fluttertoast.showToast(
            msg: "l'utilisateur n'est pas un ShopOwner",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );


      } else {
        print("see the id and ${respOwner.data} ");
        var shopOnwerId = respOwner.data["data"][0]['_id'] ;
print("seeeeeeee the id and  ${shopOnwerId}");


        final response =  await  dio.post('https://admin.ppc-drc.com/api/v1/authm/register', data: {
          "name" : userMM.name, "birthday" : userMM.birthday  ,"sexe" : userMM.sexe ,"address" : userMM.address ,"phone" : userMM.phone ,"hasShop" : false, "isShopmanager" : true,"isDeliverCorp" : false , "shopOwner" : shopOnwerId , "createdBy" : userM.id , "ville" : userMM.ville , "province" : userMM.province, "commune" : userMM.commune
        });


        if(response.data['success']){

          print("see the data ${response.data}");



          Fluttertoast.showToast(
              msg: "l'utilisateur ${userMM.name} est cree comme User manager",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0
          );

          // await  db.save("id", response.data['user']['_id']);
          //
          // print( response.data['user']) ;
          // await  db.save("token", response.data['token']);
          // await  db.saveJson("user",  response.data['user']);
          // var lol = await db.read("user");

          //   print("see the data $lol");
          //    UserModel uu = UserModel.fromJson(jsonDecode(lol));

          //  print("Seee the name ${uu.name }");


          return true ;

        }

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


  update(UserModel userUp) async {
    try{
      UserData userdata = UserData();

      UserModel userM = await userdata.getUser();
      final respOwner =  await  dio.put('https://admin.ppc-drc.com/api/v1/user/${userUp.id}',  data: {
        "name" : userUp.name, "birthday" : userUp.birthday  ,"sexe" : userUp.sexe ,"address" : userUp.address ,"phone" : userUp.phone
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