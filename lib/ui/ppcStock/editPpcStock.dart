import 'package:delivery_owner/models/Shop.dart';
import 'package:delivery_owner/models/ShopProduct.dart';
import 'package:delivery_owner/ressources/shopProduct/shopProductProvider.dart';
 
import 'package:delivery_owner/ui/main/SeePPCStock.dart';
import 'package:flutter/material.dart';
import 'package:delivery_owner/main.dart';
import 'package:delivery_owner/ui/widgets/iappBar.dart';
import 'package:delivery_owner/ui/widgets/ibackground4.dart';
import 'package:delivery_owner/ui/widgets/ibox.dart';
import 'package:delivery_owner/ui/widgets/ibutton.dart';
import 'package:delivery_owner/ui/widgets/iinputField2.dart'; 
import 'package:fluttertoast/fluttertoast.dart';


class EditPpcStock extends StatefulWidget {



  ShopProductModel product ;
  ShopModel shop ;

  EditPpcStock({Key key, this.product  , this.shop}) : super(key: key);
  @override
  _EditPpcStockState createState() => _EditPpcStockState();
}

class _EditPpcStockState extends State<EditPpcStock>
    with SingleTickerProviderStateMixin {

  ShopProductModel _shopProductModel = ShopProductModel();





  _pressCreateAccountButton() async{

    if( editControlpriceFC.text.isEmpty  || editControlpriceUSD.text.isEmpty){
      Fluttertoast.showToast(
          msg: "Le prix en franc ou en dollars ne doivent pas etre vide",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.blue,
          textColor: Colors.white,
          fontSize: 16.0
      );
    } else {




      _shopProductModel.priceFc = double.parse(editControlpriceFC.text) ;
      _shopProductModel.priceUsd = double.parse( editControlpriceUSD.text);





      ShopProductService _productStockService = ShopProductService();




      bool isCreate = await  _productStockService.update( _shopProductModel);
      if(isCreate ) {

        int count = 0;
        // Navigator.of(context).pop();

        Navigator.of(context).pushReplacement(
            MaterialPageRoute(
                builder: (context) => SeePPCStock(shop: widget.shop,)
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
  String choseDate = 'Choisir la date';
  var windowHeight;


  final editControlpriceFC = TextEditingController();
  final editControlpriceUSD = TextEditingController();

  //final editControllerPassword2 = TextEditingController();


  @override
  void initState() {
    String  isN(String str) {
      if(str == null) {
        return "";
      } else {
        return str;

      }
    }


    _shopProductModel = widget.product;
    if(!(_shopProductModel.priceUsd==0.0 )) {
       editControlpriceUSD.text =  _shopProductModel.priceUsd.toString() ;

    }
    if(!(_shopProductModel.priceFc==0.0 )) {
      editControlpriceFC.text =  _shopProductModel.priceFc.toString() ;

    }




        super.initState();

  }

  @override
  void dispose() {
    editControlpriceUSD.dispose();
    editControlpriceFC.dispose();

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

          IBackground4(width: windowWidth, colorsGradient: [Colors.green , Colors.greenAccent , Colors.lightGreenAccent]),

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
          child: Text("${widget.product.product== null ? " " : widget.product.product }",                        // "Create an Account!"
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
                      hint: "Prix en USD ",            // "Login"
                      icon: Icons.monetization_on_outlined,
                      colorDefaultText: Colors.green,
                      colorBackground: theme.colorBackgroundDialog,
                      controller: editControlpriceUSD,
                    )
                ),
                SizedBox(height: 20,),
                Container(
                    margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child:
                    IInputField2(
                      hint: "Prix en FRANC",            // "Login"
                      icon: Icons.account_balance_wallet_outlined,
                      colorDefaultText: Colors.green,
                      colorBackground: theme.colorBackgroundDialog,
                      controller: editControlpriceFC,
                    )
                ),


                SizedBox(height: 20,),
                Container(
                  margin: EdgeInsets.only(left: 20, right: 20),
                  child: IButton(pressButton: _pressCreateAccountButton, text: "Fixer le prix ", // CREATE ACCOUNT
                    color: Colors.green,
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