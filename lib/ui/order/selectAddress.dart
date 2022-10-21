import 'dart:async';

import 'package:delivery_owner/models/orderItemPPC.dart';
import 'package:delivery_owner/models/orderPPC.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import '../../ressources/getProduct.dart';
import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'selectPayement.dart';





class SelectAddress extends StatefulWidget {


  final OrderPPCModel order ;
  final OrderItemPPC surecast;
  final OrderItemPPC surecem;


  SelectAddress(this.order, this.surecast, this.surecem);

  @override
  _SelectAddressState  createState() =>  _SelectAddressState();
}

class _SelectAddressState extends State<SelectAddress> {
  String adresse ;

  GetProduct pro;
  // getAllProduct () async {
  //   pro = GetProduct();

  //   return await  pro.fetchAll();

  // }

  @override
  void initState() {
    adresse ="";
    // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
//    adresse = widget.order.shippingAdress;

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

                    child: Center(child: Text("Choisir l'Adresse",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)),

                  ),
                  SizedBox(height: 10,),
                  Divider(height: 3,),
                  SizedBox(height: 10,),
                  Text("Utiliser l'adresse de  : ",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                  SizedBox(height: 5,),
                  _body(context),
                  Container(
                    padding: const EdgeInsets.all(10.0),
                   // width: 400.0,
                    margin: const EdgeInsets.only(right: 10, left: 10),
                    child:  new Theme(
                          data: new ThemeData(
                          primaryColor: Colors.redAccent,
                          primaryColorDark: Colors.red,
                          ),
                          child: new TextFormField(
                            onChanged: (String value) {

                               setState(() {
                                 adresse = value;
                               });



                            },
                            maxLines: 5,

                          decoration: new InputDecoration(
                          border: new OutlineInputBorder(
                          borderSide: new BorderSide(color: Colors.teal)),
                   //       hintText: "Entrez l'adresse complete de livraison ",
                          helperText: "* Avec toutes les précisions ",
                          labelText: 'Adresse de livraison',
                          labelStyle: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                          prefixIcon: const Icon(
                          Icons.home_work_outlined,
                          color: Colors.red,
                          ),
                          prefixText: ' ',

                          ),
                          ),
                          )
    ),
                  
                  btnCont(context)



                ],
              ),





            ],
          ),
        ),
      ),
    );




  }


  Widget btnCont(BuildContext ctx) {
    OrderPPCModel orders = widget.order;

    if(adresse.isNotEmpty && adresse.length > 5){
      orders.shippingAdress = adresse;
    }





    return ArgonButton(
      height: 50,
      roundLoadingShape: true,
      width: MediaQuery.of(ctx).size.width * 0.45,
      onTap: (startLoading, stopLoading, btnState) {
        if (btnState == ButtonState.Idle) {
          startLoading();

          Timer(const Duration(milliseconds: 1000), () {
            stopLoading();
            Navigator.of(context).push(
                MaterialPageRoute(
                 builder: (context) => SelectPayement(orders,widget.surecast,widget.surecem)
                )
            );
          });

        } else {
          stopLoading();
        }
      },
      child: Text(
        "Continuer",
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
      color: Colors.blue,
    );
  }

  Widget btnContinuer(BuildContext ctx) {

    return ArgonButton(
      height: 60,

      roundLoadingShape: true,
      width: MediaQuery.of(ctx).size.width * 0.9,
      padding: EdgeInsets.all(5),
      onTap: (startLoading, stopLoading, btnState) {
        if (btnState == ButtonState.Idle) {
          startLoading();

          Timer(const Duration(milliseconds: 1000), () {
            stopLoading();

            Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (context) => SelectPayement(widget.order,widget.surecast,widget.surecem)
                )
            );
          });

        } else {
          stopLoading();
        }
      },
      child: Column(
        children: [



          Row(
            children: [
              Text("Adresse : ",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
              Flexible(
                child: Container(
                  child: Text(
                    "${widget.order.shippingAdress}",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ],
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
    );
  }

  Widget _body(BuildContext cnt) {

    return SingleChildScrollView(
            child: Column(
              children: [


                SizedBox(height: 10,),
                btnContinuer(cnt),
                SizedBox(height: 20,),
                Text("- OU -",style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 22,
                  fontStyle: FontStyle.italic
                ),)



              ],
            ),
          );
        }



}
