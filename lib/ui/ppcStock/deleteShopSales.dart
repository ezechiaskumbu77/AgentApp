
import 'package:delivery_owner/models/SalesShop.dart';
import 'package:delivery_owner/models/Shop.dart';
import 'package:delivery_owner/models/ShopProduct.dart';
import 'package:delivery_owner/ressources/salesproduct/SalesppcProvider.dart';

import 'package:delivery_owner/ui/ppcStock/salesShopList.dart'; 
import 'package:flutter/material.dart';
import 'package:delivery_owner/main.dart';
import 'package:delivery_owner/ui/widgets/iappBar.dart';
import 'package:delivery_owner/ui/widgets/ibackground4.dart';
import 'package:delivery_owner/ui/widgets/ibox.dart'; 


class DeleteProductShopSales extends StatefulWidget {



  ShopProductModel product ;
  ShopModel shop ;
  SaleShopModel sales ;

  DeleteProductShopSales({Key key, this.product  , this.shop , this.sales}) : super(key: key);
  @override
  _DeleteProductShopSalesState createState() => _DeleteProductShopSalesState();
}

class _DeleteProductShopSalesState extends State<DeleteProductShopSales>
    with SingleTickerProviderStateMixin {

  _deleteYes() async{

    SalesPPCStockService _producrSaleDelete = SalesPPCStockService();
      bool isDelete = await  _producrSaleDelete.delete( widget.sales.id);
      if(isDelete ) {

        Navigator.of(context).pushReplacement(
            MaterialPageRoute(
                builder: (context) => SalesShopList( shop : widget.shop, productShopModel: widget.product,)
            )
        );

      }

  }

  _deleteNo() async{
     Navigator.of(context).pop();
  }

  //
  //////////////////////////////////////////////////////////////////////////////////////////////////////
  var windowWidth;

  var windowHeight;


  @override
  void initState() {

        super.initState();

  }


  @override
  Widget build(BuildContext context) {
    windowWidth = MediaQuery.of(context).size.width;
    windowHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: theme.colorBackground,

      body: Stack(
        children: <Widget>[

          IBackground4(width: windowWidth, colorsGradient: [Colors.black , Colors.black26 , Colors.black12]),

          IAppBar(context: context, text: "", color: Colors.white),

          Center(
              child: Container(
                margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                width: windowWidth,
                child: _body(context),
              )
          ),

        ],
      ),
    );
  }

  _body(context){

    return

      Column(
        children: [
          SizedBox(height: windowHeight/6,),
          Container(
            margin: EdgeInsets.only(left: 15, right: 20),
            alignment: Alignment.centerLeft,
            child: Text("Suppression",                        // "Create an Account!"
                style: theme.text20boldWhite
            ),
          ),
          SizedBox(height: 20,),
          IBox(
            color: theme.colorBackgroundDialog,
            child: Center(
            child: Column(
              children: [
                Padding(
                    padding: EdgeInsets.all(15.0),
                child: Icon(Icons.warning,color: Colors.red,size: 100,),
                ),
                Padding(
                  padding: EdgeInsets.all(15.0),

                  child: Text("Vente de ${widget.sales.number}  ${widget.product.name}", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
                ),
                Padding(
                  padding: EdgeInsets.all(15.0),

                  child: Text(" Voulez‑vous vraiment supprimer cette vente ?" , style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400 ), textAlign:TextAlign.center,),
                ),

                Padding(padding: EdgeInsets.all(40.0) ,

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [

                          RaisedButton(

                              child: Text("  Oui  ",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold, fontSize: 18),),
                              color: Colors.green,

                              onPressed: _deleteYes

                          ),
                          RaisedButton(
                              child: Text("  Non  ",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18),),
                              color: Colors.red,

                              onPressed: _deleteNo
                          ),
                        ],
                ),
                )
              ],
            ),
    ),
          ),
        ],
      );
  }

}