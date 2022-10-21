import 'dart:convert';

import 'package:http/http.dart' show Client;

import 'package:delivery_owner/models/Shop.dart';
import '../service/UserData.dart';
import '../models/user.dart';

//final _root = "https://secure-sea-91184.herokuapp.com/api/v1";
// final _root = 'http://192.168.1.163:8080/api/v1';
final _root = 'https://admin.ppc-drc.com/api/v1';

class GetShop {
  UserModel userM = UserModel();
  UserData userD = UserData();
  String token;
  Client client = Client();

  fetchAll() async {
    ////print(('get all shop');
    bool isAuth = await userD.isAuth();
    //////print(('is auth $isAuth');
    if (!isAuth) {
      return null;
    } else {
      userM = await userD.getUser();

      token = await userD.getToken();
    }

    final myhead = <String, String>{
      'content-type': 'application/json',
      'accept': 'application/json',
      'authorization': 'Bearer ${token}'
    };

    //GET AGENT INFO
    final respAgent =
        await client.get('$_root/agent?userID=${userM.id}', headers: myhead);

    final resAgentJson = json.decode(respAgent.body);

    final zoneAgent = resAgentJson['data'][0]['zone'].toString();
    //print(zoneAgent);

    //GET ZONE LIST PLACES BY ZONE OF AGENT
    final respZone =  await client.get('$_root/zone/' + zoneAgent, headers: myhead);
   
    final resZoneJson = json.decode(respZone.body);

    final zoneListPlaces = resZoneJson['data']['listPlace'];
     //print(zoneListPlaces);
    var listshops = <ShopModel>[];

    for (var i = zoneListPlaces.length - 1; i >= 0; i--) {
      // var respShop = await client.get(
      //     '$_root/shop/?place=' +
      //         zoneListPlaces[i],
      //     headers: myhead);
      //print(i.toString()+ ' : ' + zoneListPlaces[i]);
      /*var respShop = await client.get(
          '$_root/shop/?commune=' + zoneListPlaces[i]['name'],
          headers: myhead);

      var respShopJson = json.decode(respShop.body);

      if (respShopJson['data'].length != 0) {
        //  ////print((respShopJson['data']);

        final zoneListZone = respShopJson['data'];

        //  for (var shop in respShopJson['data']) {
        for (var j = zoneListZone.length - 1; j >= 0; j--) {
          listshops.add(ShopModel(
              zoneListZone[j]['name'],
              zoneListZone[j]['shopOnwer'],
              zoneListPlaces[i],
              zoneListZone[j]['createdBy'],
              zoneListZone[j]['capacity'],
              zoneListZone[j]['address'],
              zoneListZone[j]['isDeleted'],
              zoneListZone[j]['_id'],
              zoneListZone[j]['description'],
              zoneListZone[j]['shopManager'],
              zoneListZone[j]['province'],
              zoneListZone[j]['commune'],
              zoneListZone[j]['ville']));
        }
      }*/
    var  respShop = await client.get(
          '$_root/shop/?place=' + zoneListPlaces[i],
          headers: myhead);

    var  respShopJson = json.decode(respShop.body);

      if (respShopJson['data'].length != 0) {
        //  ////print((respShopJson['data']);

        final zoneListZone = respShopJson['data'];

        //  for (var shop in respShopJson['data']) {
        for (var j = zoneListZone.length - 1; j >= 0; j--) {
          listshops.add(ShopModel(
              zoneListZone[j]['name'],
              zoneListZone[j]['shopOnwer'],
              zoneListPlaces[i],
              zoneListZone[j]['createdBy'],
              zoneListZone[j]['capacity'],
              zoneListZone[j]['address'],
              zoneListZone[j]['isDeleted'],
              zoneListZone[j]['_id'],
              zoneListZone[j]['description'],
              zoneListZone[j]['shopManager'],
              zoneListZone[j]['province'],
              zoneListZone[j]['commune'],
              zoneListZone[j]['ville']));
        }
      }
    }

    return listshops;
  }

  fetchOne(String id, String token) async {
    Map<String, String> myhead = {
      'content-type': 'application/json',
      'accept': 'application/json',
      'authorization': "Bearer $token"
    };

    final response = await client.get("$_root/shop/$id", headers: myhead);
    final res = json.decode(response.body);

    if (res['success']) {
      return ShopModel.fromJson(res.data);
    } else {
      return null;
    }
  }
}
