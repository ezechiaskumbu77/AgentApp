import 'dart:convert';

import 'package:delivery_owner/models/ProductStock.dart';
import 'package:delivery_owner/models/Shop.dart';
import 'package:delivery_owner/models/ShopProduct.dart';
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


class ShopProductService {

 // DioCacheManager _dioCacheManager = DioCacheManager(CacheConfig());
  LocalDB db = LocalDB();
  Dio dio = new Dio();

  Options _cacheOptions = buildCacheOptions(Duration(days: 7), forceRefresh: true);


  fetchAll(ShopModel shop) async {
    try{
      // UserData userdata = UserData();
      //
      // UserModel userM = await userdata.getUser();

      dio.interceptors.add(AppInterceptors());
      final respOwner =  await  dio.get('https://admin.ppc-drc.com/api/v1/productstock?shop=${shop.id}&isDeleted=false', options: _cacheOptions);


      print("see the Stock product  ${respOwner.data}");
     final res = respOwner.data;
      print("return data");

      if(res['success']  && (res['count'] > 0)){
        print("return data");

        return ProductStockModelFromJson(res['data']);
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




  update(ShopProductModel shopProduct) async {
    try{



      dio.interceptors.add(AppInterceptors());
      final response =  await  dio.put('https://admin.ppc-drc.com/api/v1/shopproduct/${shopProduct.id}', data: {
        "priceUsd" : shopProduct.priceUsd , "priceFc" : shopProduct.priceFc , "shop": shopProduct.shop
         });

      if(response.data['success']){

        print("see the data ${response.data}");
        Fluttertoast.showToast(
            msg: "le produit est bien Modifié",
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








}