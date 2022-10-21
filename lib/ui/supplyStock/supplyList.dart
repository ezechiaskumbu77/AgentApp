import 'dart:async';

import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';
import 'package:delivery_owner/models/ProductStock.dart';
import 'package:delivery_owner/models/Shop.dart';
import 'package:delivery_owner/models/SupplyStock.dart';

import 'package:delivery_owner/ressources/supplyStock/supplyStockProvider.dart';
import 'package:delivery_owner/ui/supplyStock/EditSupply.dart';
import 'package:delivery_owner/ui/supplyStock/deleteSupply.dart';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:expansion_card/expansion_card.dart';

import 'package:timeago/timeago.dart' as timeago;





class SupplyList extends StatefulWidget {

  ShopModel shop ;
  ProductStockModel productStockModel ;


  SupplyList({this.shop , this.productStockModel});



  @override
  _SupplyListState createState() => _SupplyListState();
}

class _SupplyListState extends State<SupplyList> {

  String timeUntil(var dt) {

    var date = new DateTime.fromMicrosecondsSinceEpoch(dt*1000);
    return timeago.format(date, allowFromNow: true, locale: 'fr');
  }


  SupplystockService SupplyStock;
  getAllSupplyStock () async{
    SupplyStock =SupplystockService();

    return await  SupplyStock.fetchAll(widget.productStockModel);

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

                child: Center(child: Text("Historique approvisionenemnt",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)),

              ),
              SizedBox(height: 10,),
              Divider(height: 3,),
              Row(

                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text("Produit : ${widget.productStockModel.name}", style: TextStyle(fontSize: 20 , fontWeight: FontWeight.bold),)


                ],

              ),
              _body(context)







            ],
          ),
        )
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

          List<SupplyStockModel> listSupply = snapshot.data ;

          if(listSupply.length < 1){
            return Text("Vous n'avez pas des approvisionnements");
          }

          return  Expanded(
            child: ListView.builder(
                shrinkWrap: true, // Use  children total size
                itemCount: listSupply.length ,


                itemBuilder: (context,index) {
                  return  Column(
                    children: [
                      //
                      SizedBox(height: 10,),
                   //  Text("Produit ${listShop[index].name}"),

                  Center(

                        child: Container(
                          margin: EdgeInsets.only(right: 10),

                          width: 600,

                          child: Card(

                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [


                                  Text("Quantité : ${listSupply[index].number}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                                  SizedBox(height: 10,),
                                  Text(" ${ timeUntil(listSupply[index].date)}", style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic),),

                                  SizedBox(height: 10,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      RaisedButton(
                                          child: Text("Modifier",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                                          color: Colors.lightGreen,

                                          onPressed: () {
                                            // Navigator.of(context).pop();

                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                        builder: (context) =>  EditSupplyStock(shop: widget.shop,product:widget.productStockModel, supply: listSupply[index],)
                                                )
                                            );


                                          }),

                                      SizedBox(width: 15,),
                                      RaisedButton(

                                          child: Text("Supprimer",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                                          color: Colors.red,

                                          onPressed: () {


                                            // Navigator.of(context).pop();

                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                      builder: (context) =>  DeleteProductSupply(shop: widget.shop,supply: listSupply[index],product: widget.productStockModel,)
                                                )
                                            );
                                          }),

                                    ],
                                  )
                                ],
                              ),
                            ),
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
      future: getAllSupplyStock(),
    );

  }
}
