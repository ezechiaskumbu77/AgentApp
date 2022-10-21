import 'package:delivery_owner/models/ProductStock.dart';
import 'package:delivery_owner/models/SalesShop.dart';
import 'package:delivery_owner/models/Shop.dart';
import 'package:delivery_owner/models/ShopProduct.dart';
import 'package:delivery_owner/models/salesStock.dart';
import 'package:delivery_owner/models/user.dart';
import 'package:delivery_owner/ressources/productstock/productStockProvider.dart';
import 'package:delivery_owner/ressources/salesproduct/SalesppcProvider.dart';
import 'package:delivery_owner/ressources/stockProductSales/SalesStockProvider.dart';
import 'package:delivery_owner/service/authservice.dart';
import 'package:delivery_owner/service/shopManagerService.dart';
import 'package:delivery_owner/ui/SalesUi/salesStockList.dart';
import 'package:delivery_owner/ui/main/SeePPCStock.dart';
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


class EditPPCProductSales extends StatefulWidget {



  ShopModel shop ;
  ShopProductModel product ;
  SaleShopModel sales ;

  EditPPCProductSales({Key key, this.shop, this.product , this.sales}) : super(key: key);
  @override
  _EditPPCProductSalesState createState() => _EditPPCProductSalesState();
}

class _EditPPCProductSalesState extends State<EditPPCProductSales>
    with SingleTickerProviderStateMixin {

  SaleShopModel _saleStockModel = SaleShopModel();

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
      _saleStockModel.shop = widget.shop.id;
      _saleStockModel.number = int.parse(editcontrolNumber.text);
      _saleStockModel.shopproduct = widget.product.id;
      _saleStockModel.price = double.parse(editControlprice.text) ;
      _saleStockModel.deviseType = _devise ;
      _saleStockModel.prixTotal = double.parse(_total) ;
      _saleStockModel.discount =_discount;





      SalesPPCStockService _productSalesService = SalesPPCStockService();




      bool isUpdate = await  _productSalesService.update( _saleStockModel);
      if(isUpdate ) {

        int count = 0;
        // Navigator.of(context).pop();

        Navigator.of(context).pushReplacement(
            MaterialPageRoute(
                builder: (context) => SeePPCStock( shop :widget.shop)
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
String _total = "0";
  var windowHeight;

  final editcontrolNumber = TextEditingController();
  final editControlerPrixTotal = TextEditingController();
  final editControlerDiscount = TextEditingController();

  final editControlprice = TextEditingController();


  @override
  void initState() {
    _saleStockModel = widget.sales;
    _devise = widget.sales.deviseType;
    editcontrolNumber.text = widget.sales.number.toString();
    //_total = widget.sales.prixTotal.toString();

    editControlerDiscount.text = widget.sales.discount.toString();
    editControlprice.text = widget.sales.price.toString();
    _quantity = int.parse(editcontrolNumber.text) ;
    _price = double.parse(editControlprice.text);
    _discount = double.parse( editControlerDiscount.text) ;



  // editControlprice.text = _devise == "usd"?  widget.product.priceUsd.toString() : widget.product.priceFc.toString();
     super.initState();

  //  _price = double.parse(editControlprice.text);
   // _price = double.parse(editcontrolNumber.text);


  }

  @override
  void dispose() {

    editControlprice.dispose();
    editControlerDiscount.dispose();
    editControlerPrixTotal.dispose();
    editcontrolNumber.dispose();



    //  editControllerPassword2.dispose();
    super.dispose();
  }
  int _quantity = 0;
  double _price = 0;
  double _discount =0;
  void onChangeTxtQuantity(String value) {
    setState(() {
      _quantity = int.parse(value);
    });



  }


  void onChangeTxtPrice(String value) {

        setState(() {
          _price = double.parse(value);

        });

  }

  void onChangeTxtDiscount(String value) {


    setState(() {
      _discount = double.parse(value);

    });

  }




  @override
  Widget build(BuildContext context) {

    //editControlerPrixTotal.text = ((_quantity * _price -_discount)).toString();
    _total = (((_quantity * _price )-_discount)).toString();



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
        Container(
          margin: EdgeInsets.only(left: 15, right: 20),
          alignment: Alignment.centerLeft,
          child: Text("${widget.product.name}",                        // "Create an Account!"
              style: TextStyle(fontSize: 18, color: Colors.white, fontStyle: FontStyle.italic)
          ),
        ),
        SizedBox(height: 20,),

        IBox(
            color: theme.colorBackgroundDialog,
            child: Column(
              children: <Widget>[
                SizedBox(height: 15,),
                Row(

                  children: [
                    Container(
                        padding: EdgeInsets.only(left: 40),
                        child: Text("Quantité de ciment " ,style: TextStyle(color: Colors.blue,fontSize: 16,fontWeight: FontWeight.bold),)),


                  ],
                ),
                Container(
                    margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child:
                    IInputField2(
                      hint: "Quantité : ",            // "Login"
                      icon: Icons.addchart_sharp,
                      colorDefaultText: Colors.blue,
                      colorBackground: theme.colorBackgroundDialog,
                      controller: editcontrolNumber,
                      onChangeText: onChangeTxtQuantity,
                    )
                ),
                SizedBox(height: 10,),





                Row(

                  children: [
                    Container(
                        padding: EdgeInsets.only(left: 40),
                        child: Text("Devise  :    " ,style: TextStyle(color: Colors.blue,fontSize: 16, fontWeight: FontWeight.bold), )),

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
                            // if(editControlprice.text == _price.toString()){
                            //   _price = double.parse(editControlprice.text );
                            // }


                            if(editControlprice.text == widget.product.priceUsd.toString() || editControlprice.text == widget.product.priceFc.toString()){
                              editControlprice.text = _devise == "usd"?  widget.product.priceUsd.toString() : widget.product.priceFc.toString();
                              _price = double.parse(editControlprice.text );

                            }
                         //   _total = ((_quantity * double.parse(editControlprice.text)  -_discount)).toString();


                            print("devise ${_devise}");
                          });
                        }),
                  ],
                ),
                SizedBox(height: 15,),
                Row(

                  children: [
                    Container(
                        padding: EdgeInsets.only(left: 40),
                        child: Text("Prix unitaire en ${_devise=="usd" ? "Dollars" : "Franc"}  :    " ,style: TextStyle(color: Colors.blue,fontSize: 16,fontWeight: FontWeight.bold),)),


                  ],
                ),




                Container(
                    margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child:
                    IInputField2(
                      hint: "Prix unitaire : ",            // "Login"
                      icon: Icons.addchart_sharp,
                      colorDefaultText: Colors.blue,
                      colorBackground: theme.colorBackgroundDialog,
                      controller: editControlprice,
                      onChangeText: onChangeTxtPrice,
                    )
                ),
                SizedBox(height: 10,),
                Row(

                  children: [
                    Container(
                        padding: EdgeInsets.only(left: 40),
                        child: Text("Reduction en ${_devise=="usd" ? "Dollars" : "Franc"}  :    " ,style: TextStyle(color: Colors.blue,fontSize: 15,fontWeight: FontWeight.bold),)),


                  ],
                ),

                Container(
                    margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child:
                    IInputField2(
                      hint: "0.0",            // "Login"
                      icon: Icons.addchart_sharp,
                      colorDefaultText: Colors.blue,
                      colorBackground: theme.colorBackgroundDialog,
                      controller: editControlerDiscount,
                      onChangeText: onChangeTxtDiscount,
                    )
                ),
                SizedBox(height: 20,),
                Row(

                  children: [
                    Expanded(
                      child: Container(
                          padding: EdgeInsets.only(left: 40),
                          child: Text("TOTAL  :   ${_total}   ${_devise=="usd" ? "usd" : "fc"}" ,style: TextStyle(color: Colors.red,fontSize: 18, fontWeight: FontWeight.bold),)),
                    ),


                  ],
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