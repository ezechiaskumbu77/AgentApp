import 'dart:convert';

import 'package:http/http.dart' show Client;

import '../service/UserData.dart';
import '../models/user.dart';

import '../models/product.dart';
import '../models/ShopProductStock.dart';

// final _root = '$_root';
// final _root = '$_root';
final _root = 'https://admin.ppc-drc.com/api/v1';

class GetShopProductStock {
  UserModel userM = UserModel();
  UserData userD = UserData();
  String token;
  Client client = Client();

  fetchAll(String shop) async {
   // print('get all start');
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
      'authorization': 'Bearer ${token}'
    };

    final response = await client.get('$_root/shopproduct?shop=${shop}', headers: myhead);
    //print('see the  products  ${response.body}');
    final res = json.decode(response.body);

    //if (res['data']!=null) {
     // print('return data');

      return res['data'];
//  ShopProductStockModelFromJson(
      
   // }
   // return null;
  }

  fetchOne(String id) async {
    print('get all start');
    final bool isAuth = await userD.isAuth();
    print('is auth $isAuth');
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

    final response = await client
        .get('$_root/product/$id', headers: myhead);
    final res = json.decode(response.body);

    if (res['success']) {
      print('return data');

      return ProductModel.fromJson(res.data);
    } else {
      print('return null');
      return null;
    }
  }
}
