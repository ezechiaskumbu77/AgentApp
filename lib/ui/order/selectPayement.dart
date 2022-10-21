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
import 'summary.dart';





class SelectPayement extends StatefulWidget {

  final OrderPPCModel order ;

  final OrderItemPPC surecast;
  final OrderItemPPC surecem;


  SelectPayement(this.order, this.surecast, this.surecem);
  @override
  _SelectPayementState  createState() =>  _SelectPayementState();
}

class _SelectPayementState extends State<SelectPayement> {
 OrderPPCModel orderEdit  ;

  GetProduct pro;
  // getAllProduct () async {
  //   pro = GetProduct();

  //   return await  pro.fetchAll();

  // }


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
                      child: Text("Retour",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
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

                    child: Center(child: Text("Choisir le type de payement",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)),

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

    return Padding(
      padding: const EdgeInsets.only(left:20.0),
      child: Column(

        children: [

         SizedBox(height: 10,),
          Row(
            children: [
              Icon(Icons.money),
              SizedBox(width: 10,),
              ArgonButton(
                height: 50,

                roundLoadingShape: true,
                width: MediaQuery.of(ctx).size.width * 0.7,
                padding: EdgeInsets.all(5),
                onTap: (startLoading, stopLoading, btnState) {
                  if (btnState == ButtonState.Idle) {
                    startLoading();

                    Timer(const Duration(milliseconds: 1000), () {
                      widget.order.paymentMethode = "mobile money";

                      Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => Summary( widget.order,widget.surecast,widget.surecem)
                          )
                      );
                      stopLoading();
                    });

                  } else {
                    stopLoading();
                  }
                },
                child: Column(
                  children: [
                    Text(

                      "Payer Via  MPESA ",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w700),
                    ),

                  ],
                ),
                loader: Expanded(
                  child: Container(
                      padding: EdgeInsets.all(3),
                      child: SpinKitThreeBounce(
                          size: 14,
                          color: Colors.white)
                  ),
                ),
                borderRadius: 4.0,
                color: Colors.cyan,
              ),

            ],
          ),
          SizedBox(height: 10,),
          Row(
            children: [
              Icon(Icons.money),
              SizedBox(width: 10,),
              ArgonButton(
                height: 50,

                roundLoadingShape: true,
                width: MediaQuery.of(ctx).size.width * 0.7,
                padding: EdgeInsets.all(5),
                onTap: (startLoading, stopLoading, btnState) {
                  if (btnState == ButtonState.Idle) {
                    startLoading();

                    Timer(const Duration(milliseconds: 1000), () {
                      widget.order.paymentMethode = "mobile money";

                      Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => Summary( widget.order,widget.surecast,widget.surecem)
                          )
                      );
                      stopLoading();
                    });

                  } else {
                    stopLoading();
                  }
                },
                child: Column(
                  children: [
                    Text(

                      "Payer Via Orange Money ",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w700),
                    ),

                  ],
                ),
                loader: Expanded(
                  child: Container(
                      padding: EdgeInsets.all(3),
                      child: SpinKitThreeBounce(
                          size: 14,
                          color: Colors.white)
                  ),
                ),
                borderRadius: 4.0,
                color: Colors.cyan,
              ),

            ],
          ),
          SizedBox(height: 10,),
          Row(
            children: [
              Icon(Icons.money),
              SizedBox(width: 10,),
              ArgonButton(
                height: 50,

                roundLoadingShape: true,
                width: MediaQuery.of(ctx).size.width * 0.7,
                padding: EdgeInsets.all(5),
                onTap: (startLoading, stopLoading, btnState) {
                  if (btnState == ButtonState.Idle) {
                    startLoading();

                    Timer(const Duration(milliseconds: 1000), () {
                      widget.order.paymentMethode = "mobile money";

                      Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => Summary( widget.order,widget.surecast,widget.surecem)
                          )
                      );
                      stopLoading();
                    });

                  } else {
                    stopLoading();
                  }
                },
                child: Column(
                  children: [
                    Text(

                      "Payer Via Airtel Money ",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w700),
                    ),

                  ],
                ),
                loader: Expanded(
                  child: Container(
                      padding: EdgeInsets.all(3),
                      child: SpinKitThreeBounce(
                          size: 14,
                          color: Colors.white)
                  ),
                ),
                borderRadius: 4.0,
                color: Colors.cyan,
              ),

            ],
          ),


                          SizedBox(height: 10,),
                    Row(
                    children: [
                    Icon(Icons.payment_outlined),
                    SizedBox(width: 10,),
                    ArgonButton(
                    height: 50,

                    roundLoadingShape: true,
                    width: MediaQuery.of(ctx).size.width * 0.7,
                    padding: EdgeInsets.all(5),
                    onTap: (startLoading, stopLoading, btnState) {
                    if (btnState == ButtonState.Idle) {

                          startLoading();

                          Timer(const Duration(milliseconds: 1000), () {
                          
                          widget.order.paymentMethode = "debit card";

                          Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => Summary( widget.order,widget.surecast,widget.surecem)
                              )
                          );

                          stopLoading();

                    });

                    } else {
                    stopLoading();
                    }
                    },
                    child: Column(
                    children: [
                    Text(

                    "Payer avec une carte visa ",
                    style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w700),
                    ),

                    ],
                    ),
                    loader: Expanded(
                    child: Container(
                    padding: EdgeInsets.all(3),
                    child: SpinKitThreeBounce(
                    size: 14,
                    color: Colors.white)
                    ),
                    ),
                    borderRadius: 4.0,
                    color: Colors.cyan,
                    ),

                    ],
                    ),
        ],
      ),
    );
  }

  Widget _body(BuildContext cnt) {
return SingleChildScrollView(
  child: Column(
    children: [


      SizedBox(height: 10,),
      btnContinuer(cnt)


    ],
  ),
);

  }
}
