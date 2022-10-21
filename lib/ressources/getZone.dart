import 'dart:convert';

import 'package:http/http.dart' show Client;

import '../models/Shop.dart';
import '../service/UserData.dart';
import '../models/user.dart';

// final _root = '$_root';
// final _root = '$_root';
final _root = 'https://admin.ppc-drc.com/api/v1';

class GetZone {
  UserModel userM = UserModel();
  UserData userD = UserData();
  String token;
  Client client = Client();

  getZoneShippingPrice(shop) async {
    // print('get all start');
    final bool isAuth = await userD.isAuth();
     
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
       
       // print(zone);

        if (zone['listPlace'] != null) {

          final listPlace = zone['listPlace'];

          print(listPlace);

          for (var item in listPlace) {

           if (shop.place == item['_id']) {
              
              result = double.parse(zone['shippingPrice'].toString());
              
            }
          }
        }

       
      }
    }

    return result;
  }

}
