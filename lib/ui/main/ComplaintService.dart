import 'dart:ui';

//import 'package:delivery_owner/models/delivery.dart';
// import 'package:delivery_owner/models/orderItemPPC.dart';
import 'package:delivery_owner/models/complaint.dart';
import 'package:delivery_owner/models/complaintService.dart';
import 'package:delivery_owner/models/orderPPC.dart';
import 'package:delivery_owner/ressources/getComplaintApi.dart';
// import 'package:delivery_owner/ressources/getGeoloc.dart';
import 'package:delivery_owner/ressources/localeDB.dart';
import 'package:delivery_owner/ui/main/Complaints.dart';
import 'package:delivery_owner/ui/widgets/ibutton2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:delivery_owner/main.dart';
// import 'package:delivery_owner/model/order.dart';
import 'package:delivery_owner/ui/widgets/ICard22.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../main.dart';
import 'mainscreen.dart';

class AddComplaintService extends StatefulWidget {
  final order;
  //AddComplaintService({  this.delivery});
  // Function(String, Map<String, dynamic>) callback;
  // final Map<String, dynamic> params;
  AddComplaintService({this.order});
  @override
  _AddComplaintServiceState createState() => _AddComplaintServiceState();
}

class ItemComplaint {
  const ItemComplaint(this.name, this.id);
  final String name;
  final int id;
}

ItemComplaint selectedComplaint;
List<ItemComplaint> complaints = <ItemComplaint>[
  const ItemComplaint('Selectionnez', 0),
  const ItemComplaint('Votre service est excellent', 1),
  const ItemComplaint('Votre service est bon', 2),
  const ItemComplaint('Votre service est mauvais', 3),
];

class _AddComplaintServiceState extends State<AddComplaintService>
    with TickerProviderStateMixin {
  TabController _tabController;
  final editController = TextEditingController();
  final _formKeybookstep2 = GlobalKey<FormState>();
  bool visible = false;
  GetComplaint getComplaint = GetComplaint();
  ComplaintModel cmpl = ComplaintModel();
  ComplaintService cmplService;
  _sendFeedback() async {
    //  cmplProduct.qty = double.parse(qtyController.text);

    cmpl.qualificationBody = cmplService;
    cmpl.qualificationId = 2;
     
    if (widget.order != null || widget.order != '') { 
       cmpl.orderId = widget.order;
    }
    
    setState(() {
      visible = true;
    });
    setState(() {
      visible = true;
    });
    print('begin execute $cmpl');

    var resp = await getComplaint.postComplaint(cmpl);
    setState(() {
      visible = false;
    });

    if (resp) {
      setState(() {
        visible = false;
      });

      await Fluttertoast.showToast(
          msg: 'Envoyé',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
          
          Navigator.of(context).pop();
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
        onPressed: () async {
      
          if (selectedComplaint != null) {
            _sendFeedback();
          } else {
            await Fluttertoast.showToast(
                msg: 'Vous n\avez rien selectionné',
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                backgroundColor: Colors.black,
                textColor: Colors.white,
                fontSize: 16.0);
          }
        },
        color: Colors.red,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: Text(
          'ENVOYER',
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
            Padding(
                padding: EdgeInsets.only(
                    left: _fixedPadding,
                    right: _fixedPadding,
                    bottom: _fixedPadding),
                child: complaintWidget()),
            SizedBox(
              height: 10,
            ),
            Visibility(
                visible: visible,
                child: Center(
                    child: Column(children: <Widget>[
                  CircularProgressIndicator(
                    backgroundColor: Colors.red,
                    strokeWidth: 2,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Envoie en cours ...',
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontStyle: FontStyle.italic),
                    textAlign: TextAlign.center,
                  )
                ]))),
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
              'FeedBack - Service         ',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.w600),
            )),
        forminput
      ],
    )));
  }

  Widget complaintWidget() {
    return Container(
          margin: EdgeInsets.only(
          top: 3,
          left: 0,
          right: 0,
        ),
         
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
                          switch (value.id) {
                            case 1:
                              cmplService =
                                  ComplaintService(EvaluationService.excellent);
                              break;
                            case 2:
                              cmplService =
                                  ComplaintService(EvaluationService.bon);
                              break;
                            case 3:
                              cmplService =
                                  ComplaintService(EvaluationService.mauvais);
                              break;
                            default:
                          }
                          
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
