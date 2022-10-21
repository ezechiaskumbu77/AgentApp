import 'dart:ui';

//import 'package:delivery_owner/models/delivery.dart';
// import 'package:delivery_owner/models/orderItemPPC.dart';
// import 'package:delivery_owner/models/complaint.dart';
// import 'package:delivery_owner/models/orderPPC.dart';
// import 'package:delivery_owner/ressources/getGeoloc.dart';
// import 'package:delivery_owner/ressources/localeDB.dart';
import 'package:delivery_owner/ui/main/ComplaintLogistic.dart';
import 'package:delivery_owner/ui/main/ComplaintPrice.dart';
// import 'package:delivery_owner/ui/widgets/ibutton2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:delivery_owner/main.dart';
// import 'package:delivery_owner/model/order.dart';
// import 'package:delivery_owner/ui/widgets/ICard22.dart';
import 'package:fluttertoast/fluttertoast.dart';

// import '../../main.dart';
import 'package:delivery_owner/ui/main/ComplaintProduct.dart';
import 'package:delivery_owner/ui/main/ComplaintService.dart';
// import 'mainscreen.dart';

class AddComplaintScreen extends StatefulWidget {
  final order;
 
  AddComplaintScreen({this.order});

  @override
  _AddComplaintScreenState createState() => _AddComplaintScreenState();
}

class ItemComplaint {
  const ItemComplaint(this.name, this.id);
  final String name;
  final int id;
}

ItemComplaint selectedComplaint;
List<ItemComplaint> complaints = <ItemComplaint>[
  const ItemComplaint('Votre FeedBack', 0),
  const ItemComplaint('Plainte liée à la logistique', 1),
  const ItemComplaint('Plainte liée à la qualité du Service', 2),
  const ItemComplaint('Plainte liée au prix des produits', 3),
  const ItemComplaint('Plainte liée la qualité des produits', 4),
];

class _AddComplaintScreenState extends State<AddComplaintScreen>
    with TickerProviderStateMixin {
  // late OrderPPCModel orderppc;
  final qtyController = TextEditingController();
  final commentController = TextEditingController();
  ///////////////////////////////////////////////////////////////////////////////

  double windowWidth = 0.0;
  double windowHeight = 0.0;
  TabController _tabController;
  final editController = TextEditingController();
  final _formKeybookstep2 = GlobalKey<FormState>();
  bool visible = false;

  _issued(_data) async {
    setState(() {
      visible = true;
    });
    print('begin execute $_data.order.id');
    var resp = false; // await getComplaint.postcomplaint(_data);
    setState(() {
      visible = false;
    });

    if (resp) {
      setState(() {
        visible = false;
      });

      await Fluttertoast.showToast(
          msg: 'Le problème a bien été signalé',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);

      // return;
    } else {
      await Fluttertoast.showToast(
          msg: 'Une erreur s\'est produite',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);

      setState(() {
        visible = false;
      });
    }
    //return;
  }

  @override
  void initState() {
    // _myF = getComplaint.fetchAllOrderPPCItem(widget.order.id);
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
    final _height = MediaQuery.of(context).size.height;
    final _fixedPadding = _height * 0.025;

    final validateBtn = Container(
      margin: EdgeInsets.only(top: 15.0, left: 25, right: 25),
      height: 50.0,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.0), color: Colors.white),
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () {
          
          var orderID = '';

          if (widget.order != null || widget.order != '') {
            orderID = widget.order;
          }
          // Navigator.pop(context);

          switch (selectedComplaint.id) {
            case 1:
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => AddComplaintLogistic(
                        order: orderID,
                      )));
              break;
            case 2:
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>
                      AddComplaintService(order: orderID)));
              break;

            case 3:
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>
                      AddComplaintPrice(order: orderID)));
              break;
            case 4:
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>
                      AddComplaintProduct(order: orderID)));
              break;
          }
        },
        color: Colors.red,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: Text(
          'SUIVANT',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 17.0,
            color: Colors.white,
          ),
        ),
      ),
    );

    final forminput = Padding(
      padding: EdgeInsets.only(top: 10.0),
      child: Form(
        key: _formKeybookstep2,
        child: Column(
          children: <Widget>[
            //  PhoneNumber TextFormFields
            Padding(
                padding: EdgeInsets.only(
                    left: _fixedPadding,
                    right: _fixedPadding,
                    bottom: _fixedPadding),
                child: complaintWidget()),

            // inputtclientField,

            validateBtn,
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );

    return Scaffold(
        body: Container(
            // margin: EdgeInsets.only(top: 20),
            child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
            padding: EdgeInsets.only(left: 10),
            child: Text(
              'Votre FeedBack ...',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 29,
                  fontWeight: FontWeight.w800),
            )),
        forminput
      ],
    )));
  }

  Widget complaintWidget() {
    return Container(
        // width: MediaQuery.of(context).size.width * 0.3,
        margin: EdgeInsets.only(
          top: 3,
          left: 0,
          right: 0,
        ),
        // padding: EdgeInsets.only(),
        child: Center(
            child: Card(
                shape: new RoundedRectangleBorder(
                    side: BorderSide(color: Colors.black54),
                    borderRadius: new BorderRadius.circular(40.0)),
                shadowColor: Colors.black,
                borderOnForeground: true,
                child: Align(
                    alignment: Alignment.topRight,
                    child: DropdownButton<ItemComplaint>(
                      iconSize: 24,
                      elevation: 8,
                      isExpanded: true,
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 14,
                        height: 1.5,
                      ),
                      underline: Container(
                        height: 1,
                        color: Colors.white,
                      ),
                      hint: Row(
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          Icon(Icons.trip_origin,
                              color: Colors.black, size: 25),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Selectionnez',
                            style: TextStyle(color: Colors.black, fontSize: 13),
                          ),
                        ],
                      ),
                      value: selectedComplaint,
                      onChanged: (ItemComplaint value) {
                        setState(() {
                          selectedComplaint = value;
                          // macomplaint = value.name;
                        });
                      },
                      items: complaints.map((ItemComplaint complaint) {
                        return DropdownMenuItem<ItemComplaint>(
                          value: complaint,
                          child: Row(
                            children: <Widget>[
                              SizedBox(
                                width: 10,
                              ),
                              Icon(Icons.trip_origin,
                                  color: Colors.black, size: 25),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                complaint.name,
                                style: TextStyle(
                                    color: Colors.black, fontSize: 13),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    )))));
  }
}
