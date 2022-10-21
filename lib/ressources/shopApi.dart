import 'dart:convert';
import 'dart:html';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' show Client;

import 'package:delivery_owner/models/Shop.dart';

Map<String, String> myhead = {
  'content-type': 'application/json',
  'accept': 'application/json',
  'authorization': 'basicAuth'
};
final _root = 'https://admin.ppc-drc.com/api/v1';//https://secure-sea-91184.herokuapp.com/api/v1';

class ShopApiProvider {
  Client client = Client();

  fetchAll() async {
    final response = await client.get('$_root/shop',
        headers: myhead);
    final res = json.decode(response.body);
    return res;
  }

  fetchOne(String id) async {
    final response = await client.get(
        '$_root/shop/$id',
        headers: myhead);
    final res = json.decode(response.body);

    if (res['success']) {
      return ShopModel.fromJson(res.data);
    } else {
      return null;
    }
  }

  createOne(Map<String, dynamic> data) async {
    final response = await client.post(
        '$_root/shop',
        headers: myhead,
        body: data);
    final res = json.decode(response.body);
    return res;
  }

  updateOne(String id, Map<String, dynamic> data) async {
    final response = await client.put(
        '$_root/shop/$id',
        headers: myhead,
        body: data);
    final res = json.decode(response.body);
    return res;
  }

  delete(String id) async {
    final response = await client.delete(
        '$_root/shop/$id',
        headers: myhead);
    final res = json.decode(response.body);
    return res;
  }
}
