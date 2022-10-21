import 'package:cached_network_image/cached_network_image.dart';
import 'package:delivery_owner/main.dart';
import 'package:delivery_owner/model/category.dart';
import 'package:delivery_owner/model/shops.dart';
import 'package:delivery_owner/model/shopreview.dart';
import 'package:delivery_owner/models/Shop.dart';
import 'package:delivery_owner/models/ShopProductStock.dart';
import 'package:delivery_owner/ressources/getShopProductStock.dart';
import 'package:delivery_owner/ui/widgets/ICard12FileCaching.dart';
import 'package:delivery_owner/ui/widgets/ICard1FileCaching.dart';
import 'package:delivery_owner/ui/widgets/ICard21FileCaching.dart';
import 'package:delivery_owner/ui/widgets/IList1.dart';
import 'package:delivery_owner/ui/widgets/iboxCircle.dart';
import 'package:delivery_owner/ui/widgets/iinkwell.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ShopDetailsStockScreen extends StatefulWidget {
  final ShopModel shop;

  ShopDetailsStockScreen({this.shop});
  //: super(key: key);
  @override
  _ShopDetailsStockScreenState createState() => _ShopDetailsStockScreenState();
}

class _ShopDetailsStockScreenState extends State<ShopDetailsStockScreen>
    with SingleTickerProviderStateMixin {
  ///////////////////////////////////////////////////////////////////////////////
  //

  _onBackClick() {
    Navigator.pop(context);
  }

  _onCategoriesClick(String id, String heroId) {
    _currentCategoryId = id;
    for (var item in categories) if (item.id == id) _categoryName = item.name;
    setState(() {});
  }

  _onShopClick(String id, String heroId) {}

  ///////////////////////////////////////////////////////////////////////////////
  var windowWidth;
  var windowHeight;
  var _currentCategoryId = '';
  var _controller = ScrollController();
  var _categoryName = '';
 
  
  @override
  void initState() {
    super.initState();
    getShopProductStock();
   
  }

  /*getShopProductStock() async {
    print(widget.shop.id);
 GetShopProductStock   getShopProductStocks = GetShopProductStock();
    await getShopProductStocks.fetchAll(widget.shop.id);
  }*/
var  listprod= [];
  getShopProductStock() async {
    print(widget.shop.id);
    GetShopProductStock   getShopProductStocks = GetShopProductStock();

    // await getShopProductStocks.fetchAll(widget.shop.id).then((value)
    // {
    //       setState({
    //         listprod=value;
    //       });
    // });

    await getShopProductStocks.fetchAll(widget.shop.id).then((value) {
         
            setState(() {
               listprod=value;
            });

            //print('knhdgbdjklgndlvldjvl: '+shopmanagerID);

         /* _firebaseMessaging.subscribeToTopic(shopmanagerID)
          .then((value) {
               print('subscribe success');
          })*/;

      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    windowWidth = MediaQuery.of(context).size.width;
    windowHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: theme.colorBackground,
        appBar: AppBar(
          elevation: 10,
          title: Text('Shop',
              style: TextStyle(
                  color: Colors.red,
                  fontSize: 20,
                  fontWeight: FontWeight.w900)),
        ),
        body: Column(children: [
          SizedBox(height: 20),
          Card(
              child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 14),
                  child: Column(children: [
                    Row(children: [
                      Icon(Icons.info, color: Colors.red ),
                      Text('  Information',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w800))
                    ]),
                    SizedBox(height: 15),
                    Row(children: [
                      Text('Shop : ',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w500)),
                      Text(widget.shop.name,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w700))
                    ]),
                       SizedBox(height: 13),
                    Row(children: [
                      Text('Capacité : ',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w500)),
                      Text(widget.shop.capacity.toString(),
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w700))
                    ]),
                    SizedBox(
                        height: 13,
                    ),
                    Row(children: [
                      Text('Ville : ',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w500)),
                      Text(widget.shop.ville.toString(),
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w700))
                    ]),
                    SizedBox(height: 20),
                    Divider(),
                    Row(children: [
                      Icon(Icons.location_on_rounded, color:Colors.red ),
                      Text('  Adresse ',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w700))]),
                                SizedBox(
                              height: 10,
                            ),
                    Text(widget.shop.address,
                    overflow: TextOverflow.fade,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w500)),
                    SizedBox(  height: 15,  ),
                    
                    SizedBox(height: 20),
                    Divider(),
                    Row(children: [
                      Icon(Icons.request_page_rounded, color: Colors.red ),
                      Text('  Stock',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w800))
                    ]),
                    SizedBox(height: 10),
                    shopStock()
                  ])))
        ]));
  }

  shopStock() {
   /*return FutureBuilder(
      future: getShopProductStock(),
      builder: (context, snapshop) {
     

        if (snapshop.hasData) {
              print(snapshop.data);
         // var listprod =<ShopProductStockModel>[];
          var listprod=  snapshop.data;
          print(listprod.length);
          
          if (listprod==null) {
             return Column(children: [
                  Row(children: [
                    Text('Surcem',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w500)),
                    Text(' : 0',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w700))
                  ]),
                  SizedBox(
                    height: 15,
                  ),
                  Row(children: [
                    Text('Surecast',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w500)),
                    Text(' : 0',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w700))
                  ]),
                ]);
          }

          return Column(children: [
            for (var prod in listprod)
              Row(children: [
                Text(prod['name'],
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w500)),
                Text(prod['inventorOnHand'].toString(),
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w700))
              ]),
            SizedBox(
              height: 15,
            ),
          ]);
        } else {
          if (snapshop.hasError) {
            print('see the snapshot' + snapshop.hasData.toString());
            return Text('Vérifier votre connexion ${snapshop.error}');
          }

          if (snapshop.connectionState == ConnectionState.done) {

            print('see the snapshot' + snapshop.hasData.toString());
            return Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
              child: Column(children: [
        Row(children: [
          Text('Surcem4',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w500)),
          Text(' : 0',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.w700))
        ]),
        SizedBox(
          height: 15,
        ),
        Row(children: [
          Text('Surecast4',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w500)),
          Text(' : 0',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.w700))
        ]),
      ]),
            );
          }

          return Text('Chargement... ');
        }
      },
    );
    */ if (listprod.length!=0) {
      // if (listprod!=null) {
      return Column(children: [
        for (var prod in listprod)
         Padding( 
        padding: EdgeInsets.symmetric(vertical: 10),
           child: Row(children: [
            Text(prod['name'] +' : ',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w500)),
            Text(prod['inventorOnHand'].toString(),
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.w700))
          ])),
        SizedBox(
          height: 15,
        ),
      ]);
    } else {
      return Column(children: [
        Row(children: [
          Text('Surcem',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w500)),
          Text(' : 0',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.w700))
        ]),
        SizedBox(
          height: 15,
        ),
        Row(children: [
          Text('Surecast',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w500)),
          Text(' : 0',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.w700))
        ]),
      ]);
    }
  }
}
