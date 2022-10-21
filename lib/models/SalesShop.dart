
import 'dart:convert';

import 'package:delivery_owner/models/ProductStock.dart';
import 'package:delivery_owner/models/ShopProduct.dart';
import 'package:delivery_owner/models/product.dart';
class SaleShopModel {
  int number ;
  String shopproduct;
  String deviseType;
  double price;
  String shop ;
  int date ;
  String id ;
  double discount ;
  double prixTotal ;



  SaleShopModel({this.number, this.shopproduct, this.deviseType, this.price,
      this.shop, this.id, this.date , this.discount, this.prixTotal});

  SaleShopModel.fromJson(Map<String, dynamic> parsedJson):

        number = int.parse(parsedJson['number']) ,
        shopproduct =parsedJson['shopproduct'] ,
        deviseType =parsedJson['deviseType'],
        price = double.parse(parsedJson['price']) ,
        discount = double.parse(parsedJson['discount']) ,
        prixTotal = double.parse(parsedJson['prixTotal']) ,
        shop =  parsedJson['shop'],
        date = int.parse(parsedJson['date']) ,
        id =  parsedJson['_id'];



  Map<String, dynamic> toMap(){
    return <String,dynamic> {
      "number" : number,
      "price" : price,
      "_id": id,

    };

  }





}


List<SaleShopModel> SaleShopModelFromJson( dynamic jsonData) {
  // print("Strat here ${jsonData}");
  // final data = jsonDecode(jsonData);
  List<SaleShopModel> listAll = List<SaleShopModel>.from(jsonData.map( (item){
    print("see data $item");
    SaleShopModel shop = SaleShopModel.fromJson(item);
    print("done");
    return shop ;} ) );
//  print("russell voici ${data['data']}");

  print("All are Success");
  return listAll;
}

