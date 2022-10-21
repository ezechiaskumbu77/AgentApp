import 'dart:convert';

import 'package:delivery_owner/models/complaint.dart';
import 'package:delivery_owner/models/complaintLogistic.dart';
import 'package:delivery_owner/models/complaintPrice.dart';
import 'package:delivery_owner/models/complaintProduct.dart';
import 'package:delivery_owner/models/complaintService.dart';
import 'package:http/http.dart' show Client;

import '../service/UserData.dart';
import '../models/user.dart';

//final _root = 'https://secure-sea-91184.herokuapp.com/api/v1';
//final _root = 'https://secure-sea-91184.herokuapp.com/api/v1';
final _root = 'https://admin.ppc-drc.com/api/v1';//http://192.168.1.163:8080/api/v1';

//final _root = 'http://192.168.43.62:8080/api/v1';

class GetComplaint {
  UserModel userM = UserModel();
  UserData userD = UserData();
  String token;
  Client client = Client();

  fetchAll() async {
    print('get all complaint');
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
      'authorization': 'Bearer ${token}'
    };
    

    final response = await client.get(
        '$_root/complaint?byUser=${userM.id}',
        headers: myhead);
    //print('see the complaints ${response.body}');
    final res = json.decode(response.body);
    var listcomplaints = <ComplaintModel>[];

    if (res['success'] && (res['count'] >= 1)) {
      //return ComplaintModelFromJson(res['data']);
      final complaintListjson = res['data'];
      // print(complaintListjson);
      //  for (var shop in respShopJson['data']) {
      for (var j = complaintListjson.length - 1; j >= 0; j--) {
        //  print(complaintListjson[j]);

        var qualificationBody;
        if (complaintListjson[j]['qualificationId'] == 1) {
          qualificationBody = ComplaintLogistic.withoutEnumVal(
              complaintListjson[j]['complaint']['evaluation']);
        } else if (complaintListjson[j]['qualificationId'] == 3) {
          qualificationBody = ComplaintPrice.withoutEnumVal(
              complaintListjson[j]['complaint']['evaluation']);
        } else if (complaintListjson[j]['qualificationId'] == 2) {
          qualificationBody = ComplaintService.withoutEnumVal(
              complaintListjson[j]['complaint']['evaluation']);
        } else if (complaintListjson[j]['qualificationId'] == 4) {
          qualificationBody = ComplaintProduct(
            complaintListjson[j]['complaint']['evaluation'],
            int.parse(complaintListjson[j]['complaint']['qty'].toString()),
          );
        }
        //   print(complaintListjson[j]['complaint']['evaluation']);
        var item = ComplaintModel(
          edited: complaintListjson[j]['edited'],
          byUser: userM
              .id, //  (complaintListjson[j]['byUser']!=null)? complaintListjson[j]['byUser'] : 'nothing',
          orderId: (complaintListjson[j]['orderId'] != null)
              ? complaintListjson[j]['orderId']
              : 'nothing',
          id: complaintListjson[j]['_id'],
          qualificationId: complaintListjson[j]['qualificationId'],
          qualificationBody: qualificationBody,
          whenMade: complaintListjson[j]['whenMade'],
          status: complaintListjson[j]['status'],
          messages: null, //complaintListjson[j]['messages']
        );
        listcomplaints.add(item);
      }
    }
    return listcomplaints;
  }

  fetchAllMessageByComplaint(complaint) async {
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
      'authorization': 'Bearer ${token}'
    };

    final response = await client.get(
        '$_root/complaint/' +
            complaint.id,
        headers: myhead);
    // print('see the complaints ${response.body}');

    final res = json.decode(response.body);
    //  print(res);

    final messageList = res['data']['messages'];
    print(messageList);
    //if (messageList!=null) {
    return messageList; //ComplaintModelFromJson(res['data']);
    //}
    //return null;
  }

  postComplaint(ComplaintModel complaintP) async {
    print('get start post');
    final bool isAuth = await userD.isAuth();
    print('is auth $isAuth');

    if (!isAuth) {
      // return null;
      token =
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjYwMjViYzVmODM2YjU0MDAxNzAyNDI5MSIsImlhdCI6MTYxNTIxNDM4MSwiZXhwIjoxNjE3ODA2MzgxfQ.HQBLyysXF_FRYq2ECkg8CKKLoh5utL_ohPYal7BZ2mI';
    } else {
      userM = await userD.getUser();

      token = await userD.getToken();
    }

    final myhead = {
      'content-type': 'application/json',
      'accept': 'application/json',
      'authorization': 'Bearer ${token}'
    };
    complaintP.byUser = userM.id;

    //  print(complaintP.qualificationBody.evaluation);

    final response = await client.post(
        '$_root/complaint/',
        headers: myhead,
        body: jsonEncode(complaintP.toJson()));

    // print('see the complaints ${response.body}');

    final res = json.decode(response.body);

    if (res['success']) {
      return true;
    }
    return false;
  }

  complaintMessage(ComplaintModel complaintP, message) async {
    final bool isAuth = await userD.isAuth();
    print('is auth $isAuth');
    if (!isAuth) {
      // return null;
      token =
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjYwMjViYzVmODM2YjU0MDAxNzAyNDI5MSIsImlhdCI6MTYxNTIxNDM4MSwiZXhwIjoxNjE3ODA2MzgxfQ.HQBLyysXF_FRYq2ECkg8CKKLoh5utL_ohPYal7BZ2mI';
    } else {
      userM = await userD.getUser();

      token = await userD.getToken();
    }

    final myhead = {
      'content-type': 'application/json',
      'accept': 'application/json',
      'authorization': 'Bearer ${token}'
    };

    complaintP.byUser = userM.id;

    var response = await client.get(
        '$_root/complaint/' +
            complaintP.id,
        headers: myhead);
    // print('see the complaints ${response.body}');

    var res = json.decode(response.body);
    //  print(res);

    final messageList = res['data']['messages'];
    print(messageList);

    if (messageList != null) {
      var _data = [
        {
          'body': message.toString(),
          'by': 'Moi',
          'created': DateTime.now().toString()
        }
      ];

      for (var item in messageList) {
        _data.add({
          'body': item['body'],
          'by': item['by'],
          'created': item['created']
        });
      }

      //messageList.add({'body': message.toString(), 'by': 'Moi'});

      //     _data = jsonEncode({'messages': _data});

      final _datatojson = jsonEncode({'messages': _data});

      print('complaint ID : ' + complaintP.id);

      response = await client.put(
          '$_root/complaint/' +
              complaintP.id,
          headers: myhead,
          body: _datatojson);

      print('see the complaints ${response.body}');

      res = json.decode(response.body);

      if (res['success'] == true || res['success'] == 'true') {
        return true;
      }
      return false;
    } else {
      var _data = [
        {
          'body': message.toString(),
          'by': 'Moi',
          'created': DateTime.now().toString()
        }
      ];

      final _datatojson = jsonEncode({'messages': _data});

      print('complaint ID : ' + complaintP.id);

      response = await client.put(
          '$_root/complaint/' +
              complaintP.id,
          headers: myhead,
          body: _datatojson);

      print('see the complaints ${response.body}');

      res = json.decode(response.body);

      if (res['success'] == true || res['success'] == 'true') {
        return true;
      }
      return false;
    }
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
      return ComplaintModel.fromJson(res.data);
    } else {
      return null;
    }
  }
}
