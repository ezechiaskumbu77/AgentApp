
import 'dart:convert';

import 'package:delivery_owner/models/ProductStock.dart';
import 'package:delivery_owner/models/product.dart';
class SalesStockModel {
  int number ;
  String productStock;
  String deviseType;
  double price;
  String shop ;
  String id ;
  int date ;


  SalesStockModel({this.number, this.productStock, this.deviseType, this.price,
      this.shop, this.id, this.date});

  SalesStockModel.fromJson(Map<String, dynamic> parsedJson):

        number = int.parse(parsedJson['number']),
        productStock = parsedJson['productStock'],
        deviseType =parsedJson['deviseType'],
        price = double.parse(parsedJson['price']) ,
        shop =  parsedJson['shop'],
        date =  int.parse(parsedJson['date']),
        id =  parsedJson['_id'];



  Map<String, dynamic> toMap(){
    return <String,dynamic> {
      "number" : number,
      "price" : price,
      "_id": id,

    };

  }





}


List<SalesStockModel>SalesStockModelFromJson( dynamic jsonData) {
  // print("Strat here ${jsonData}");
  // final data = jsonDecode(jsonData);
  List<SalesStockModel> listAll = List<SalesStockModel>.from(jsonData.map( (item){
    print("see data $item");
    SalesStockModel shop = SalesStockModel.fromJson(item);
    print("done");
    return shop ;} ) );
//  print("russell voici ${data['data']}");

  print("All are Success");
  return listAll;
}

