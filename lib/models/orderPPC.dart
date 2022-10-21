import 'dart:convert';

import 'package:delivery_owner/models/complaint.dart';

class OrderPPCModel {
  String WhenMade;
  String customer;
  String status;
  double shippingPrice=0  ;
  bool toBeShipied ;
  String shop;
  String paymentMethode;
  bool IsPayed;
  double totalPrice;
  String deliverCode;
  String details;
  String shippingAdress;
  ComplaintModel complaint;
  bool isDeleted;
  String id;

  OrderPPCModel(
      {this.id,
      this.WhenMade,
      this.customer,
      this.status,
      this.shop,
      this.paymentMethode,
      this.IsPayed,
      this.totalPrice,
      this.details,
      this.shippingAdress,
      this.isDeleted,
      this.deliverCode,
      this.complaint});

  OrderPPCModel.fromJson(Map<String, dynamic> parsedJson)
      : id = parsedJson['_id'],
        WhenMade = parsedJson['WhenMade'],
        customer = parsedJson['customer'],
        status = parsedJson['status'],
        shop = '',//parsedJson['shop']['name'], //
        toBeShipied  = false,//parsedJson['toBeShipied'],
        shippingPrice= 0,//double.parse(parsedJson['shippingPrice'].toString()),
        paymentMethode = parsedJson['paymentMethode'], //
        IsPayed = parsedJson['IsPayed'], //
        totalPrice = parsedJson['totalPrice'].toDouble(), //
        details = parsedJson['details'], //
        shippingAdress = parsedJson['shippingAdress'], //
        deliverCode = parsedJson['deliverCode'].toString(), //
        isDeleted = parsedJson['isDeleted'];

  Map<String, dynamic> toJson() {
    return <String, dynamic>{ 
      'customer': customer,
      'shop': shop,
      'paymentMethode': paymentMethode,
      'totalPrice': totalPrice,
      'shippingPrice': shippingPrice,
       'toBeShipied': toBeShipied,
      'shippingAdress': shippingAdress,
    };
  }
}

List<OrderPPCModel> OrderPPCModelFromJson(dynamic jsonData) {
  // print('Strat here ${jsonData}');
  // final data = jsonDecode(jsonData);
  List<OrderPPCModel> listAll = List<OrderPPCModel>.from(jsonData.map((item) {
    // print('see data $item');
    OrderPPCModel order = OrderPPCModel.fromJson(item);
      print('done ${order.paymentMethode}');
    return order;
  }));
//  print('russell voici ${data['data']}');

 // print('All are Success');
  return listAll;
}

OrderPPCModel OneOrderPPCModelFromJson(dynamic jsonData) {
  final data = json.decode(jsonData);

//  print('russell voici ${data['data']}');
  return OrderPPCModel.fromJson(data['data']);
}
