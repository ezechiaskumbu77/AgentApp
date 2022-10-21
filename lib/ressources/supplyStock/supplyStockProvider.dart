import 'dart:convert';

import 'package:delivery_owner/models/ProductStock.dart';
import 'package:delivery_owner/models/Shop.dart';
import 'package:delivery_owner/models/SupplyStock.dart';
import 'package:delivery_owner/models/user.dart';
import 'package:delivery_owner/ressources/localeDB.dart';
import 'package:delivery_owner/service/UserData.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:delivery_owner/provider/interceptor.dart';
import 'package:dio_http_cache/dio_http_cache.dart';


final String BASE_URL = "https://admin.ppc-drc.com/api/v1/";
final String LOGIN_URL = "auth/login";


class SupplystockService {

 // DioCacheManager _dioCacheManager = DioCacheManager(CacheConfig());
  LocalDB db = LocalDB();
  Dio dio = new Dio();

  Options _cacheOptions = buildCacheOptions(Duration(days: 7), forceRefresh: true);


  fetchAll(ProductStockModel product) async {
    try{
      // UserData userdata = UserData();
      //
      // UserModel userM = await userdata.getUser();

      dio.interceptors.add(AppInterceptors());
      final respOwner =  await  dio.get('https://admin.ppc-drc.com/api/v1/supplystock?productStock=${product.id}&isDeleted=false', options: _cacheOptions);


      print("see the supply product ${respOwner.data}");
     final res = respOwner.data;
      print("return data");

      if(res['success']  && (res['count'] > 0)){
        print("return data");

        return SupplyStockModelFromJson(res['data']);
      }
      return null ;
    }

    on DioError catch(e) {

      print("see the error data ${e.response.data}");
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


  create(SupplyStockModel supplyStock) async {
    try{



      dio.interceptors.add(AppInterceptors());
      final response =  await  dio.post('https://admin.ppc-drc.com/api/v1/supplystock', data: {
          "number" : supplyStock.number , "productStock" : supplyStock.productStock , "shop" : supplyStock.shop

         });

      if(response.data['success']){

        print("see the data ${response.data}");
        Fluttertoast.showToast(
            msg: "l'approvisionnement a reussi'",
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


      return false ;
    }


  }

  update(SupplyStockModel supplyStock) async {
    try{



      dio.interceptors.add(AppInterceptors());
      final response =  await  dio.put('https://admin.ppc-drc.com/api/v1/supplystock/${supplyStock.id}', data: {
        "number" : supplyStock.number , "productStock" : supplyStock.productStock , "shop" : supplyStock.shop
      });

      if(response.data['success']){

        print("see the data ${response.data}");
        Fluttertoast.showToast(
            msg: "Modification Reussie",
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


      return false ;
    }


  }



  delete(String idSupply) async {


    try{


      dio.interceptors.add(AppInterceptors());
      final respOwner =  await  dio.delete('https://admin.ppc-drc.com/api/v1/supplystock/${idSupply}');


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





}