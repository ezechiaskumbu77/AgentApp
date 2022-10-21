import 'package:delivery_owner/models/ProductStock.dart';
import 'package:delivery_owner/models/Shop.dart';
import 'package:delivery_owner/models/salesStock.dart';
import 'package:delivery_owner/models/user.dart';
import 'package:delivery_owner/ressources/productstock/productStockProvider.dart';
import 'package:delivery_owner/ressources/stockProductSales/SalesStockProvider.dart';
import 'package:delivery_owner/service/authservice.dart';
import 'package:delivery_owner/service/shopManagerService.dart';
import 'package:delivery_owner/ui/SalesUi/salesStockList.dart';
import 'package:delivery_owner/ui/productStock/productstock.dart';
import 'package:flutter/material.dart';
import 'package:delivery_owner/main.dart';
import 'package:delivery_owner/ui/widgets/iappBar.dart';
import 'package:delivery_owner/ui/widgets/ibackground4.dart';
import 'package:delivery_owner/ui/widgets/ibox.dart';
import 'package:delivery_owner/ui/widgets/ibutton.dart';
import 'package:delivery_owner/ui/widgets/iinputField2.dart';
import 'package:delivery_owner/ui/widgets/iinputField2Password.dart';
import 'package:fluttertoast/fluttertoast.dart';


class EditProductSales extends StatefulWidget {



  ShopModel shop ;
  ProductStockModel product ;
  SalesStockModel sales ;

  EditProductSales({Key key, this.shop, this.product , this.sales}) : super(key: key);
  @override
  _EditProductSalesState createState() => _EditProductSalesState();
}

class _EditProductSalesState extends State<EditProductSales>
    with SingleTickerProviderStateMixin {

  SalesStockModel _saleStockModel = SalesStockModel();

  String _devise = "usd";



  _pressCreateAccountButton() async{

    if( editcontrolNumber.text.isEmpty  || editControlprice.text.isEmpty){
      Fluttertoast.showToast(
          msg: "La quantité  et le prix ne doivent pas etre vide",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.blue,
          textColor: Colors.white,
          fontSize: 16.0
      );
    } else {


     // print("name : ${editcontrolName.text} et devise ${_devise}");

      _saleStockModel.number = int.parse(editcontrolNumber.text);

      _saleStockModel.price = double.parse(editControlprice.text) ;
      _saleStockModel.deviseType = _devise ;





      SalesStockService _productSalesService = SalesStockService();




      bool isCreate = await  _productSalesService.update( _saleStockModel);
      if(isCreate ) {

        int count = 0;
        // Navigator.of(context).pop();

        Navigator.of(context).pushReplacement(
            MaterialPageRoute(
                builder: (context) => SalesStockList( shop :widget.shop,productStockModel: widget.product,)
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

  final editcontrolNumber = TextEditingController();

  final editControlprice = TextEditingController();


  @override
  void initState() {
    _saleStockModel = widget.sales ;
    _devise = widget.sales.deviseType;

    editControlprice.text = widget.sales.price.toString();
    editcontrolNumber.text = widget.sales.number.toString();
    super.initState();


  }

  @override
  void dispose() {

    editControlprice.dispose();
    editcontrolNumber.dispose();


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
          child: Text("Ajouter une vente",                        // "Create an Account!"
              style: theme.text20boldWhite
          ),
        ),
        SizedBox(height: 20,),

        IBox(
            color: theme.colorBackgroundDialog,
            child: Column(
              children: <Widget>[
                SizedBox(height: 15,),
                Container(
                    margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child:
                    IInputField2(
                      hint: "Quantité : ",            // "Login"
                      icon: Icons.addchart_sharp,
                      colorDefaultText: Colors.blue,
                      colorBackground: theme.colorBackgroundDialog,
                      controller: editcontrolNumber,
                    )
                ),
                SizedBox(height: 10,),





                Row(

                  children: [
                    Container(
                        padding: EdgeInsets.only(left: 40),
                        child: Text("Devise  :    " ,style: TextStyle(color: Colors.blue,fontSize: 15),)),

                    DropdownButton(

                        value: _devise,
                        items: [
                          DropdownMenuItem(
                            child: Text("Dollars",style: TextStyle(color: Colors.blue,) ),
                            value: "usd",
                          ),
                          DropdownMenuItem(
                            child: Text("Franc" ,style: TextStyle(color: Colors.blue,)),
                            value: "fc",
                          ),

                        ],
                        onChanged: (value) {
                          setState(() {
                            _devise = value;
                            print("devise ${_devise}");
                          });
                        }),
                  ],
                ),

                SizedBox(height: 20,),
                Container(
                    margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child:
                    IInputField2(
                      hint: "Prix en ${_devise=="usd" ? "Dollars" : "Franc"}",            // "Login"
                      icon: Icons.account_balance_wallet_outlined,
                      colorDefaultText: Colors.blue,
                      colorBackground: theme.colorBackgroundDialog,
                      controller: editControlprice,
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