import 'package:delivery_owner/models/ProductStock.dart';
import 'package:delivery_owner/models/Shop.dart';
import 'package:delivery_owner/models/SupplyStock.dart';
import 'package:delivery_owner/models/salesStock.dart';
import 'package:delivery_owner/models/user.dart';
import 'package:delivery_owner/ressources/productstock/productStockProvider.dart';
import 'package:delivery_owner/ressources/stockProductSales/SalesStockProvider.dart';
import 'package:delivery_owner/ressources/supplyStock/supplyStockProvider.dart';
import 'package:delivery_owner/service/authservice.dart';
import 'package:delivery_owner/service/shopManagerService.dart';
import 'package:delivery_owner/ui/SalesUi/salesStockList.dart';
import 'package:delivery_owner/ui/productStock/productstock.dart';
import 'package:delivery_owner/ui/supplyStock/supplyList.dart';
import 'package:flutter/material.dart';
import 'package:delivery_owner/main.dart';
import 'package:delivery_owner/ui/widgets/iappBar.dart';
import 'package:delivery_owner/ui/widgets/ibackground4.dart';
import 'package:delivery_owner/ui/widgets/ibox.dart';
import 'package:delivery_owner/ui/widgets/ibutton.dart';
import 'package:delivery_owner/ui/widgets/iinputField2.dart';
import 'package:delivery_owner/ui/widgets/iinputField2Password.dart';
import 'package:fluttertoast/fluttertoast.dart';


class DeleteProductSales extends StatefulWidget {



  ProductStockModel product ;
  ShopModel shop ;
  SalesStockModel sales ;

  DeleteProductSales({Key key, this.product  , this.shop , this.sales}) : super(key: key);
  @override
  _DeleteProductSalesState createState() => _DeleteProductSalesState();
}

class _DeleteProductSalesState extends State<DeleteProductSales>
    with SingleTickerProviderStateMixin {

  _deleteYes() async{

    SalesStockService _producrSaleDelete = SalesStockService();
      bool isDelete = await  _producrSaleDelete.delete( widget.sales.id);
      if(isDelete ) {

        Navigator.of(context).pushReplacement(
            MaterialPageRoute(
                builder: (context) => SalesStockList( shop : widget.shop, productStockModel: widget.product,)
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