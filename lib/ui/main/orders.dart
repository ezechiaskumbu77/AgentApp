import 'package:delivery_owner/ui/widgets/ICard27.dart';
import 'package:flutter/material.dart';
import 'package:delivery_owner/main.dart';
import 'package:delivery_owner/model/order.dart';
import '../../models/orderPPC.dart';
import '../../ressources/getOrdersApi.dart';
import '../../ressources/localeDB.dart';

class OrdersScreen extends StatefulWidget {
  final Function(String, dynamic) callback;

  OrdersScreen({Key key, this.callback}) : super(key: key);

  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

int _currentTabIndex = 0;

class _OrdersScreenState extends State<OrdersScreen>
    with TickerProviderStateMixin {
  ///////////////////////////////////////////////////////////////////////////////
  //
  //

  LocalDB db = LocalDB();
  var _myF;
  GetOrder getOrder;

  _onCallback(OrderPPCModel order) {
//    print("User tap on order card with id: $id");
    account.currentOrder = order.id;
    account.backRoute = "orders";
    widget.callback("orderDetails", order);
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
    _tabController = TabController(vsync: this, length: 2);
    _tabController.addListener(_tabIndexChanged);
    _tabController.animateTo(_currentTabIndex);
    getOrder = GetOrder();
    _myF = getOrder.fetchAll();
    super.initState();
  }

  @override
  void dispose() {
    editController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    dprint("orders build");
    windowWidth = MediaQuery.of(context).size.width;
    windowHeight = MediaQuery.of(context).size.height;
    return Stack(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 50),
          height: 30,
          child: TabBar(
            indicatorColor: theme.colorPrimary,
            labelColor: Colors.black,
            isScrollable: true,
            tabs: [
              Text(strings.get(41), // "All",
                  textAlign: TextAlign.center,
                  style: theme.text14),
              Text(strings.get(95), // "Received",
                  textAlign: TextAlign.center,
                  style: theme.text14),
              // Text(strings.get(42),     // "Preparing",
              //     textAlign: TextAlign.center,
              //     style: theme.text14
              // ),
              // Text(strings.get(43),     // "Ready",
              //     textAlign: TextAlign.center,
              //     style: theme.text14
              // ),
              // Text(strings.get(96),     // "On the way",
              //     textAlign: TextAlign.center,
              //     style: theme.text14
              // ),
              // Text(strings.get(97),     // "Delivered",
              //     textAlign: TextAlign.center,
              //     style: theme.text14
              // ),
            ],
            controller: _tabController,
          ),
        ),
        SafeArea(
            child: FutureBuilder(
          future: _myF,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) {
              // return Center(
              // child: Text(
              // "Something yes ${snapshot.hasData}wrong with message: ${snapshot.error.toString()}"),
              // );
              if (snapshot.connectionState == ConnectionState.done) {
              } else {
                print("has data ${snapshot.hasData}");
                return Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.black12,
                  ),
                );
              }
            }

            if (snapshot.connectionState == ConnectionState.done) {
              List<OrderPPCModel> orderList;
              if (snapshot.data != null) {
                orderList = snapshot.data;
              }
              if (orderList == null) {
                // return Center(
                // child: Text(
                // "Something wrong with message: ${snapshot.error.toString()}"),
                // );

                return Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    UnconstrainedBox(
                        child: Container(
                            height: windowHeight / 3,
                            width: windowWidth / 2,
                            child: Container(
                              child: Image.asset(
                                "assets/nonotify.png",
                                fit: BoxFit.contain,
                              ),
                            ))),
                    SizedBox(
                      height: 20,
                    ),
                    Text(strings.get(50), // "Not Have Orders",
                        overflow: TextOverflow.clip,
                        style: theme.text16bold),
                    SizedBox(
                      height: 50,
                    ),
                  ],
                ));
              } else {
                return Container(
                    margin: EdgeInsets.only(
                        top: MediaQuery.of(context).padding.top + 90),
                    child: TabBarView(
                      controller: _tabController,
                      children: <Widget>[
                        Container(
                          child: _body("all", orderList),
                        ),

                        Container(
                          child: _body("pending", orderList),
                        ),

                        // Container(
                        //   child:_body(1),
                        // ),
                        //
                        // Container(
                        //   child:_body(2),
                        // ),
                        //
                        // Container(
                        //   child:_body(3),
                        // ),
                        //
                        // Container(
                        //   child:_body(4),
                        // ),
                      ],
                    ));
              }
            } else {
              return Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.black12,
                ),
              );
            }
          },
        ))
      ],
    );
  }

  _body(String status, List<OrderPPCModel> listOrder) {
    int size = 0;
    for (var _data in listOrder)
      if (_data.status == status || status == "all") size++;

    if (size == 0)
      return Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          UnconstrainedBox(
              child: Container(
                  height: windowHeight / 3,
                  width: windowWidth / 2,
                  child: Container(
                    child: Image.asset(
                      "assets/nonotify.png",
                      fit: BoxFit.contain,
                    ),
                  ))),
          SizedBox(
            height: 20,
          ),
          Text(strings.get(50), // "Not Have Orders",
              overflow: TextOverflow.clip,
              style: theme.text16bold),
          SizedBox(
            height: 50,
          ),
        ],
      ));
    return ListView(
      padding: EdgeInsets.only(top: 0, left: 5, right: 5),
      children: _body2(status, listOrder),
    );
  }

  _body2(String status, List<OrderPPCModel> listOrder) {
    var list = List<Widget>();

    for (var _data in listOrder) {
      if (_data.status == status || status == "all") {
        var _balloonText = strings.get(95); // "Received"
        Color _balloonColor = theme.colorCompanion3;
        if (_data.status == 1) {
          _balloonText = strings.get(42); // "Preparing"
          _balloonColor = theme.colorPrimary;
        }

        if (_data.status == "pending") {
          _balloonText = "En attente"; //strings.get(42); // "Preparing"
          _balloonColor = theme.colorPrimary;
        }

        if (_data.status == 2) {
          _balloonText = strings.get(43); // "Ready",
          _balloonColor = theme.colorCompanion4;
        }
        if (_data.status == 3) {
          _balloonText = strings.get(96); // "On the way",
          _balloonColor = theme.colorCompanion2;
        }
        if (_data.status == 4) {
          _balloonText = strings.get(97); // "Delivered",
          _balloonColor = Colors.blue;
        }

        list.add(ICard27(
          order: _data,
          color: theme.colorBackgroundDialog,
          colorRoute: theme.colorPrimary,
          id: _data.id,
          text:
              "${strings.get(44)} #${_data.id.substring(1, 5)}", // Order ID122
          textStyle: theme.text18boldPrimary,
          text2:
              "${strings.get(45)}: ${_data.WhenMade == null ? " " : _data.WhenMade}", // Date: 2020-07-08 12:35
          text2Style: theme.text14,
          text3:
              "Fc ${_data.totalPrice == null ? " " : _data.totalPrice.toStringAsFixed(2)}",
          text3Style: theme.text14bold,
          text4: _data.paymentMethode == null
              ? " "
              : _data.paymentMethode, // cache on delivery
          text4Style: theme.text14,
          text5: "${strings.get(52)}:", // Customer name",
          text5Style: theme.text16,
          text6: "PPC",
          text6Style: theme.text18boldPrimary,
          text7: _data.shippingAdress == null ? " " : _data.shippingAdress,
          text7Style: theme.text14,
          callback: _onCallback,
          //
          balloon: true,
          balloonColor: _balloonColor,
          balloonText: _balloonText,
          balloonStyle: theme.text14boldWhite,
        ));
      }
    }
    list.add(SizedBox(
      height: 100,
    ));
    return list;
  }

  slideRightBackground() {
    return Container(
      color: Colors.red,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          UnconstrainedBox(
              child: Container(
                  height: 25,
                  width: 25,
                  child: Image.asset("assets/delete.png",
                      fit: BoxFit.contain, color: Colors.white))),
          SizedBox(
            width: 20,
          ),
        ],
      ),
    );
  }

  Widget slideLeftBackground() {
    return Container(
      color: Colors.red,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 20,
          ),
          UnconstrainedBox(
              child: Container(
                  height: 25,
                  width: 25,
                  child: Image.asset("assets/delete.png",
                      fit: BoxFit.contain, color: Colors.white)))
        ],
      ),
    );
  }
}
