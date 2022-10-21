import 'dart:convert';

import 'package:http/http.dart' show Client;

import '../models/orderPPC.dart';
import '../service/UserData.dart';
import '../models/user.dart';

final _root = 'https://admin.ppc-drc.com/api/v1';
//final _root = 'https://secure-sea-91184.herokuapp.com/api/v1';

class GetOrder {
  UserModel userM = UserModel();
  UserData userD = UserData();
  String token;
  Client client = Client();

  fetchAll() async {
    print('get all orders');
    bool isAuth = await userD.isAuth();
    // print('is auth $isAuth');
    if (!isAuth) {
      return null;
    } else {
      userM = await userD.getUser();

      token = await userD.getToken();
    }

    var myhead = <String, String>{
      'content-type': 'application/json',
      'accept': 'application/json',
      'authorization': 'Bearer ${token}'
    };

    //GET AGENT INFO
    final respAgent = await client.get('$_root/agent?userID=${userM.id}', headers: myhead);

    final resAgentJson = json.decode(respAgent.body);

    //    print(resAgentJson);
   // print('Agent juste apres');
  //  print(resAgentJson['data']);

    final zoneAgent = resAgentJson['data'][0]['zone'].toString();
    //print(zoneAgent);

    //GET ZONE LIST PLACES BY ZONE OF AGENT
    final respZone =
        await client.get('$_root/zone/' + zoneAgent, headers: myhead);

    final resZoneJson = json.decode(respZone.body);

    //print('zone juste apres');
  //  print(resZoneJson['data']);
    // print(resZoneJson['data']['listPlace']);

    final zoneListPlaces = resZoneJson['data']['listPlace'];

    var listorders = <OrderPPCModel>[];

    for (var i = zoneListPlaces.length - 1; i >= 0; i--) {

      final respShop = await client.get('$_root/shop/?place=' + zoneListPlaces[i], headers: myhead);

      final respShopJson = json.decode(respShop.body);

      if (respShopJson['data'].length != 0) {
        //  print(respShopJson['data']);

        final zoneListShop = respShopJson['data'];

        //  for (var shop in respShopJson['data']) {
        for (var j = zoneListShop.length - 1; j >= 0; j--) {
         
          final response = await client.get( '$_root/orderppc/?shop=' + zoneListShop[j]['_id'], headers: myhead);

          final res = json.decode(response.body);

          if (int.parse(res['count'].toString()) >= 1) {

            final orders  = OrderPPCModelFromJson(res['data']);

            for (var item in orders) { 
              listorders.add(item); 
            }

          }

          /*else {
            return null;
          }*/

          // final response = await client.get('$_root/orderppc', headers: myhead);
          //print('see the orders ${response.body}');
          // final res = json.decode(response.body);

          // if (res['success'] && (res['count'] >= 1)) {

          //   return OrderPPCModelFromJson(res['data']);

          // }
          //  print(zoneListZone[j]);
          /* print("1:"+zoneListZone[j]['name'] );
          print("2:"+    zoneListZone[j]['shopOnwer'] );
           print( "3:"+  zoneListPlaces[i]);
           print( "4:"+  zoneListZone[j]['createdBy'] );
          print(   "5:"+ zoneListZone[j]['capacity'] );
         print( "6:"+    zoneListZone[j]['address'] );
       //  print(  "7:"+   zoneListZone[j]['isDeleted'] );
         print( "8:"+    zoneListZone[j]['_id'] );
         print( "9:"+    zoneListZone[j]['description'] );
          print("10:"+    zoneListZone[j]['shopManager'] );
          print( "11:"+   zoneListZone[j]['province'] );
          print("12:"+    zoneListZone[j]['commune'] );
          print( "13:"+   zoneListZone[j]['ville']);
*/

        }
      }
    }
    listorders.reversed;
     return listorders;
  }

  postOrder(OrderPPCModel orderP) async {
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
    orderP.customer = userM.id;
    final response = await client.post('$_root/orderppc',
        headers: myhead, body: jsonEncode(orderP.toJson()));
    print('see the orders ${response.body}');
    final res = json.decode(response.body);

    if (res['success']) {
      // return OrderPPCModel.fromJson(res['data']);
        return res['data']['_id'];
    }
    return null;
  }

  fetchOne(String id, String token) async {
    Map<String, String> myhead = {
      'content-type': 'application/json',
      'accept': 'application/json',
      'authorization': 'Bearer $token'
    };

    final response = await client.get('$_root/orderppc/$id', headers: myhead);
    final res = json.decode(response.body);

    if (res['success']) {
      return OrderPPCModel.fromJson(res.data);
    } else {
      return null;
    }
  }
}
