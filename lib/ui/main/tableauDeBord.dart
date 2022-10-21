import 'dart:async';

import 'package:delivery_owner/ui/main/choseProductType.dart';
import 'package:delivery_owner/ui/main/selectShopStock.dart';
import 'package:delivery_owner/ui/order/selectShop.dart';
import 'package:delivery_owner/ui/order/startorder.dart';
import 'package:delivery_owner/ui/widgets/ICard27.dart';
import 'package:flutter/material.dart';
import 'package:delivery_owner/main.dart';
import 'package:delivery_owner/model/order.dart';
import '../../models/orderPPC.dart';
import '../../ressources/getOrdersApi.dart';
import '../../ressources/localeDB.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';

class TableauDeBord extends StatefulWidget {
  final Function(String) callback;

  TableauDeBord({Key key, this.callback}) : super(key: key);

  @override
  _TableauDeBordState createState() => _TableauDeBordState();
}

int _currentTabIndex = 0;

class _TableauDeBordState extends State<TableauDeBord>
    with TickerProviderStateMixin {
  ///////////////////////////////////////////////////////////////////////////////
  //
  //

  _onCallback(OrderPPCModel order) {
//    print("User tap on order card with id: $id");
    account.currentOrder = order.id;
    account.backRoute = "orders";
    // widget.callback("orderDetails", order);
  }

  _tabIndexChanged() {
    print("Tab index is changed. New index: ${_tabController.index}");
    setState(() {});
    _currentTabIndex = _tabController.index;
  }

  //
  ///////////////////////////////////////////////////////////////////////////////
  double windowWidth = 0.0;
  double windowHeight = 0.0;
  TabController _tabController;
  final editController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    dprint("orders build");
    windowWidth = MediaQuery.of(context).size.width;
    windowHeight = MediaQuery.of(context).size.height;
    return Stack(
      children: [
        Center(
            child: Image.network(
                "https://www.moncongo.com/sites/default/files/images/business/photos/DRC%20SURECAST%20FRENCH_2016-09-20_1.jpg",
                fit: BoxFit.contain)),
        Container(
          color: Colors.black26,
        ),
        Container(
          margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 50),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    btn("Commander", "Commander", Colors.green),
                    SizedBox(
                      width: 10,
                    ),
                    btn("Stock", "stock", Colors.red),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    btn("Vente", "callback", Colors.brown),
                    SizedBox(
                      width: 10,
                    ),
                    btn("Produits", "callback", Colors.deepPurple),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    btn("Commandes", "orders", Colors.grey),
                    SizedBox(
                      width: 10,
                    ),
                    btn("Reclamations", "reclamation", Colors.purpleAccent),
                  ],
                ),
                SizedBox(
                  height: 50,
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget btn(String name, String callback, dynamic col) {
    return ArgonButton(
      height: 80,
      roundLoadingShape: true,
      width: MediaQuery.of(context).size.width * 0.45,
      onTap: (startLoading, stopLoading, btnState) {
        if (btnState == ButtonState.Idle) {
          startLoading();
          Timer(const Duration(milliseconds: 1000), () {
            stopLoading();

            if (callback == "Commander") {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => SelectShop()));
            } else if (callback == "stock") {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => SelectShopStock()));
            } else {
              widget.callback(callback);
            }

            // Navigator.of(context).push(
            // MaterialPageRoute(
            // builder: (context) => SelectShop(myOrder,surecastItem,surecemItem)
            //                     )
            //                                  );
          });
        } else {
          stopLoading();
        }
      },
      child: Text(
        name,
        style: TextStyle(
            color: Colors.white, fontSize: 22, fontWeight: FontWeight.w700),
      ),
      loader: Expanded(
        child: Container(
            padding: EdgeInsets.all(10),
            child: SpinKitWave(
                size: 16, color: Colors.white, type: SpinKitWaveType.start)),
      ),
      borderRadius: 5.0,
      color: col,
    );
  }
}
