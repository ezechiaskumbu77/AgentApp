


import 'dart:convert';


import 'package:http/http.dart' show Client;

import '../models/orderPPC.dart';
import '../models/orderItemPPC.dart';

import '../ressources/getOrdersApi.dart';
import '../ressources/getOrdersItemApi.dart';





class SetOrder {
  GetOrderItem getOrderItem = GetOrderItem() ;
  GetOrder getOrder = GetOrder();





 save(OrderPPCModel ord , OrderItemPPC surcast, OrderItemPPC surcemen) async {
   print('see your thing ${ord.totalPrice} and  ${surcast.quantity} and ${surcemen.price}'  );
var value = await getOrder.postOrder(ord);

   if(value==null){
     print('value are null');
     return false;
   } else {

     if(surcast.quantity>=1){
       await  getOrderItem.postItemOrder(surcast, value);
     }

     if(surcemen.quantity>=1){
       await getOrderItem.postItemOrder(surcemen, value);
     }


      print('first finish');
      //getOrderItem.postItemOrder(surcemen, value.id);
     return true ;

   }


 }





}



