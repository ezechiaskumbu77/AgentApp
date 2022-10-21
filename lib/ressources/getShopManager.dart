import 'dart:convert';

import 'package:http/http.dart' show Client;

import '../models/orderItemPPC.dart';
import '../models/shopManager.dart';
import '../service/UserData.dart';
import '../models/user.dart';

final _root = 'https://admin.ppc-drc.com/api/v1';//https://secure-sea-91184.herokuapp.com/api/v1';

class GetShopManager {
  UserModel userM = UserModel();
  UserData userD = UserData();
  String token;
  Client client = Client();

  fetchAll() async {
    print('item start');
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
        '$_root/shopmanager?createdBy=${userM.id}&isDeleted=false',
        headers: myhead);
    //  print('see the orders ${response.body}');
    final res = json.decode(response.body);

    if (res['success'] && (res['count'] >= 1)) {
      return ManagerModelFromJson(res['data']);
    }
    print('find nothing');
    return null;
  }

  postItemOrder(OrderItemPPC item, String id) async {
    print('see this id $id');
    item.orderID = id;
    print('item start');
    bool isAuth = await userD.isAuth();
    print('is auth $isAuth');
    if (!isAuth) {
      return null;
    } else {
      userM = await userD.getUser();

      token = await userD.getToken();
    }
    print('end getter');

    Map<String, String> myhead = {
      'content-type': 'application/json',
      'accept': 'application/json',
      'authorization': 'Bearer ${token}'
    };
    print('after myhead ${item.toJson()}');
    final response = await client.post(
        '$_root/orderitemppc',
        headers: myhead,
        body: jsonEncode(item.toJson()));

    print('after the request');
    print('see the orders ${response.body}');
    final res = json.decode(response.body);

    if (res['success']) {
      print('Before');
      return true;
    }
    // print('find nothing');
    return null;
  }

  fetchOne(String id, String token) async {
    final myhead = {
      'content-type': 'application/json',
      'accept': 'application/json',
      'authorization': 'Bearer $token'
    };

    final response = await client.get(
        '$_root/shop/$id',
        headers: myhead);
    final res = json.decode(response.body);

    if (res['success']) {
      return OrderItemPPC.fromJson(res.data);
    } else {
      return null;
    }
  }
}
