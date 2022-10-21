
import 'dart:convert';

import 'package:delivery_owner/models/product.dart';
class ShopProductModel {
   String name ;
   String shop;
   String product;
   double startingInventory;
   double inventoryReceived;
   double inventorOnHand;
   double inventorShiped;
   double minimumRequired;
   double priceUsd;
   double priceFc;

   bool isDeleted;
   String id ;


   ShopProductModel(
     { this.name,
      this.shop,
      this.product,
      this.startingInventory,
      this.inventoryReceived,
      this.inventorOnHand,
      this.minimumRequired,
      this.priceUsd,
      this.priceFc,
       this.isDeleted,
       this.inventorShiped,
      this.id});

  ShopProductModel.fromJson(Map<String, dynamic> parsedJson):

        name = parsedJson['name'],
        shop = parsedJson['shop'],
        product = parsedJson['product']['name'] ,
        startingInventory = parsedJson['startingInventory'].toDouble(),
        inventoryReceived =  parsedJson['inventoryReceived'].toDouble(),
        inventorShiped =  parsedJson['inventorShiped'].toDouble(),
         inventorOnHand = parsedJson['inventorOnHand'].toDouble(),
        minimumRequired =  parsedJson['minimumRequired'].toDouble(),
         priceUsd =  parsedJson['priceUsd']==null? 0 :  double.parse(parsedJson['priceUsd']) ,
        priceFc =  parsedJson['priceFc']==null? 0 :  double.parse(parsedJson['priceFc']) ,

        id =  parsedJson['_id'];



  Map<String, dynamic> toMap(){
    return <String,dynamic> {
      'name' : name,
      'isDeleted' : isDeleted,
      '_id': id,

    };

  }





}


List<ShopProductModel> ShopProductFromJson( dynamic jsonData) {
  // print('Strat here ${jsonData}');
  // final data = jsonDecode(jsonData);
  List<ShopProductModel> listAll = List<ShopProductModel>.from(jsonData.map( (item){
     print('see data $item');
    ShopProductModel shop = ShopProductModel.fromJson(item);
     print('done');
    return shop ;} ) );
//  print('russell voici ${data['data']}');

  print('All are Success');
  return listAll;
}

