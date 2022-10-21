import 'dart:async';

import 'package:delivery_owner/models/ProductStock.dart';
import 'package:delivery_owner/models/Shop.dart';
import 'package:delivery_owner/ressources/getShop.dart';
import 'package:delivery_owner/ui/SalesUi/addStockSales.dart';
import 'package:delivery_owner/ui/SalesUi/salesStockList.dart';
import 'package:delivery_owner/ui/main/SeePPCStock.dart';
import 'package:delivery_owner/ui/main/selectShopStock.dart';
import 'package:delivery_owner/ui/productStock/productstock.dart';
import 'package:delivery_owner/ui/supplyStock/addStock.dart';
import 'package:delivery_owner/ui/supplyStock/supplyList.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import '../../ressources/getShop.dart';
import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../models/orderPPC.dart';
import '../../models/orderItemPPC.dart';





class SalesStockType extends StatefulWidget {

ShopModel shop ;
ProductStockModel product ;

 SalesStockType({this.shop, this.product});

  @override
  _SalesStockTypeState  createState() =>  _SalesStockTypeState();
}

class _SalesStockTypeState extends State<SalesStockType> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: 
      Padding(
        padding: const EdgeInsets.only(top: 50,left: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min, // Use children total size
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
            Container(

              child: Center(child: Text("Vente",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)),

            ),
            SizedBox(height: 10,),
            Divider(height: 3,),
            SizedBox(height: 50,),

            btnPPC(context, widget.shop),
            SizedBox(height: 10,),
            btnNoPPC(context, widget.shop)







          ],
        ),
      )
    );




  }


  Widget btnPPC(BuildContext ctx, ShopModel shop) {
    return ArgonButton(
      height: 50,
      roundLoadingShape: true,
      width: MediaQuery.of(ctx).size.width * 0.45,
      onTap: (startLoading, stopLoading, btnState) {
        if (btnState == ButtonState.Idle) {
          startLoading();

          Timer(const Duration(milliseconds: 1000), () {


              stopLoading();

              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                      builder: (context) => AddProductSales(shop: widget.shop,product: widget.product,)
                  )
              );


          });

        } else {
          stopLoading();
        }
      },
      child: Text(
        "Vente",
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
      color: Colors.red,
    );
  }



  Widget btnNoPPC(BuildContext ctx , ShopModel shop) {
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
                  builder: (context) => SalesStockList(shop: shop,productStockModel: widget.product,)
                )
            );

          });

        } else {
          stopLoading();
        }
      },
      child: Text(
        "Historique ",
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
      color: Colors.green,
    );
  }



  Widget _body(BuildContext cnt) {

    return Container(
      child: Text("Choisir un produit"),
    );
  }
}
