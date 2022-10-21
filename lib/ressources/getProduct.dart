import 'dart:convert';

import 'package:delivery_owner/models/Shop.dart';
import 'package:http/http.dart' show Client;

import '../service/UserData.dart';
import '../models/user.dart';

import '../models/product.dart';

// final _root = '$_root';
final _root = 'https://admin.ppc-drc.com/api/v1';

class GetProduct {
  UserModel userM = UserModel();
  UserData userD = UserData();
  String token;
  Client client = Client();

  fetchAll(ShopModel shop) async {
    //  //print('get all start');
    final bool isAuth = await userD.isAuth();
    //  //print('is auth $isAuth');
    if (!isAuth) {
      return null;
    } else {
      userM = await userD.getUser();

      token = await userD.getToken();
    }

    final myhead = {
      'content-type': 'application/json',
      'accept': 'application/json',
      'authorization': 'Bearer ${token}'
    };

    final response = await client.get('$_root/product', headers: myhead);
    //print('see the product ${response.body}');
    final res = json.decode(response.body);

    if (res['success'] && (res['count'] >= 1)) {
      // print('return data');

      var listproduct = ProductModelFromJson(res['data']);
      // print('shop place'+place);
      for (var j = listproduct.length - 1; j >= 0; j--) {

        if (listproduct[j].name == 'Surecast') {

          await getProductPrice(shop, 'Surecast').then((value) {

            final pricesurecast = value;

            if (pricesurecast != 0) {
              listproduct[j].price = pricesurecast;
            }
          });
        }

        if (listproduct[j].name == 'Surecem') {

          await getProductPrice(shop, 'Surecem').then((value) {
            final pricesurecem = value;

            if (listproduct[j].name == 'Surecem' && pricesurecem != 0) {
              listproduct[j].price = pricesurecem;
            }
          });

        }
      }

      return listproduct;
    }
    return null;
  }

  getProductPrice(shop, product) async {
    // print('get all start');
    final bool isAuth = await userD.isAuth();
    // print('is auth $isAuth');
    if (!isAuth) {
      return null;
    } else {
      userM = await userD.getUser();

      token = await userD.getToken();
    }

    final myhead = {
      'content-type': 'application/json',
      'accept': 'application/json',
      'authorization': 'Bearer ${token}'
    };

    final response =
        await client.get('$_root/zone?isDeleted=false', headers: myhead);
    //  print('see the zone ${response.body}');
    final res = json.decode(response.body);
    // var listPlace = res['data']['listPlace'];
    final listZone = res['data'];
    double result = 0;

    if (listZone != null) {

      for (var zone in listZone) {
       
       // print(listZone[j]);

        if (zone['listPlace'] != null) {

          final listPlace = zone['listPlace'];
 
              print('shop place : '+shop.place);

          for (var item in listPlace) {
              print('place _id : '+ item['_id']);
              print('priceSurcem zone _id : '+ zone['priceSurcem'].toString());
              print('priceSurcast zone _id : '+ zone['priceSurcast'].toString());

            if (shop.place == item['_id']) {
              // || shop.commune == item['name']
              if (product == 'Surecem') {
                result = double.parse(zone['priceSurcem'].toString());
              } else if (product == 'Surecast') {
                result = double.parse(zone['priceSurcast'].toString());
              }

            }

          }

        }

      //  return result;
      }
    }

    return result;
  }

  fetchOne(String id) async {
    //print('get all start');
    final bool isAuth = await userD.isAuth();
    //print('is auth $isAuth');
    if (!isAuth) {
      return null;
    } else {
      userM = await userD.getUser();

      token = await userD.getToken();
    }

    final myhead = {
      'content-type': 'application/json',
      'accept': 'application/json',
      'authorization': 'Bearer $token'
    };
// final _root = '$_root';
//final _root = 'https://admin.ppc-drc.com/api/v1';

    final response = await client.get('$_root/product/' + id, headers: myhead);
    final res = json.decode(response.body);

    if (res['success']) {
      //print('return data');

      return ProductModel.fromJson(res.data);
    } else {
      //print('return null');
      return null;
    }
  }
}
