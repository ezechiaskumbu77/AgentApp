import 'dart:convert';

 
import 'package:delivery_owner/models/complaintProduct.dart'; 

class ComplaintModel {
  String edited;
  String byUser;
  var orderId;
  String id;
  var qualificationBody;
  int qualificationId;
  String whenMade;
  String status = 'opened';
  var messages;

  ComplaintModel(
      {this.edited,
      this.byUser,
      this.orderId,
      this.id,
      this.qualificationId,
      this.qualificationBody,
      this.whenMade,
      this.status,
      this.messages});

  ComplaintModel.fromJson(Map<dynamic, dynamic> parsedJson)
      : edited = parsedJson['edited'],
        byUser = parsedJson['byUser'],
        orderId = parsedJson['orderId'],
        id = parsedJson['_id'],
        qualificationBody = parsedJson['qualificationBody'],
        whenMade = parsedJson['whenMade'],
        status = parsedJson['status'],
        messages = parsedJson['messages'];

  Map<String, dynamic> toJson() {
    
    var qty=0;
    if (qualificationBody is ComplaintProduct ) {
      qty=qualificationBody.qty;
    }  

    return <String, dynamic>{
      // 'comment': comment,
      // 'edited': edited,
      'byUser': byUser,
      'orderId': orderId,
      '_id': id,
      'complaint': {
        'qty': qty,
        'evaluation': qualificationBody.evaluation
      },
      // 'qualificationBody': qualificationBody,
      'qualificationId': qualificationId,
      // 'whenMade': whenMade,
    //  'status': status,
     // 'messages': messages
    };
  }
}

List<ComplaintModel> ComplaintModelFromJson(dynamic jsonData) {

  final listAll = List<ComplaintModel>.from(jsonData.map((item) {
    print('see data ${item}');
    final list = ComplaintModel.fromJson(item);

    return list;
  }));

  print('All are Success');
  return listAll;
}

ComplaintModel OneComplaintModelFromJson(dynamic jsonData) {
  final data = json.decode(jsonData);

//  print('russell voici ${data['data']}');
  return ComplaintModel.fromJson(data['data']);
}
