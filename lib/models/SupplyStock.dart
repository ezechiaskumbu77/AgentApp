
import 'dart:convert';

import 'package:delivery_owner/models/ProductStock.dart';
import 'package:delivery_owner/models/product.dart';
class SupplyStockModel {
  int number ;
  String productStock;


  String shop ;

  String id ;
  int date ;


  SupplyStockModel({this.number, this.productStock,
      this.shop, this.id , this.date});

  SupplyStockModel.fromJson(Map<String, dynamic> parsedJson):

        number = int.parse(parsedJson['number']),
        productStock = parsedJson['productStock'],
        date = int.parse(parsedJson['date']) ,

        shop =  parsedJson['shop'],
        id =  parsedJson['_id'];



  Map<String, dynamic> toMap(){
    return <String,dynamic> {
      "number" : number,

      "_id": id,

    };

  }





}


List<SupplyStockModel> SupplyStockModelFromJson( dynamic jsonData) {
  // print("Strat here ${jsonData}");
  // final data = jsonDecode(jsonData);
  List<SupplyStockModel> listAll = List<SupplyStockModel>.from(jsonData.map( (item){
    print("see data $item");
    SupplyStockModel shop = SupplyStockModel.fromJson(item);
    print("done");
    return shop ;} ) );
//  print("russell voici ${data['data']}");

  print("All are Success");
  return listAll;
}

