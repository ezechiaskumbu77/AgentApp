import 'dart:convert';

import 'package:http/http.dart' show Client;

import '../service/UserData.dart';
import '../models/user.dart';

import '../models/product.dart';
import '../models/ShopProduct.dart';

final _root =
    'https://admin.ppc-drc.com/api/v1';//https://secure-sea-91184.herokuapp.com/api/v1';

class GetShopProduct {
  UserModel userM = UserModel();
  UserData userD = UserData();
  String token;
  Client client = Client();

  fetchAll(String shop) async {
    print('get all start');
    bool isAuth = await userD.isAuth();
    print('is auth $isAuth');
    if (!isAuth) {
      return null;
    } else {
      userM = await userD.getUser();

      token = await userD.getToken();
    }

    Map<String, String> myhead = {
      'content-type': 'application/json',
      'accept': 'application/json',
      'authorization': 'Bearer ${token}'
    };

    final response = await client.get(
        '$_root/shopproduct?shop=${shop}',
        headers: myhead);
    print('see the shopproduct  ${response.body}');
    final res = json.decode(response.body);

    if (res['success'] && (res['count'] >= 1)) {
      print('return data');

      return ShopProductFromJson(res['data']);
    }
    return null;
  }

  fetchOne(String id) async {
    print('get all start');
    bool isAuth = await userD.isAuth();
    print('is auth $isAuth');
    if (!isAuth) {
      return null;
    } else {
      userM = await userD.getUser();

      token = await userD.getToken();
    }

    Map<String, String> myhead = {
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
