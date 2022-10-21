import 'package:delivery_owner/model/category.dart';
import 'package:delivery_owner/model/shops.dart';
import 'package:delivery_owner/model/shop.dart';
import 'package:delivery_owner/ui/main/productDetails.dart';
import 'package:delivery_owner/ui/widgets/ICard21FileCaching.dart';
import 'package:delivery_owner/ui/widgets/easyDialog2.dart';
import 'package:delivery_owner/ui/widgets/ibackbutton.dart';
import 'package:delivery_owner/ui/widgets/ibutton2.dart';
import 'package:delivery_owner/ui/widgets/iline.dart';
import 'package:flutter/material.dart';
import 'package:delivery_owner/main.dart';

class ProductScreen extends StatefulWidget {
  final Function(String, Map<String, dynamic>) callback;
  final Map<String, dynamic> params;
  ProductScreen({Key key, this.callback, this.params}) : super(key: key);

  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {

  ///////////////////////////////////////////////////////////////////////////////
  //
  //
  _openProductDetails(String id, String hero){
    for (var item in dishes)
      if (item.id == id) {
        for (var rest in restaurants)
          if (rest.id == item.id) {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      DishesDetailsScreen(params: {
                        "heroid": hero,
                        "id": item.id,
                        "image": item.image,
                        "name": item.name,
                        "desc": item.desc,
                        "ingredients": item.details,
                        "price" : item.price,
                        "currency" : item.currency,
                        "nameRestaurant" : rest.name,
                        "phone": rest.phone,
                        "mobilephone": rest.mobilePhone,
                      },),
                ));
          }
      }
  }

  _addNewProduct(){

    widget.callback("addDishes", {
      "backRoute" : "dishes",
      "savedRoute" : _getStringParam("backRoute"),
      "sort": _getStringParam("sort"),
    });
  }

  _deleteShop(String id){
    print("Need delete product with id: $id");
  }

  _onEditButtonPress(String id){
    for (var item in dishes)
      if (item.id == id) {
        widget.callback("editDishes",
            {"backRoute": "dishes", "edit": "true", "id": id,
              "savedRoute" : _getStringParam("backRoute"),
              "sort": _getStringParam("sort"),
              "name" : item.name, "price" : item.price.toString(),
              "descPrice" : item.discPrice, "ingr" : item.details,
              "desc" : item.desc, "image" : item.image,
              "CategoryId" : item.category
            });
      }
  }

  _onBackPressed(){
    widget.callback(_getStringParam("backRoute"), {});
  }

  //
  ///////////////////////////////////////////////////////////////////////////////
  double windowWidth = 0.0;
  double windowHeight = 0.0;

  @override
  Widget build(BuildContext context) {
    windowWidth = MediaQuery.of(context).size.width;
    windowHeight = MediaQuery.of(context).size.height;
    return WillPopScope(
        onWillPop: () async {
          if (_show != 0){
            setState(() {
              _show = 0;
            });
          }else
            _onBackPressed();
          return false;
        },
    child: Stack(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top+50),
          child: _body(),
        ),

        IEasyDialog2(setPosition: (double value){_show = value;}, getPosition: () {return _show;}, color: theme.colorGrey,
          body: _body3(), backgroundColor: theme.colorBackground,),

        Container(
          margin: EdgeInsets.only(left: 5, top: 40),
          alignment: Alignment.topLeft,
          child: IBackButton(onBackClick: (){
            _onBackPressed();
          }, color: theme.colorPrimary, iconColor: Colors.white),
        ),
      ],
    ));
  }

  _body(){
    return ListView(
      padding: EdgeInsets.only(top: 0),
      children: _body2(),
    );
  }

  String _getStringParam(String name){
    if (widget.params != null){
      var _ret = widget.params[name];
      if (_ret == null)
        _ret = "";
      return _ret;
    }
    return "";
  }

  _body2(){
    var list = List<Widget>();

    list.add(SizedBox(height: 20,));

    var height = windowWidth*0.3;
    var sort = _getStringParam("sort");

    for (var item in dishes) {
      if ((sort.isNotEmpty && item.shopId == sort) ||  sort.isEmpty) {
        var text = "";
        for (var cat in categories)
          if (cat.id == item.category)
            text = "${strings.get(135)}: ${cat.name}"; // "Category",

        list.add(Container(
            width: windowWidth,
            height: height,
            child: ICard21FileCaching(
              colorProgressBar: theme.colorPrimary,
              color: theme.colorBackground,
              text: item.name,
              text3: text,
              textStyle3: theme.text14,
              enableFavorites: false,
              width: windowWidth - 20,
              height: height,
              image: item.image,
              id: item.id,
              text2: "${item.currency}${item.price.toStringAsFixed(2)}",
              textStyle: theme.text16bold,
              textStyle2: theme.text14primary,
              callback: _openProductDetails,
            )));
        _addButtonsDeleteEdit(list, item.id);
        list.add(ILine());
      }
    }

    list.add(SizedBox(height: 15,));

    _addNewButton(list);

    list.add(SizedBox(height: 150,));

    return list;
  }

  _addNewButton(List<Widget> list){
    list.add(Container(
      alignment: Alignment.center,
      child: IButton2(
          color: theme.colorPrimary,
          text: strings.get(138), // Add new Dishes
          textStyle: theme.text14boldWhite,
          pressButton: (){
            _addNewProduct();
          }
      ),
    ));
  }

  _addButtonsDeleteEdit(List<Widget> list, String id){
    list.add(Container(
      margin: EdgeInsets.only(left: 10, right: 10),
        child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        /*IButton2(
            color: theme.colorPrimary,
            text: strings.get(108), // Edit
            textStyle: theme.text14boldWhite,
            pressButton: (){
              _onEditButtonPress(id);
            }
        ),
        SizedBox(width: 10,),
        IButton2(
            color: Colors.red,
            text: strings.get(107), // Delete
            textStyle: theme.text14boldWhite,
            pressButton: (){
              _showMessage(id);
            }
        ),*/
      ],
    )));
  }

  double _show = 0;
  String _deleteId = "";

  _showMessage(String id){
    _deleteId = id;
    if (mounted)
      setState(() {
        _show = 1;
      });
  }

  _body3(){
    return Container(
      width: windowWidth,
        child: Column(
          children: [
            Text(strings.get(111), textAlign: TextAlign.center, style: theme.text18boldPrimary,), // "Are you sure?",
            SizedBox(height: 20,),
            Text(strings.get(112), textAlign: TextAlign.center, style: theme.text16,), // "You will not be able to recover this item!"
            SizedBox(height: 50,),
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IButton2(
                  color: Colors.red,
                  text: strings.get(109), // Yes, delete it!
                  textStyle: theme.text14boldWhite,
                  pressButton: (){
                    setState(() {
                      _show = 0;
                    });
                    _deleteShop(_deleteId);
                  }
              ),
              SizedBox(width: 10,),
              IButton2(
                  color: theme.colorPrimary,
                  text: strings.get(110), // No, cancel plx!
                  textStyle: theme.text14boldWhite,
                  pressButton: (){
                    setState(() {
                      _show = 0;
                    });
                  }
              ),
            ],
          )),

          ],
        )
    );
  }


}

