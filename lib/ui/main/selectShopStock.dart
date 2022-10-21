import 'dart:async';

import 'package:delivery_owner/models/Shop.dart';
import 'package:delivery_owner/ressources/getShop.dart';
import 'package:delivery_owner/ui/main/choseProductType.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import '../../ressources/getShop.dart';
import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../models/orderPPC.dart';
import '../../models/orderItemPPC.dart';
import 'SeePPCStock.dart';





class SelectShopStock extends StatefulWidget {


 SelectShopStock();

  @override
  _SelectShopStockState  createState() =>  _SelectShopStockState();
}

class _SelectShopStockState extends State<SelectShopStock> {

  GetShop shop;
  getAllShop () async{
    shop =GetShop();

    return await  shop.fetchAll();

  }


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

              child: Center(child: Text("Choisir le Dépôt",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)),

            ),
            SizedBox(height: 10,),
            Divider(height: 3,),
            _body(context)







          ],
        ),
      )
    );




  }




  Widget btnContinuer(BuildContext ctx,String name, String adresse, String id, ShopModel shop) {




    return ArgonButton(
      height: 75,

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
                    builder: (context) => ChoseProductType(shop)
                )
            );
          });

        } else {
          stopLoading();
        }
      },
      child: Column(
        children: [
          Text(
            "$name",
            style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w700),
          ),
          SizedBox(height: 5,),

          Text("Adresse : ",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
          Row(
            children: [
              Text("Adresse : ",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
              Text(
                "$adresse",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
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
      color: Colors.blueGrey,
    );
  }

  Widget _body(BuildContext cnt) {

    return FutureBuilder(
      builder: (cnt, snapshot){


        if(snapshot.hasData){

        List<ShopModel> listShop = snapshot.data ;

        if(listShop.length < 1){
          return Text("Vous n'avez pas de Dépot");
        }

          return  ListView.builder(
              shrinkWrap: true, // Use  children total size
            itemCount: listShop.length ,


              itemBuilder: (context,index) {
              return  Column(
                children: [
                  //
                        SizedBox(height: 10,),
                        btnContinuer(cnt,listShop[index].name,listShop[index].address,listShop[index].id,listShop[index])
                ],
              );
              }

          );



          //   SingleChildScrollView(
          //   child: Column(
          //     children: [
          //
          //
          //       SizedBox(height: 10,),
          //       btnContinuer(cnt)
          //
          //
          //     ],
          //   ),
          // );
        } else {
          if (snapshot.hasError){
            return Text("Vérifier votre connexion ");
          }

          if(snapshot.connectionState==ConnectionState.done){
            return Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Text("Vous n'avez pas de Dépot, commencer D'abord par créer un dépot avant de passer de voir le stock "),
            );
          }


          return Text("Chargement... ");
        }


      },
      future: getAllShop(),
    );

  }
}
