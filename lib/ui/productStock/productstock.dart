import 'dart:async';

import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';
import 'package:delivery_owner/models/ProductStock.dart';
import 'package:delivery_owner/models/Shop.dart';
import 'package:delivery_owner/ressources/productstock/productStockProvider.dart';
import 'package:delivery_owner/ui/SalesUi/choseProductSalesType.dart';
import 'package:delivery_owner/ui/SalesUi/salesStockList.dart';
import 'package:delivery_owner/ui/productStock/addProduct.dart';
import 'package:delivery_owner/ui/productStock/deleteProduct.dart';
import 'package:delivery_owner/ui/productStock/editProduct.dart';
import 'package:delivery_owner/ui/supplyStock/choseProductType.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:expansion_card/expansion_card.dart';

import 'package:timeago/timeago.dart' as timeago;




class StockProduckUi extends StatefulWidget {

  ShopModel shop ;


  StockProduckUi({this.shop});



  @override
  _StockProduckUiState createState() => _StockProduckUiState();
}

class _StockProduckUiState extends State<StockProduckUi> {


  StockProductService StockProduct;
  getAllStockProduct () async{
    StockProduct =StockProductService();

    return await  StockProduct.fetchAll(widget.shop);

  }
  @override
  void initState() {

    super.initState();
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

                child: Center(child: Text("Le Produit",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)),

              ),
              SizedBox(height: 10,),
              Divider(height: 3,),
              Row(

                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  RaisedButton(
                      child: Text("Ajouter",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                      color: Colors.green,

                      onPressed: () {

                        Navigator.of(context).push(
                            MaterialPageRoute(
                                 builder: (context) =>  AddProductStock(shop: widget.shop)
                            )
                        );

                      //  Navigator.of(context).pop();
                      }),
                  RaisedButton(
                      child: Text("Historique de vente",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                      color: Colors.blue,

                      onPressed: () {
                       // Navigator.of(context).pop();
                      }),

                ],

              ),
              _body(context)







            ],
          ),
        )
    );




  }

  String timeUntil(var dt) {

    var date = new DateTime.fromMicrosecondsSinceEpoch(dt*1000);
    return timeago.format(date, allowFromNow: true, locale: 'fr');
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
                //    builder: (context) => ChoseProductType(shop)
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
  final txtStyle1 = TextStyle(color: Colors.white, fontSize: 16,fontWeight: FontWeight.w600);
  final txtStyle2 = TextStyle(color: Colors.white, fontSize: 16,fontWeight: FontWeight.w900);
  var txtStyle3 = TextStyle(fontSize: 22, fontWeight: FontWeight.bold);

  Widget _body(BuildContext cnt) {



    return FutureBuilder(
      builder: (cnt, snapshot){


        if(snapshot.hasData){


          if (snapshot.error != null &&
              snapshot.error.toString().length > 0) {
            return Container();
          }

          List<ProductStockModel> listProductStock = snapshot.data ;

          if(listProductStock.length < 1){
            return Text("Vous n'avez pas de Dépot");
          }

          return  Expanded(
            child: ListView.builder(
                shrinkWrap: true, // Use  children total size
                itemCount: listProductStock.length ,


                itemBuilder: (context,index) {
                  return  Column(
                    children: [
                      //
                      SizedBox(height: 10,),
                   //  Text("Produit ${listShop[index].name}"),

                  Center(

                        child: Container(
                          color: Colors.black38,
                          child: ExpansionCard(

                            trailing:  Icon(Icons.keyboard_arrow_down_sharp),
                            backgroundColor: Colors.black45,
                                title: Container(
                                    child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                              Text(
                                              "${listProductStock[index].name}", style: txtStyle3,
                                              ),
                                              SizedBox(height: 5,),
                                              Text(
                                              "${timeUntil(listProductStock[index].date)}",style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
                                              ),
                                        ],
                                    ),
                                ),
                                    children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.only(left: 15, right: 60),
                                            child: Divider(color: Colors.white,),
                                          ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20, bottom: 20),
                                    child: Column(
                                      children: [
                                        Row(

                                          children: [
                                            Text("Prix en ${listProductStock[index].deviseType == "usd" ? "Dollars" : "Franc"} : ",style: txtStyle1,),
                                            Text("${listProductStock[index].price } ${listProductStock[index].deviseType == "usd" ? "\$" : "FC"} ",style: txtStyle2),
                                          ],
                                        ),
                                        SizedBox(height: 5,),
                                        Row(

                                          children: [
                                            Text("Stock disponible : ",style: txtStyle1,),
                                            Text("${listProductStock[index].inventorOnHand==null? "" : listProductStock[index].inventorOnHand }  ",style: txtStyle2),
                                          ],
                                        ),
                                        SizedBox(height: 5,),
                                        Row(

                                          children: [
                                            Text("Stock Vendu : ",style: txtStyle1,),
                                            Text("${listProductStock[index].inventorShiped==null? "" : listProductStock[index].inventorShiped }  ",style: txtStyle2),
                                          ],
                                        ),
                                        SizedBox(height: 5,),
                                        Row(

                                          children: [
                                            Text("Stock Reçu : ",style: txtStyle1,),
                                            Text("${listProductStock[index].inventoryReceived==null? "" : listProductStock[index].inventoryReceived }  ",style: txtStyle2),
                                          ],
                                        ),
                                        SizedBox(height: 5,),



                                      ],
                                    ),
                                  ),


                                      Padding(
                                        padding: const EdgeInsets.only(left: 5, right: 5),
                                        child: Divider(color: Colors.white,),
                                      ),
                                      Padding(
                                          padding: EdgeInsets.all(5.0),
                                      child:
                                      Row(

                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [
                                          RaisedButton(
                                              child: Text("Signale une Vente",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                                              color: Colors.amber,

                                              onPressed: () {

                                                Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                        builder: (context) =>  SalesStockType(shop: widget.shop, product: listProductStock[index],)
                                                    )
                                                );

                                                //  Navigator.of(context).pop();
                                              }),
                                          RaisedButton(
                                              child: Text("Historique de vente",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                                              color: Colors.blue,

                                              onPressed: () {
                                                Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                        builder: (context) => SalesStockList(shop: widget.shop,productStockModel: listProductStock[index],)
                                                    )
                                                );
                                              }),


                                        ],

                                      ),
                                      
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(5.0),
                                        child:
                                        Row(

                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children: [

                                            RaisedButton(

                                                child: Text("Approvisionner",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                                                color: Colors.purple,

                                                onPressed: () {


                                                  // Navigator.of(context).pop();

                                                  Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                          builder: (context) =>  SupplyStockType(shop: widget.shop,product: listProductStock[index],)
                                                      )
                                                  );
                                                }),
                                            /*RaisedButton(

                                                child: Text("Supprimer",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                                                color: Colors.red,

                                                onPressed: () {


                                                  // Navigator.of(context).pop();

                                                  Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                          builder: (context) =>  DeleteProductStock(shop: widget.shop,product: listProductStock[index],)
                                                      )
                                                  );
                                                }),
                                            RaisedButton(
                                                child: Text("Modifier",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                                                color: Colors.lightGreen,

                                                onPressed: () {
                                                  // Navigator.of(context).pop();

                                                  Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                          builder: (context) =>  EditProductStock(shop: widget.shop,product: listProductStock[index],)
                                                      )
                                                  );


                                                }),*/

                                          ],

                                        ),

                                      )

                                ],
                          ),
                        )
                  )
                     // btnContinuer(cnt,listShop[index].name,listShop[index].address,listShop[index].id,listShop[index])
                    ],
                  );
                }

            ),
          );

        } else {
          if(snapshot.connectionState==ConnectionState.done){
            return Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Text("Vous n'avez pas de produit"),
            );
          }
          if (snapshot.hasError){
            return Text("Vérifier votre connexion ${snapshot.error}");
          }




          return Text("Chargement... ");
        }


      },
      future: getAllStockProduct(),
    );

  }
}
