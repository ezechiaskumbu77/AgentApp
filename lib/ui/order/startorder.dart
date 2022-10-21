import 'dart:async';

import 'package:delivery_owner/model/shops.dart';
import 'package:delivery_owner/models/Shop.dart';
import 'package:delivery_owner/models/product.dart';
import 'package:delivery_owner/ressources/getZone.dart';
import 'package:delivery_owner/ui/order/selectAddress.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../ressources/getProduct.dart';
import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'selectShop.dart';
import '../../models/orderItemPPC.dart';
import '../../models/orderPPC.dart';

enum Delivery { yes, not }

class StartOrder extends StatefulWidget {
  OrderPPCModel order;
  ShopModel shop;
// OrderItemPPC surecast;
// OrderItemPPC surecem;

  StartOrder(this.order, this.shop);
  @override
  _StartOrderState createState() => _StartOrderState();
}

class _StartOrderState extends State<StartOrder> {
  OrderItemPPC surecemItem = OrderItemPPC();
  OrderItemPPC surecastItem = OrderItemPPC();
  // OrderPPCModel order = OrderPPCModel();
  double shippingPrice = 35000;
  GetProduct pro;
  getShippingPriceByShopZone() async {
    GetZone zon = GetZone();

    await zon.getZoneShippingPrice(widget.shop).then((value) {
      setState(() {

      //  shippingPrice = value;
        shippingPrice=(value==0)? 35000:value;
      });
    });
  }

  getAllProduct() async {
    pro = GetProduct();
   // print('Place Info : ' + widget.shop.place);
    return await pro.fetchAll(widget.shop);
  }

  int surecastqty = 0;
  int surecemqty = 0;
  double surecemPrix = 0, surecastPrix = 0;
  String deliveryText = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: 50, left: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  RaisedButton(
                      child: Text(
                        'Retour',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      color: Colors.red,
                      onPressed: () {
                        Navigator.of(context).pop();
                      }),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    child: Center(
                        child: Text(
                      'Commander',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    )),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Divider(
                    height: 3,
                  ),
                  _body(context)
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget sureCast() {
    return TextFormField(
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: 'Quantité',
          hintText: '',
        ),
        //   validator: validateEmail,
        onChanged: (String value) {
          setState(() {
            if (value == '') {
              surecastqty = 0;
              print('rien');
            } else {
              surecastqty = int.parse(value);
            }
          });
        },
        onSaved: (String value) {
          //  surecast = int.parse(value) ;
        });
  }

  Widget sureCem() {
    return TextFormField(
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: 'Quantité',
          hintText: '',
        ),
        //   validator: validateEmail,
        onChanged: (String value) {
          setState(() {
            if (value == '') {
              surecemqty = 0;
              print('rien');
            } else {
              surecemqty = int.parse(value);
            }
          });
        },
        onSaved: (String value) {
          //  surecast = int.parse(value) ;
        });
  }

  Widget surecemPrice(price) {
    return TextFormField(
        keyboardType: TextInputType.number,
        //  initialValue: price.toString(),
        decoration: InputDecoration(
          labelText: 'Prix modifié',
          hintText: '',
        ),
        //   validator: validateEmail,
        onChanged: (String value) {
          setState(() {
            if (value == '') {
              surecemPrix = price;
              print('rien');
            } else {
              surecemPrix = double.parse(value);
            }
          });
        },
        onSaved: (String value) {
          //  surecast = int.parse(value) ;
        });
  }

  Widget surecastPrice(price) {
    return TextFormField(
        //  initialValue: price.toString(),
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: 'Prix modifié',
          hintText: '',
        ),
        //   validator: validateEmail,
        onChanged: (String value) {
          setState(() {
            if (value == '') {
              surecastPrix = price;
              print('rien');
            } else {
              surecastPrix = double.parse(value);
            }
          });
        },
        onSaved: (String value) {
          //  surecast = int.parse(value) ;
        });
  }

  Widget surcastBody(String id, double price, String name, String desc) {
    surecastItem.price = price;

    surecastItem.productId = id;
    //surecastPrix=price;
    surecastItem.quantity = surecastqty;
    return Row(
      children: [
        Image.network(
          'https://www.moncongo.com/sites/default/files/images/business/photos/DRC%20SURECAST%20FRENCH_2016-09-20_1.jpg',
          fit: BoxFit.contain,
          width: 150,
          height: 150,
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(
          child: Column(
            children: [
              Text(
                '$name',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                '${surecastItem.price} FC',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              surecastPrice(price),
              SizedBox(
                height: 10,
              ),
              Text(
                ' Quantité: ${surecastqty} ',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              sureCast(),
              SizedBox(
                height: 10,
              ),
              Text(
                ' Sous-Total : ' +
                    (surecastqty *
                            ((surecastPrix != 0)
                                ? surecastPrix
                                : surecastItem.price))
                        .toString() +
                    ' FC',

                // ' Sous-Total : ${surecastqty * surecastPrix} FC',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
              ),
              // Text(
              //   _del == Delivery.yes
              //       ? ' Livraison : ${shippingPrice} FC'
              //       //? ' Livraison : ${surecastqty * 200} FC'
              //       : ' ',
              //   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
              // )
            ],
          ),
        )
      ],
    );
  }

  Delivery _del = Delivery.not;

  Widget surecemBody(String id, double price, String name, String desc) {
    surecemItem.price = price;

    surecemItem.productId = id;
    // surecemPrix=price;
    surecemItem.quantity = surecemqty;
    return Row(
      children: [
        Image.network(
          'https://ppc-jhb-web.azureedge.net/website/attachments/cjp2enumr019u0fqtwjfr3amx-surecem.full.png',
          fit: BoxFit.contain,
          width: 150,
          height: 150,
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(
          child: Column(
            children: [
              Text(
                '$name',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                '${surecemItem.price} FC',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              surecemPrice(price),
              SizedBox(
                height: 10,
              ),
              Text(
                ' Quantité: ${surecemqty} ',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              sureCem(),
              SizedBox(
                height: 10,
              ),
              Text(
                ' Sous-Total : ' +
                    (surecemqty *
                            ((surecemPrix != 0)
                                ? surecemPrix
                                : surecemItem.price))
                        .toString() +
                    ' FC',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
              // Text(
              //   _del == Delivery.yes ? 'Livraison : ${shippingPrice} FC' : '',
              //   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              // ),
            ],
          ),
        )
      ],
    );
  }

  Widget btnContinuer(BuildContext ctx, double castP, double cemP) {
    return ArgonButton(
      height: 50,
      roundLoadingShape: true,
      width: MediaQuery.of(ctx).size.width * 0.45,
      onTap: (startLoading, stopLoading, btnState) {
        if (btnState == ButtonState.Idle) {
          startLoading();

          Timer(const Duration(milliseconds: 1000), () {
            if ((surecastqty == 0) && (surecemqty == 0)) {
              Fluttertoast.showToast(
                  msg: 'Entrez la quantité pour continuer',
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0);
              stopLoading();
            } else {
              widget.order.totalPrice = ((surecemqty *
                          ((surecemPrix != 0)
                              ? surecemPrix
                              : surecemItem.price)) +
                      (surecastqty *
                          ((surecastPrix != 0)
                              ? surecastPrix
                              : surecastItem.price)) +
                      ((_del == Delivery.yes) ? shippingPrice : 0))
                  /*  ((surecemqty *
                          ((surecemPrix != 0)
                              ? surecemPrix
                              : surecemItem.price)) +
                      (_del == Delivery.yes ? surecemqty * 200 : 0) +
                      (surecastqty *
                          ((surecastPrix != 0)
                              ? surecastPrix
                              : surecastItem.price)) +
                      (_del == Delivery.yes
                          ? surecastqty * 200
                          : 0)) */
                  /*((surecastqty * castP) +
               (_del == Delivery.yes ? surecastqty * 200 : 0)) + 
               ((surecemqty * cemP) + (_del == Delivery.yes ? surecemqty * 200 : 0))*/
                  ;

              surecastItem.price = ((surecastPrix != 0) ? surecastPrix: surecastItem.price); // castP;
              
              surecemItem.price = ((surecemPrix != 0)? surecemPrix : surecemItem.price); //cemP;
              
              widget.order.toBeShipied=_del == Delivery.yes ? true:false;
              
              widget.order.shippingPrice= ( _del == Delivery.yes) ? shippingPrice : 0;
              
              stopLoading();

              Navigator.of(context).push(MaterialPageRoute( builder: (context) => SelectAddress(widget.order, surecastItem, surecemItem)));
            
            }
          });
        } else {
          stopLoading();
        }
      },
      child: Text(
        'Continuer',
        style: TextStyle(
            color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700),
      ),
      loader: Expanded(
        child: Container(
            padding: EdgeInsets.all(10),
            child: SpinKitWave(
                size: 16, color: Colors.white, type: SpinKitWaveType.start)),
      ),
      borderRadius: 5.0,
      color: Colors.blueAccent,
    );
  }

  Widget _body(BuildContext context) {
    return FutureBuilder(
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<ProductModel> listpro = snapshot.data;

          return SingleChildScrollView(
            child: Column(
              children: [
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  // color: Colors.white10,
                  elevation: 4,
                  child: Container(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        surcastBody(listpro[0].id, listpro[0].price,
                            listpro[0].name, listpro[0].description),
                        SizedBox(
                          height: 10,
                        ),
                        Divider(),
                        SizedBox(
                          height: 10,
                        ),
                        surecemBody(listpro[1].id, listpro[1].price,
                            listpro[1].name, listpro[1].description),
                        Divider(),
                        Column(
                          children: [
                            Row(
                              children: [
                                Radio(
                                  activeColor: Colors.blue,
                                  value: Delivery.not,
                                  groupValue: _del,
                                  onChanged: (Delivery value) {
                                    setState(() {
                                      _del = value;
                                      deliveryText = '';
                                    });
                                  },
                                ),
                                const Text(
                                  'Sans Livraison',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Radio(
                                  activeColor: Colors.blue,
                                  value: Delivery.yes,
                                  groupValue: _del,
                                  onChanged: (Delivery value) {
                                    setState(() {
                                      _del = value;
                                    });
                                  },
                                ),
                                const Text(
                                  'Avec Livraison',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Text(
                              ' Surcast Quantité  : ${surecastqty} ',
                              style: TextStyle(fontSize: 15),
                            ),
                            Text(
                              ' Surcem Quantité : ${surecemqty} ',
                              style: TextStyle(fontSize: 15),
                            ),
                            Text(
                              ' Total : ' +
                                  ((surecemqty *
                                              ((surecemPrix != 0)
                                                  ? surecemPrix
                                                  : surecemItem.price)) +
                                          (surecastqty *
                                              ((surecastPrix != 0)
                                                  ? surecastPrix
                                                  : surecastItem.price)) +
                                          ((_del == Delivery.yes) ? shippingPrice : 0))
                                      .toString() +
                                  ' FC',
/**
 ' Total : ' +
                                  ((surecemqty *
                                              ((surecemPrix != 0)
                                                  ? surecemPrix
                                                  : surecemItem.price)) +
                                          (_del == Delivery.yes
                                              ? surecemqty * 200
                                              : 0) +
                                          (surecastqty *
                                              ((surecastPrix != 0)
                                                  ? surecastPrix
                                                  : surecastItem.price)) +
                                          (_del == Delivery.yes
                                              ? surecastqty * 200
                                              : 0))
                                      .toString() +
                                  ' FC',
*/
                              //' Total : ${((surecemqty * listpro[1].price) + (_del == Delivery.yes ? surecemqty * 200 : 0)) + ((surecastqty * listpro[0].price) + (_del == Delivery.yes ? surecastqty * 200 : 0))} FC',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                //btnContinuer(context, surecemPrix, surecastPrix)
                btnContinuer(context, listpro[0].price, listpro[1].price)
              ],
            ),
          );
        }
        if (snapshot.hasError) {
          return Text('Error' + snapshot.error.toString());
        }

        return Center(
          child: Text('Chargement...'),
        );
      },
      future: getAllProduct(),
    );
  }
}
