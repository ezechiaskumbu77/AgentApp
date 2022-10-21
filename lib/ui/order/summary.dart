import 'dart:async';

import 'package:delivery_owner/models/orderItemPPC.dart';
import 'package:delivery_owner/models/orderPPC.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../ressources/getProduct.dart';
import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'selectAddress.dart';
import '../../ressources/setOrder.dart';





class Summary extends StatefulWidget {
  final OrderPPCModel order ;
  final OrderItemPPC surecast;
  final OrderItemPPC surecem;


  Summary(this.order, this.surecast, this.surecem);

  @override
  _SummaryState  createState() =>  _SummaryState();
}

class _SummaryState extends State<Summary> {
 // SetOrder setorder = SetOrder();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: 50,left: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  RaisedButton(
                      child: Text('Retour',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                      color: Colors.red,

                      onPressed: () {
                        Navigator.of(context).pop();
                      }),
                ],
              ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [



                  Container(

                    child: Center(child: Text('CONFIRMATION',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)),

                  ),
                  SizedBox(height: 10,),
                  Divider(height: 3,),
                  _body(context)

                ],
              ),





            ],
          ),
        ),
      ),
    );




  }


  Widget btnContinuer(BuildContext ctx) {

    return ArgonButton(
      height: 50,
      roundLoadingShape: true,
      width: MediaQuery.of(ctx).size.width * 0.7,
      onTap: (startLoading, stopLoading, btnState) {
        if (btnState == ButtonState.Idle) {
          startLoading();
          SetOrder  setO =   SetOrder();

          print('start save');
          setO.save(widget.order,  widget.surecast, widget.surecem).then((val) {
              if(val) {
                Navigator.pushNamedAndRemoveUntil(context, '/main', (r) => false);
                stopLoading();
 
                print('Data are save');
              } else {
                print('No save');
              }
 
          });
          print('End save');



        } else {
          stopLoading();
        }
      },
      child: Text(
        'Envoyer la commande',
        style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w700),
      ),
      loader: Expanded(
        child: Container(
            padding: EdgeInsets.all(10),
            child:  SpinKitWave(
                size: 16,
                color: Colors.white, type: SpinKitWaveType.start)
        ),
      ),
      borderRadius: 5.0,
      color: Colors.blueAccent,
    );
  }


  Widget _body(BuildContext cnt) {



    var total = widget.order.totalPrice ;
    var surecastAmmout= widget.surecast.price *  widget.surecast.quantity ;
    var surecemAmmout= widget.surecem.price *  widget.surecem.quantity ;
    var totalNet = surecastAmmout + surecemAmmout ;

    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(

          children: [

            Row(
              children: [
                Text('Surcast quantité : ', style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                Text('${widget.surecast.quantity}' , style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)
              ],
            ),

            SizedBox(height: 10,),
            Row(
              children: [
                Text('Surecem quantité : ', style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                Text('${widget.surecem.quantity}' , style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)
              ],
            ),

            SizedBox(height: 40,),
            widget.order.shippingPrice == 0 ? Text('Sans livraison' , style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16) ) :
            Row(
              children: [
                Text( 'Livraison : ', style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                Text('${widget.order.shippingPrice} FC' , style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)
              ],
            ) ,

            Row(
              children: [
                Text( 'Sous-total : ', style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                Text('${ totalNet } FC' , style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)
              ],
            ) ,
            Divider(),
            SizedBox(height: 20,),
            Row(
              children: [
                Text('Montant Total : ', style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                Text('${widget.order.totalPrice} FC' , style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)
              ],
            ),




            SizedBox(height: 10,),
           btnContinuer(cnt)


          ],
        ),
      ),
    );

  }
}
