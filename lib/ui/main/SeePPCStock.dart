import 'dart:async';

import 'package:delivery_owner/models/Shop.dart';
import 'package:delivery_owner/models/ShopProduct.dart';
import 'package:delivery_owner/ressources/getShop.dart';
import 'package:delivery_owner/ressources/getShopProduct.dart';
import 'package:delivery_owner/ui/ppcStock/addPpcStockSales.dart';
import 'package:delivery_owner/ui/ppcStock/editPpcStock.dart';
import 'package:delivery_owner/ui/ppcStock/salesShopList.dart';
import 'package:delivery_owner/ui/ppcStock/salesShopListAll.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import '../../ressources/getShop.dart';
import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../models/orderPPC.dart';
import '../../models/orderItemPPC.dart';





class SeePPCStock extends StatefulWidget {

  ShopModel shop;


 SeePPCStock({this.shop});

  @override
  _SeePPCStockState  createState() =>  _SeePPCStockState();
}

class _SeePPCStockState extends State<SeePPCStock> {

  GetShopProduct shopProduct;
  getAllShop (String shop) async{
    shopProduct = GetShopProduct();

    return await  shopProduct.fetchAll(shop);

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

              child: Center(child: Text("Stock de dépot ${widget.shop.name==null ? " " : widget.shop.name}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)),

            ),
            SizedBox(height: 10,),
            Divider(height: 3,),
            RaisedButton(
                child: Text("Voir les vente",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                color: Colors.blue,

                onPressed: () {
                  // Navigator.of(context).pop();

                  Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) =>  SalesShopListALL(shop: widget.shop)
                      )
                  );


                }),
            _body(context, widget.shop)







          ],
        ),
      )
    );




  }




  Widget btnContinuer(BuildContext ctx,String name, String adresse, String id) {




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
                  //  builder: (context) => SelectAddress(  widget.order ,widget.surecast,widget.surecem)
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

  Widget _body(BuildContext cnt, ShopModel shop) {

    return FutureBuilder(
      builder: (cnt, snapshot){


        if(snapshot.hasData){

        List<ShopProductModel> listShop = snapshot.data;

        if(listShop.length < 1){
          return Text("Vous n'avez pas de Stock pour l'instant");
        }

          return  ListView.builder(
              shrinkWrap: true, // Use  children total size
            itemCount: listShop.length ,


              itemBuilder: (context,index) {
              return  Column(

                children: [
                  //
                        SizedBox(height: 10,),
                      Card(

                        elevation: 2.0,
                        child: Container(
                          padding: EdgeInsets.all(10.0),
                          width: MediaQuery.of(cnt).size.width * 0.9,

                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text("Produit : "),
                                  Text(listShop[index].name==null ?"" : listShop[index].name , style: TextStyle(fontWeight: FontWeight.bold),)
                                ],
                              ),
                              Row(
                                children: [
                                  Text("Stock Disponible : "),
                                  Text(listShop[index].inventorOnHand.toString() ==null ?  "" : listShop[index].inventorOnHand.toString(), style: TextStyle(fontWeight: FontWeight.bold),)
                                ],
                              ),
                              Row(
                                children: [
                                  Text("Quantité totale recu : "),
                                  Text(listShop[index].inventoryReceived.toString(), style: TextStyle(fontWeight: FontWeight.bold),)
                                ],
                              ),
                              Row(
                                children: [
                                  Text("Quantité totale vendu : "),
                                  Text(listShop[index].inventorShiped.toString(), style: TextStyle(fontWeight: FontWeight.bold),)
                                ],

                              ),
                              Row(
                                children: [
                                  Text(" quantité minimale : "),
                                  Text(listShop[index].minimumRequired.toString(), style: TextStyle(fontWeight: FontWeight.bold),)
                                ],

                              ),
                              Row(
                                children: [
                                  Text(" Prix en Franc : "),
                                Text(listShop[index].priceFc ==0.0 ? "" : listShop[index].priceFc.toString(), style: TextStyle(fontWeight: FontWeight.bold),),
                                  Text("${listShop[index].priceFc ==0.0 ? "" : " FC"}", style:TextStyle(fontWeight: FontWeight.bold) ,),
                                ],

                              ),
                              Row(
                                children: [
                                  Text(" Prix en Dollars : "),
                                  Text(listShop[index].priceUsd == 0.0 ? "" : listShop[index].priceUsd.toString(), style: TextStyle(fontWeight: FontWeight.bold),),
                                  Text("${listShop[index].priceFc == 0.0 ? "" : " USD"}", style :TextStyle(fontWeight: FontWeight.bold)),
                                ],

                              ),

                              Padding(
                                padding: EdgeInsets.all(5.0),
                                child:
                                Row(

                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [

                                    RaisedButton(

                                        child: Text("Vente",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                                        color: Colors.green,

                                        onPressed: () {


                                          // Navigator.of(context).pop();

                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                              builder: (context) =>  AddPPCProductSales(shop: widget.shop,product: listShop[index],)
                                              )
                                          );
                                        }),

                                    RaisedButton(
                                        child: Text("Fixer le prix",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                                        color: Colors.blue,

                                        onPressed: () {
                                          // Navigator.of(context).pop();

                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                    builder: (context) =>  EditPpcStock(shop: widget.shop,product: listShop[index],)
                                              )
                                          );


                                        }),


                                  ],

                                ),

                              ),

                              RaisedButton(
                                  child: Text("Historique de vente ",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                                  color: Colors.red,

                                  onPressed: () {
                                    // Navigator.of(context).pop();

                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                                builder: (context) =>  SalesShopList(shop: widget.shop,productShopModel: listShop[index],)
                                        )
                                    );


                                  }),



                            ],
                          ),
                        ),
                      )
                      //  btnContinuer(cnt,listShop[index].name,listShop[index].address,listShop[index].id)
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
            return Text("Vérifier votre connexion gertye ${snapshot.error.toString()}");
          }

          if(snapshot.connectionState==ConnectionState.done){
            return Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Text("Vous n'avez pas de stock "),
            );
          }


          return Text("Chargement... ");
        }


      },
      future: getAllShop(shop.id),
    );

  }
}
