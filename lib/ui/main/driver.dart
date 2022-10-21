import 'package:delivery_owner/model/driver.dart';
import 'package:delivery_owner/model/order.dart';
import 'package:delivery_owner/ui/widgets/ICard28FileCaching.dart';
import 'package:delivery_owner/ui/widgets/ibackbutton.dart';
import 'package:flutter/material.dart';
import 'package:delivery_owner/main.dart';

class DriverChangeScreen extends StatefulWidget {
  final Function(String) callback;
  DriverChangeScreen({Key key, this.callback}) : super(key: key);

  @override
  _DriverChangeScreenState createState() => _DriverChangeScreenState();
}

class _DriverChangeScreenState extends State<DriverChangeScreen> {

  ///////////////////////////////////////////////////////////////////////////////
  //
  //

  _driverSelect(String id){
    print("Selected driver with id: $id");
    for (var _data in orders)
      if (account.currentOrder == _data.id)
        _data.driverId = id;

    widget.callback("orderDetails");
  }

  _onBackPressed(){
    widget.callback("orderDetails");
  }

  //
  ///////////////////////////////////////////////////////////////////////////////
  double windowWidth = 0.0;
  double windowHeight = 0.0;


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
    windowWidth = MediaQuery.of(context).size.width;
    windowHeight = MediaQuery.of(context).size.height;
    return WillPopScope(
        onWillPop: () async {
        _onBackPressed();
      return false;
    },
    child: Stack(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top+50),
          child: _body(),
        ),

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
      children: _body2(),
    );
  }

  _body2(){
    var list = List<Widget>();

    list.add(SizedBox(height: 20,));

    for (var _data in drivers) {
      list.add(ICard28FileCaching(
        id: _data.id,
        color: theme.colorGrey2,
        title: _data.name,
        titleStyle: theme.text14bold,
        userAvatar: _data.image,
        text: _data.phone,
        textStyle: theme.text14,
        balloonColor: (_data.online) ? Colors.green : Colors.red,
        balloonText: (_data.online) ? strings.get(102) : strings.get(103), // "online", - offline
        balloonStyle: theme.text14boldWhite,
        enable: _data.online,
        callback: _driverSelect
      ));
    }
    return list;
  }
}

