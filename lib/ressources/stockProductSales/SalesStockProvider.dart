import 'dart:convert';

import 'package:delivery_owner/models/ProductStock.dart';
import 'package:delivery_owner/models/Shop.dart';
import 'package:delivery_owner/models/SupplyStock.dart';
import 'package:delivery_owner/models/salesStock.dart';
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


class SalesStockService {

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
      final respOwner =  await  dio.get('https://admin.ppc-drc.com/api/v1/salestock?productStock=${product.id}&isDeleted=false', options: _cacheOptions);


      print("see the sales product ${respOwner.data}");
     final res = respOwner.data;
      print("return data");

      if(res['success']  && (res['count'] > 0)){
        print("return data");

        return SalesStockModelFromJson(res['data']);
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


  create(SalesStockModel salesStock) async {
    try{



      dio.interceptors.add(AppInterceptors());
      final response =  await  dio.post('https://admin.ppc-drc.com/api/v1/salestock', data: {
          "number" : salesStock.number , "productStock" : salesStock.productStock , "shop" : salesStock.shop , "deviseType" : salesStock.deviseType, "price" : salesStock.price

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

  update(SalesStockModel salesStock) async {
    try{



      dio.interceptors.add(AppInterceptors());
      final response =  await  dio.put('https://admin.ppc-drc.com/api/v1/salestock/${salesStock.id}', data: {
        "number" : salesStock.number , "productStock" : salesStock.productStock , "shop" : salesStock.shop , "deviseType" : salesStock.deviseType, "price" : salesStock.price

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



  delete(String isSales) async {


    try{


      dio.interceptors.add(AppInterceptors());
      final respOwner =  await  dio.delete('https://admin.ppc-drc.com/api/v1/salestock/${isSales}');


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