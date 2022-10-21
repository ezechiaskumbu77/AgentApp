

import 'package:flutter/material.dart';

class UserModel {

   String role ;
   bool isShopmanager ;
  bool isDeliverCorp ;
   bool hasShop ;
   String  id ;
  String name ;
  String email ;
   String phone ;
   String sexe;
   String address;
   String province;
   String commune;
   String ville;
   String birthday;
   String photo_url;

UserModel({
  this.role,
    this.isShopmanager,
   this.isDeliverCorp,
     this.hasShop,
      this.id,
    this.name,
     this.email,
   this.phone,
   this.sexe,
  this.address,
  this.birthday,
  this.photo_url,
  this.commune,
  this.province,
  this.ville


}
   );

 UserModel.fromJson(Map<String, dynamic> parsedJson):

  id = parsedJson['_id'],
  role = parsedJson['role'],
  isShopmanager = parsedJson['isShopmanager'],
  isDeliverCorp = parsedJson['isDeliverCorp'],
  hasShop = parsedJson['hasShop'],
  name = parsedJson['name'],
  email = parsedJson['email'],
  sexe = parsedJson['sexe'],
  phone = parsedJson['phone'],
 address = parsedJson['address'],
 photo_url = parsedJson['photo_url'],
       birthday = parsedJson['birthday'],
       commune = parsedJson['commune'],
       province = parsedJson['province'],
       ville = parsedJson['ville'];

Map<String,dynamic>  toJson(){


  return <String,dynamic> {
  "_id" : id,
  "role" : role,
  "isShopmanager" : isShopmanager,
  "isDeliverCorp" : isDeliverCorp,
  "hasShop" : hasShop,
  "name" : name,
  "email": email,
  "phone" : phone,
  "sexe" : sexe,
    "address" : address,
    "birthday" : birthday,
    "photo_url" : photo_url
  };
}



}