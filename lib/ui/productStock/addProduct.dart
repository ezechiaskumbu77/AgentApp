import 'package:delivery_owner/models/ProductStock.dart';
import 'package:delivery_owner/models/Shop.dart';
import 'package:delivery_owner/models/user.dart';
import 'package:delivery_owner/ressources/productstock/productStockProvider.dart';
import 'package:delivery_owner/service/authservice.dart';
import 'package:delivery_owner/service/shopManagerService.dart';
import 'package:flutter/material.dart';
import 'package:delivery_owner/main.dart';
import 'package:delivery_owner/ui/widgets/iappBar.dart';
import 'package:delivery_owner/ui/widgets/ibackground4.dart';
import 'package:delivery_owner/ui/widgets/ibox.dart';
import 'package:delivery_owner/ui/widgets/ibutton.dart';
import 'package:delivery_owner/ui/widgets/iinputField2.dart';
import 'package:delivery_owner/ui/widgets/iinputField2Password.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'productstock.dart';

class AddProductStock extends StatefulWidget {



  ShopModel shop ;

  AddProductStock({Key key, this.shop }) : super(key: key);
  @override
  _AddProductStockState createState() => _AddProductStockState();
}

class _AddProductStockState extends State<AddProductStock>
    with SingleTickerProviderStateMixin {

  ProductStockModel _productStockModel = ProductStockModel();

  String _devise = "usd";


  DateTime selectedDate = DateTime.now();
  _pressCreateAccountButton() async{

    if( editcontrolName.text.isEmpty  || editControlprice.text.isEmpty){
      Fluttertoast.showToast(
          msg: "Le nom et le prix ne doivent pas etre vide",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.blue,
          textColor: Colors.white,
          fontSize: 16.0
      );
    } else {


      print("name : ${editcontrolName.text} et devise ${_devise}");
      _productStockModel.shop = widget.shop.id;
      _productStockModel.name = editcontrolName.text;
      _productStockModel.price = editControlprice.text;
      _productStockModel.deviseType = _devise ;
      _productStockModel.startingInvertory = int.parse(editControlstartingInvertory.text) ;
      _productStockModel.description = editcontrolDescription.text;




      StockProductService _productStockService = StockProductService();




      bool isCreate = await  _productStockService.create( _productStockModel);
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
  String choseDate = 'Choisir la date';
  var windowHeight;

  final editcontrolName = TextEditingController();
  final editcontrolDescription = TextEditingController();
  final editControlprice = TextEditingController();
  final editControlstartingInvertory = TextEditingController();
  //final editControllerPassword2 = TextEditingController();

  @override
  void initState() {
    super.initState();


  }

  @override
  void dispose() {
    editcontrolName.dispose();
    editcontrolDescription.dispose();
    editControlprice.dispose();
    editControlstartingInvertory.dispose();

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
          child: Text("Ajouter un produit",                        // "Create an Account!"
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
                      hint: "Nom du produit",            // "Login"
                      icon: Icons.code,
                      colorDefaultText: Colors.blue,
                      colorBackground: theme.colorBackgroundDialog,
                      controller: editcontrolName,
                    )
                ),
                SizedBox(height: 10,),
                Container(
                    margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child:
                    IInputField2(
                      hint: "Description",            // "E-mail address",
                      icon: Icons.subject,
                      colorDefaultText:Colors.blue,
                      colorBackground: theme.colorBackgroundDialog,
                      controller: editcontrolDescription,
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
                    margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child:
                    IInputField2(
                      hint: "Stock Initial ",            // "Login"
                      icon: Icons.addchart_sharp,
                      colorDefaultText: Colors.blue,
                      colorBackground: theme.colorBackgroundDialog,
                      controller: editControlstartingInvertory,
                    )
                ),

                SizedBox(height: 20,),
                Container(
                  margin: EdgeInsets.only(left: 20, right: 20),
                  child: IButton(pressButton: _pressCreateAccountButton, text: "Créer ", // CREATE ACCOUNT
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