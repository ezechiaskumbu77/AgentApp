
import 'package:delivery_owner/models/SalesShop.dart';
import 'package:delivery_owner/models/Shop.dart';
import 'package:delivery_owner/models/ShopProduct.dart'; 
import 'package:delivery_owner/ressources/salesproduct/SalesppcProvider.dart';
 

import 'package:flutter/material.dart'; 
import 'package:timeago/timeago.dart' as timeago;





class SalesShopList extends StatefulWidget {

  ShopModel shop ;
  ShopProductModel productShopModel ;


  SalesShopList({this.shop , this.productShopModel});



  @override
  _SalesShopListState createState() => _SalesShopListState();
}

class _SalesShopListState extends State<SalesShopList> {

  String timeUntil(var dt) {

    var date = new DateTime.fromMicrosecondsSinceEpoch(dt*1000);
    return timeago.format(date, allowFromNow: true, locale: 'fr');
  }


  SalesPPCStockService salesStock;
  getAllShopSales () async{
    salesStock =SalesPPCStockService();

    return await  salesStock.fetchAll(widget.productShopModel);

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

                child: Center(child: Text("Historique de vente",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)),

              ),
              SizedBox(height: 10,),
              Divider(height: 3,),
              Row(

                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Produit : ", style: TextStyle(fontSize: 20 , fontWeight: FontWeight.normal),),
                  Text(" ${widget.productShopModel.name}", style: TextStyle(fontSize: 20 , fontWeight: FontWeight.bold, color: Colors.red),)


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

          List<SaleShopModel> listSales = snapshot.data ;

          if(listSales.length < 1){
            return Text("Vous n'avez pas des ventes");
          }

          return  Expanded(
            child: ListView.builder(
                shrinkWrap: true, // Use  children total size
                itemCount: listSales.length ,


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


                                 Text("Quantité : ${listSales[index].number==null ? "":listSales[index].number}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),),
                                  SizedBox(height: 3,),
                                  Text("Prix Total : ${listSales[index].prixTotal}  ${listSales[index].deviseType == "usd" ? "usd" : "fc"}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),),
                                  SizedBox(height: 3,),
                                  Text("Devise  : ${listSales[index].deviseType == "usd" ? "Dollars" : "Franc"} ", style: TextStyle( fontSize: 12),),
                                  SizedBox(height: 3,),
                                  Text("Prix unitaire : ${listSales[index].price} ${listSales[index].deviseType == "usd" ? "usd" : "fc"} ", style: TextStyle( fontSize: 12),),

                                  SizedBox(height: 3,),
                                  Text("Reduction : ${listSales[index].discount==null ? "0" : listSales[index].discount} ${listSales[index].deviseType == "usd" ? "usd" : "fc"} ", style: TextStyle( fontSize: 12),),


                                  SizedBox(height: 5,),
                                  Text(" ${ timeUntil(listSales[index].date)}", style: TextStyle(fontSize: 10, fontStyle: FontStyle.italic),),

                                  SizedBox(height: 5,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      /*RaisedButton(
                                          child: Text("Modifier",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 12),),
                                          color: Colors.lightGreen,

                                          onPressed: () {
                                            // Navigator.of(context).pop();

                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                      builder: (context) =>  EditPPCProductSales(shop: widget.shop,product:widget.productShopModel, sales: listSales[index],)
                                                )
                                            );


                                          }),

                                      SizedBox(width: 15,),
                                      RaisedButton(

                                          child: Text("Supprimer",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 12),),
                                          color: Colors.red,

                                          onPressed: () {


                                            // Navigator.of(context).pop();

                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>  DeleteProductShopSales(shop: widget.shop,sales: listSales[index],product: widget.productShopModel,)
                                                )
                                            );
                                          }),*/

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
              child: Text("Vous n'avez pas de vente"),
            );
          }
          if (snapshot.hasError){
            return Text("Vérifier votre connexion ${snapshot.error}");
          }




          return Text("Chargement... ");
        }


      },
      future: getAllShopSales(),
    );

  }
}
