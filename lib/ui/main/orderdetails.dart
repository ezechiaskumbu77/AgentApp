import 'package:delivery_owner/model/driver.dart';
import 'package:delivery_owner/ui/widgets/ICard22.dart';
import 'package:delivery_owner/ui/widgets/ibackbutton.dart';
import 'package:delivery_owner/ui/widgets/iline.dart';
import 'package:flutter/material.dart';
import 'package:delivery_owner/main.dart';
import 'package:delivery_owner/model/order.dart';
import 'package:delivery_owner/ui/widgets/ICard23.dart';
import 'package:delivery_owner/ui/widgets/ICard24.dart';
import 'package:delivery_owner/ui/widgets/ibutton2.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../models/orderPPC.dart';
import '../../models/orderItemPPC.dart';
import '../../ressources/getOrdersItemApi.dart';

class OrderDetailsScreen extends StatefulWidget {
  final Function(String) callback;
  OrderPPCModel order;
  OrderDetailsScreen({Key key, this.callback, this.order}) : super(key: key);

  @override
  _OrderDetailsScreenState createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  ///////////////////////////////////////////////////////////////////////////////
  //
  //

  GetOrderItem getOrderItem;

  _onMapClick(String id) {
    print("User click On Map button with id: $id");
    account.openOrderOnMap = id;
    account.backRouteMap = "orderDetails";
    widget.callback("map");
  }

  _setDriver() {
    widget.callback("drivers");
  }

  //
  ///////////////////////////////////////////////////////////////////////////////
  double windowWidth = 0.0;
  double windowHeight = 0.0;

  @override
  void initState() {
    getOrderItem = GetOrderItem();

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
//    print("the data are here ${widget.order.toString()}");
    windowWidth = MediaQuery.of(context).size.width;
    windowHeight = MediaQuery.of(context).size.height;
    return Stack(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(
              left: 10,
              right: 10,
              top: MediaQuery.of(context).padding.top + 50),
          child: _body(),
        ),
        Container(
          margin: EdgeInsets.only(left: 5, top: 40),
          alignment: Alignment.topLeft,
          child: IBackButton(
              onBackClick: () {
                widget.callback(account.backRoute);
              },
              color: theme.colorPrimary,
              iconColor: Colors.white),
        ),
      ],
    );
  }

  _body() {
    return ListView(
      shrinkWrap: true,
      children: _body2(),
    );
  }

  _body2() {
    var list = List<Widget>();
    //  print("see your data ${widget.order.toJson()}");
    list.add(ICard22(
        color: theme.colorBackgroundDialog,
        colorRoute: theme.colorPrimary,
        id: widget.order.id,
        text:
            "${strings.get(44)} #${widget.order.id.substring(1, 5)}", // Order ID122
        textStyle: theme.text14boldPimary,
        text2:
            "${strings.get(45)}: ${widget.order.WhenMade}", // Date: 2020-07-08 12:35
        text2Style: theme.text14,
        text3: " ${widget.order.totalPrice} FC",
        text3Style: theme.text14bold,
        text4: widget.order.paymentMethode, // cache on delivery
        text4Style: theme.text14,
        text5: "${strings.get(46)}:", // Distance
        text5Style: theme.text16,
        text6: " 45 ${strings.get(49)}", // km
        text6Style: theme.text18boldPrimary,
        text7: widget.order.shippingAdress == null
            ? " "
            : widget.order.shippingAdress,
        text7Style: theme.text14,
        text8: "PPC",
        text8Style: theme.text14,
        button1Enable: false,
        button2Enable: false,
       // button1Text: strings.get(47), // On Map
        //button1Style: theme.text14boldWhite,
        //button2Text: (status == 0) ? strings.get(48) : strings.get(51),
        // Accept or Complete
        button2Style: theme.text14boldWhite,
//              callbackButton1: _onAcceptClick,
        //callbackButton2: _onMapClick
        ));

    list.add(SizedBox(
      height: 10,
    ));

    list.add(_status(
        widget.order.status == null ? " " : widget.order.status, false));
    list.add(_status(
        widget.order.deliverCode == null ? " " : widget.order.deliverCode,
        true));
    list.add(SizedBox(
      height: 10,
    ));

    list.add(ILine());
    // list.add(
    //     ICard23(
    //       text: "Fournisseur:", // Customer name
    //       textStyle: theme.text14,
    //       text2: "Numéro du fournisseur :", // "Customer phone",
    //       text2Style: theme.text14,
    //       text3: "PPC ",
    //       text3Style: theme.text16bold,
    //       text4: "+243 811960037",
    //       text4Style: theme.text16bold,
    //     ));

    list.add(SizedBox(
      height: 10,
    ));
    list.add(Container(
      alignment: Alignment.center,
      child: IButton2(
          color: theme.colorPrimary,
          text: strings.get(54), // "Call to Customer",
          textStyle: theme.text14boldWhite,
          pressButton: _onCallToCustomer),
    ));
    list.add(SizedBox(
      height: 10,
    ));

    list.add(oDetail());

    list.add(SizedBox(
      height: 15,
    ));

    list.add(SizedBox(
      height: 15,
    ));

    _backButton(list);

    list.add(SizedBox(
      height: 100,
    ));

    for (var _data in orders) {
      if (account.currentOrder == _data.id) {
        list.add(ICard22(
            color: theme.colorBackgroundDialog,
            colorRoute: theme.colorPrimary,
            id: _data.id,
            text: "${strings.get(44)} #${_data.id}", // Order ID122
            textStyle: theme.text14boldPimary,
            text2:
                "${strings.get(45)}: ${_data.date}", // Date: 2020-07-08 12:35
            text2Style: theme.text14,
            text3: "${_data.currency}${_data.summa.toStringAsFixed(2)}",
            text3Style: theme.text14bold,
            text4: _data.method, // cache on delivery
            text4Style: theme.text14,
            text5: "${strings.get(46)}:", // Distance
            text5Style: theme.text16,
            text6:
                "${(_data.distance / 1000).toStringAsFixed(3)} ${strings.get(49)}", // km
            text6Style: theme.text18boldPrimary,
            text7: _data.address1,
            text7Style: theme.text14,
            text8: _data.address2,
            text8Style: theme.text14,
            button1Enable: false,
            button2Enable: false,
            //button1Text: '',// strings.get(47), // On Map
            //button1Style: theme.text14boldWhite,
            //button2Text: (status == 0) ? strings.get(48) : strings.get(51),
            // Accept or Complete
            //button2Style: theme.text14boldWhite,
//              callbackButton1: _onAcceptClick,
            //callbackButton2: null// _onMapClick
            ));

        list.add(SizedBox(
          height: 10,
        ));

        //   list.add(_status());

        list.add(SizedBox(
          height: 10,
        ));

        list.add(ILine());

        list.add(ICard23(
          text: "${strings.get(52)}:", // Customer name
          textStyle: theme.text14,
          text2: "${strings.get(53)}:", // "Customer phone",
          text2Style: theme.text14,
          text3: "${_data.customerName}",
          text3Style: theme.text16bold,
          text4: _data.phone,
          text4Style: theme.text16bold,
        ));

        list.add(SizedBox(
          height: 10,
        ));

        list.add(Container(
          alignment: Alignment.center,
          child: IButton2(
              color: theme.colorPrimary,
              text: strings.get(54), // "Call to Customer",
              textStyle: theme.text14boldWhite,
              pressButton: _onCallToCustomer),
        ));

        list.add(SizedBox(
          height: 10,
        ));

        var _dataDetails = List<ICard24Data>();
        for (var _details in _data.orderDetails)
          _dataDetails.add(ICard24Data(_data.currency, _details.image,
              _details.productName, _details.count, _details.productPrice));

        list.add(ICard24(
          color: theme.colorBackgroundDialog,
          text: "${strings.get(56)}:", // Order Details
          textStyle: theme.text18boldPrimary,
          text2Style: theme.text16,
          colorProgressBar: theme.colorPrimary,
          data: _dataDetails,
          text3Style: theme.text16,
          text3: "${strings.get(57)}:", // Subtotal
          text4:
              "${strings.get(58)}: ${_data.currency}${_data.fee}", // Shopping costs
          text5: "${strings.get(59)}: ${_data.currency}${_data.tax}", // Taxes
          text6: "${strings.get(60)}: ${_data.currency}${_data.total}", // Total
          text6Style: theme.text16bold,
        ));

        list.add(SizedBox(
          height: 15,
        ));

        list.add(SizedBox(
          height: 15,
        ));

        _backButton(list);

        list.add(SizedBox(
          height: 100,
        ));
      }
    }
    return list;
  }

  _backButton(List<Widget> list) {
    var _text = strings.get(61); // "Back To Map",
    if (account.backRoute == "orders")
      _text = strings.get(55); // "Back To Orders",

    list.add(Container(
      alignment: Alignment.center,
      child: IButton2(
          color: theme.colorPrimary,
          text: _text,
          textStyle: theme.text14boldWhite,
          pressButton: () {
            widget.callback(account.backRoute);
          }),
    ));
  }

  _status(String stat, bool code) {
    var _return = Container();

    _return = Container(
        margin: EdgeInsets.only(left: 10, right: 10),
        child: Row(
          children: [
            Text(
              code ? "Code de livraison : " : "${strings.get(98)}:",
              style: theme.text18boldPrimary,
            ), // "Status",
            SizedBox(
              width: 10,
            ),
            Expanded(
                child: Text(
              stat,
              style: theme.text16,
            )),
          ],
        ));

    return _return;
  }

  _onCallToCustomer() async {
    var uri = 'tel:+243811960037';
    if (await canLaunch(uri)) await launch(uri);
  }

  Widget oDetail() {
    return FutureBuilder(
        future: getOrderItem.fetchAll(widget.order.id),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            print(' ');
            // return Center(
            // child: Text(
            // "Something yes ${snapshot.hasData}wrong with message: ${snapshot.error.toString()}"),
            // );
            print(snapshot.hasData);
            if (snapshot.connectionState == ConnectionState.done) {
              return Text(" not data ");
              print(' fe');
            } else {
              print("has data ${snapshot.hasData}");
              return Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.black12,
                ),
              );
            }
          } else if (snapshot.connectionState == ConnectionState.done) {
            var orderAllItem = snapshot.data;

            var _dataDetails = List<ICard24Data>();
            for (var _details in orderAllItem)
              _dataDetails.add(ICard24Data(
                      "FC",
                      "https://www.moncongo.com/sites/default/files/images/business/photos/DRC%20SURECAST%20FRENCH_2016-09-20_1.jpg",
                      _details.product.name,
                      _details.quantity,
                      _details
                          .price) //  ICard24Data(_data.currency, _details.image, _details.foodName, _details.count, _details.foodPrice)
                  );

            return ICard24(
              color: theme.colorBackgroundDialog,
              text: "${strings.get(56)}:", // Order Details
              textStyle: theme.text18boldPrimary,
              text2Style: theme.text16,
              colorProgressBar: theme.colorPrimary,
              data: _dataDetails,
              text3Style: theme.text16,
              text3: "${strings.get(57)}:", // Subtotal
              text4:
                  "${strings.get(58)}: ${(widget.order.totalPrice).toDouble() * 0.1} Fc", // Shopping costs
              text5:
                  "${strings.get(59)}: ${(widget.order.totalPrice).toDouble() * 0.15} Fc", // Taxes
              text6:
                  "${strings.get(60)} : ${(widget.order.totalPrice).toDouble() * (1)}", // Total
              text6Style: theme.text16bold,
            );
          } else {
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.black12,
              ),
            );
          }
        });
  }
}
