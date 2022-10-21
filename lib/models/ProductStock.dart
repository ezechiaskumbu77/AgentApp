
import 'dart:convert';

import 'package:delivery_owner/models/product.dart';
class ProductStockModel {
   String name ;
   String shop;

   int startingInvertory;
   int inventoryReceived;
   int inventorOnHand;
   int inventorShiped;
   int minimumRequired;
   String deviseType;
   String description;
   String price ;
   int date ;

   bool isDeleted;
   String id ;


   ProductStockModel(
     { this.name,
      this.shop,

      this.startingInvertory,
      this.inventoryReceived,
      this.inventorOnHand,
      this.minimumRequired,
      this.deviseType,
      this.price,
       this.isDeleted,
       this.inventorShiped,
       this.description,
      this.id , this.date});

   ProductStockModel.fromJson(Map<String, dynamic> parsedJson):

        name = parsedJson['name'],
        shop = parsedJson['shop'],

         startingInvertory = parsedJson['startingInvertory'],
        inventoryReceived =  parsedJson['inventoryReceived'],
        inventorShiped =  parsedJson['inventorShiped'],
         inventorOnHand = parsedJson['inventorOnHand'],
        minimumRequired =  parsedJson['minimumRequired'],
         price = parsedJson['price'].toString(),
         deviseType =  parsedJson['deviseType'] ,
         description =  parsedJson['description'] ,

   date = int.parse(parsedJson['date']) ,
        id =  parsedJson['_id'];



  Map<String, dynamic> toMap(){
    return <String,dynamic> {
      "name" : name,
      "isDeleted" : isDeleted,
      "_id": id,

    };

  }





}


List<ProductStockModel> ProductStockModelFromJson( dynamic jsonData) {
  // print("Strat here ${jsonData}");
  // final data = jsonDecode(jsonData);
  List<ProductStockModel> listAll = List<ProductStockModel>.from(jsonData.map( (item){
     print("see data $item");
     ProductStockModel shop = ProductStockModel.fromJson(item);
     print("done");
    return shop ;} ) );
//  print("russell voici ${data['data']}");

  print("All are Success");
  return listAll;
}

