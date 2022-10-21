import 'package:delivery_owner/models/ProductStock.dart';
import 'package:delivery_owner/models/Shop.dart';
import 'package:delivery_owner/models/SupplyStock.dart';
 import 'package:delivery_owner/ressources/supplyStock/supplyStockProvider.dart';
 
import 'package:delivery_owner/ui/productStock/productstock.dart';
import 'package:flutter/material.dart';
import 'package:delivery_owner/main.dart';
import 'package:delivery_owner/ui/widgets/iappBar.dart';
import 'package:delivery_owner/ui/widgets/ibackground4.dart';
import 'package:delivery_owner/ui/widgets/ibox.dart';
import 'package:delivery_owner/ui/widgets/ibutton.dart';
import 'package:delivery_owner/ui/widgets/iinputField2.dart'; 
import 'package:fluttertoast/fluttertoast.dart';


class AddStock extends StatefulWidget {
  ShopModel shop ;
  ProductStockModel product ;




  AddStock({Key key, this.shop  , this.product}) : super(key: key);
  @override
  _AddStockState createState() => _AddStockState();
}

class _AddStockState extends State<AddStock>
    with SingleTickerProviderStateMixin {

  SupplyStockModel _supplyModel = SupplyStockModel() ;




  _pressCreateAccountButton() async{

    if( editControlNumber.text.isEmpty  ){
      Fluttertoast.showToast(
          msg: "La quantité ne doit pas etre nulle",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.blue,
          textColor: Colors.white,
          fontSize: 16.0
      );
    } else {


      _supplyModel.shop = widget.product.shop;
      _supplyModel.number = int.parse( editControlNumber.text);
      _supplyModel.productStock = widget.product.id ;





      SupplystockService _supplyService = SupplystockService();




      bool isCreate = await  _supplyService.create( _supplyModel);
      if(isCreate ) {

        int count = 0;
        // Navigator.of(context).pop();

        Navigator.of(context).push(
            MaterialPageRoute(
                builder: (context) => StockProduckUi( shop :widget.shop)
            )
        );


        //  Navigator.pushNamed(context,"/setotp");
      }





    }

    //Navigator.pushNamedAndRemoveUntil(context, "/main", (r) => false);
  }

  //
  //////////////////////////////////////////////////////////////////////////////////////////////////////
  var windowWidth;

  var windowHeight;

  final editControlNumber = TextEditingController();


  @override
  void initState() {
    super.initState();


  }

  @override
  void dispose() {
    editControlNumber.dispose();

    //  editControllerPassword2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    windowWidth = MediaQuery.of(context).size.width;
    windowHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: theme.colorBackground,

      body: Stack(
        children: <Widget>[

          IBackground4(width: windowWidth, colorsGradient: [Colors.blue , Colors.blueAccent , Colors.blueGrey]),

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

    return ListView(
      shrinkWrap: true,
      children: <Widget>[

        Container(
          margin: EdgeInsets.only(left: 15, right: 20),
          alignment: Alignment.centerLeft,
          child: Text("Approvisionner",                        // "Create an Account!"
              style: theme.text20boldWhite
          ),
        ),
        SizedBox(height: 20,),

        IBox(
            color: theme.colorBackgroundDialog,
            child: Column(
              children: <Widget>[
                SizedBox(height: 15,),





                SizedBox(height: 20,),

                Container(
                    margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child:
                    IInputField2(
                      hint: "Quantité : ",            // "Login"
                      icon: Icons.addchart_sharp,
                      colorDefaultText: Colors.blue,
                      colorBackground: theme.colorBackgroundDialog,
                      controller: editControlNumber,
                    )
                ),
                SizedBox(height: 20,),
                Container(
                  margin: EdgeInsets.only(left: 20, right: 20),
                  child: IButton(pressButton: _pressCreateAccountButton, text: "Ajouter ", // CREATE ACCOUNT
                    color: Colors.blue,
                    textStyle: theme.text16boldWhite,),
                ),
                SizedBox(height: 15,),

              ],
            )
        ),

      ],
    );
  }

}