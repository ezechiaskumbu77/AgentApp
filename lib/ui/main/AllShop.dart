import 'package:delivery_owner/model/shop.dart';
import 'package:delivery_owner/models/user.dart';
import 'package:delivery_owner/ui/main/chooseShopmanager.dart';
import 'package:delivery_owner/ui/main/createShop.dart';
import 'package:delivery_owner/ui/main/newEditShop.dart';
import 'package:delivery_owner/ui/main/shopDetails.dart';
import 'package:delivery_owner/ui/main/shopDetailsStock.dart';
import 'package:delivery_owner/ui/widgets/ICard20FileCaching.dart';
import 'package:delivery_owner/ui/widgets/easyDialog2.dart';
import 'package:delivery_owner/ui/widgets/ibutton2.dart';
import 'package:delivery_owner/ui/widgets/iline.dart';
import 'package:flutter/material.dart';
import 'package:delivery_owner/main.dart';
import '../../ressources/getShop.dart';
import '../../models/Shop.dart';

class AllShopScreen extends StatefulWidget {
  final Function(String, Map<String, dynamic>) callback;
  UserModel userL ;
  BuildContext ctx;
  AllShopScreen({Key key, this.callback , this.userL, this.ctx}) : super(key: key);

  @override
  _AllShopScreenState createState() => _AllShopScreenState();
}

class _AllShopScreenState extends State<AllShopScreen> {

  ///////////////////////////////////////////////////////////////////////////////
  //
  //
  GetShop shop;
  getAllShop () async{
      shop =GetShop(); 
      return await  shop.fetchAll(); 
  }

  _openShopDetails(String id, String hero){

    for (var item in restaurants)
      if (item.id == id) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ShopDetailsScreen(params: {
                "heroid" : hero,
                "id" : item.id, "image" : item.image, "phone" : item.phone,
                "mobilephone" : item.mobilePhone,
                "name" : item.name, "desc" : item.desc,
              },),
            ));
      }
      
  }

  _onProductListButton(String id){

    for (var item in restaurants)
      if (item.id == id) {
        widget.callback("dishes", {"backRoute": "restaurants", "sort": item.id});
      }
  }

  _addNewShop(){
    Navigator.of(context).push(
    MaterialPageRoute(builder: (_) => SelectShopManager(callback: widget.callback,userL: widget.userL,ctx: context))

    );
  }

  _deleteShop(String id){

  }

  _onEditButtonPress(ShopModel shop){


    print("Edit");
    Navigator.of(context).push(

        MaterialPageRoute(builder: (_) => NewEdit(callback: widget.callback,userL: widget.userL,ctx: context, shop: shop,))
    );


      //  widget.callback("editRestaurant", {"shop": shop });

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
      if (_show != 0) {
        setState(() {
          _show = 0;
        });
      }
      return false;
    },
    child: Stack(

      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top+50),
          child: Column(
          children: [

        //    _addNewButton(),

            Expanded(child:  _body(context))
           ,



          ],
          ),
        ),

        IEasyDialog2(setPosition: (double value){_show = value;}, getPosition: () {return _show;}, color: theme.colorGrey,
          body: _body3(), backgroundColor: theme.colorBackground,),

      ],
    ));
  }

  _body(BuildContext context){
    return  FutureBuilder(
        future: getAllShop(),
        builder: (context,snapshop) {

          

    if(snapshop.hasData){
          print(snapshop.data);
    List<ShopModel> listShop = snapshop.data ;

    if(listShop.length < 1 || listShop.isEmpty){
          return Text("Vous n'avez pas de Dépot");
    }

    return  ListView.builder(
      shrinkWrap: true,
      itemBuilder: (context, index){

        var height = windowWidth*0.4;
        return  Column(

          children: [
            SizedBox(height: 20,),
            Container(
                width: windowWidth,
                height: height,
                child: ICard20FileCaching(
                  color: theme.colorBackground,
                  colorProgressBar: theme.colorPrimary,
                  text: listShop[index].name==null ? " " : listShop[index].name,
                  text2: listShop[index].address==null ? " " :  listShop[index].address,
                  text3:  "",//phone
                  image:  "https://live.staticflickr.com/5242/5252707576_03f729e2c5_b.jpg",// image
                  colorRoute: theme.colorPrimary,
                  id: listShop[index].id==null ? "" :  listShop[index].id ,
                  title: theme.text18boldPrimary,
                  body: theme.text16,
                  callbackNavigateIcon: _navigate,
                  callback: _openShopDetails,
                )),

       _addButtonsDeleteEdit(listShop[index], listShop[index].id),
            ILine(),

            SizedBox(height: 15,),







          ],
        );
      },
      itemCount: listShop.length,
      padding: EdgeInsets.only(top: 0),

    );


    } else {

      if (snapshop.hasError){
        print("see the snapshot"+snapshop.hasData.toString());
        return Text("Vérifier votre connexion");
      }


      if(snapshop.connectionState==ConnectionState.done){
        return Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
          child: Text("Vous n'avez pas de Dépot "),
        );
      }

      // return Text("Chargement... ");
       return Center(
          child: CircularProgressIndicator(backgroundColor: Colors.black12,),
        );
    }

    },


        );
  }

  _body2(){
    var list = List<Widget>();

    list.add(SizedBox(height: 20,));

    var height = windowWidth*0.4;

    for (var item in restaurants) {
      list.add(Container(
        width: windowWidth,
        height: height,
          child: ICard20FileCaching(
            color: theme.colorBackground,
            colorProgressBar: theme.colorPrimary,
            text: item.name,
            text2: item.address,
            text3: item.phone,
            image: item.image,
            colorRoute: theme.colorPrimary,
            id: item.id,
            title: theme.text18boldPrimary,
            body: theme.text16,
            callbackNavigateIcon: _navigate,
            callback: _openShopDetails,
      )));
   //   _addButtonsDeleteEdit(item.id);
      list.add(ILine());

    }

    list.add(SizedBox(height: 15,));

    _addNewButton();

    list.add(SizedBox(height: 150,));

    return list;
  }

  _navigate(String id){
    for (var item in restaurants)
      if (item.id == id) {
        widget.callback("mapRestaurant", {"lat" : item.lat, "lng" : item.lng, "backRoute" : "restaurants"});
      }
  }

  _addNewButton(){
   return (Container(
      alignment: Alignment.center,
      child: IButton2(
          color: theme.colorPrimary,
          text: strings.get(106), // Add new Restaurant
          textStyle: theme.text14boldWhite,
          pressButton: (){
            _addNewShop();
          }
      ),
    ));
  }

  _addButtonsDeleteEdit(ShopModel shop, String id){
  return Container(
      margin: EdgeInsets.only(left: 10, right: 10),
        child: Row(
      //mainAxisAlignment: MainAxisAlignment.end,
      children: [
         IButton2(
             color: Colors.red,
             text: 'Mon Stock', // 'Dishes List'
             textStyle: theme.text14boldWhite,
             pressButton: (){
               Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ShopDetailsStockScreen(shop:shop),
                    ));
                  }
        ),
        /*Expanded(
          child: Container(),
        ),
        IButton2(
            color: Colors.green,
            text: strings.get(108), // Edit
            textStyle: theme.text14boldWhite,
            pressButton: (){
              _onEditButtonPress(shop);
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
    ));
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
                  text: strings.get(109),                     // Yes, delete it!
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
                  text: strings.get(110),                 // No, cancel plx!
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

