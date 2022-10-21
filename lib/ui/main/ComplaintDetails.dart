import 'dart:ui';
import 'package:delivery_owner/models/complaint.dart';
import 'package:delivery_owner/ressources/getComplaintApi.dart'; 
import 'package:delivery_owner/ressources/localeDB.dart';
import 'package:delivery_owner/ui/main/ComplaintMessage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DetailsComplaintScreen extends StatefulWidget {
  final complaint;
 
  DetailsComplaintScreen({this.complaint});

  @override
  _DetailsComplaintScreenState createState() => _DetailsComplaintScreenState();
}

class _DetailsComplaintScreenState extends State<DetailsComplaintScreen>
    with TickerProviderStateMixin {
  // late OrderPPCModel orderppc;
  final qtyController = TextEditingController();
  final answerController = TextEditingController();
  ///////////////////////////////////////////////////////////////////////////////
  LocalDB db = LocalDB();
  // var _myF;
  GetComplaint getComplaint;

  double windowWidth = 0.0;
  double windowHeight = 0.0;
  TabController _tabController;
  final editController = TextEditingController();
  final _formKeybookstep2 = GlobalKey<FormState>();
  bool visible = false;
  var getmessageList;

  @override
  void initState() {
    getComplaint = GetComplaint();
    getmessageList = getComplaint.fetchAllMessageByComplaint(widget.complaint);
    // _myF = getOrder.fetchAllOrderPPCItem(widget.order.id);
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
    windowWidth = MediaQuery.of(context).size.width;
    windowHeight = MediaQuery.of(context).size.height;
       getmessageList = getComplaint.fetchAllMessageByComplaint(widget.complaint);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Row(children: [
            Text(
              'FeedBack',
              style: TextStyle(
                  color: Colors.red, fontSize: 20, fontWeight: FontWeight.w600),
            )
          ]),
        ),
        body: SingleChildScrollView(
            // margin: EdgeInsets.only(top: 20),
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            cardComplaint(widget.complaint),
            messageList( )
          ],
        )),
        bottomSheet: AnswerView(complaint: widget.complaint));
  }

  Widget cardComplaint(ComplaintModel _data) {
    //  print(_data.order.id);
    var status = '';
    var colorstatus;
    //opened', 'in progress', 'closed
    if (_data.status == 'opened') {
      status = 'ouvert';
      colorstatus = Colors.teal;
    } else if (_data.status == 'in progress') {
      colorstatus = Colors.amber[800];
      status = 'en cours';
    } else if (_data.status == 'closed') {
      colorstatus = Colors.blueAccent;
      status = 'resolu';
    } else {
      colorstatus = Colors.red;
      status = 'matata';
    }
    return ListTile(
      title: Padding(
          padding: EdgeInsets.only(bottom: 9, top: 8),
          child: Card(
            elevation: 5,
            // color: Colors.red,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 8,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        '  Feedback : ',
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w700),
                      ),
                      Text('  ' + _data.qualificationBody.evaluation,
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.black,
                              fontWeight: FontWeight.w500))
                    ]),
                SizedBox(
                  height: 9,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        '  Statut : ',
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w700),
                      ),
                      Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 5),
                          padding: EdgeInsets.symmetric(horizontal: 4.0),
                          height: 20.0,
                          //width: 80,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(color: colorstatus),
                            color: colorstatus,
                          ),
                          child: Center(
                              child: Text(
                            status,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600),
                          )))
                    ]),
                SizedBox(
                  height: 5,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        width: 8,
                      ),
                      Icon(Icons.timer, size: 17, color: Colors.black54),
                      Text('  ' + _data.whenMade.substring(0, 10),
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.black,
                              fontWeight: FontWeight.w400))
                    ]),
                /* Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        '  ID:',
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w700),
                      ),
                      Text('  '  + _data.id,
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.black,
                              fontWeight: FontWeight.w400))
                    ]),*/
                SizedBox(
                  height: 10,
                )
              ],
            ),
          )),
      onTap: () {
        //  Navigator.pop(context);
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => DetailsComplaintScreen(complaint: _data)));
      },
    );
  }

  Widget messageList( ) {
    return FutureBuilder(
      future: getmessageList,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          // return Center(
          // child: Text(
          // 'Something yes ${snapshot.hasData}wrong with message: ${snapshot.error.toString()}'),
          // );
          if (snapshot.connectionState == ConnectionState.done) {
          } else {
           // print('has data ${snapshot.hasData}');
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.black12,
              ),
            );
          }
        }

        if (snapshot.connectionState == ConnectionState.done) {
          var messages;
          if (snapshot.data != null) {
            messages = snapshot.data;
            print("leng mess: "+messages.length.toString());
          }
          if (messages.length==0) {
            return Center(
                child: Padding(
                      padding: EdgeInsets.only(bottom: 13, top: 5, left: 10, right: 13),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            'Votre feedback a bien été reçu, nous vous recontacterons incessamment',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontStyle: FontStyle.italic),
                          ),
                          SizedBox(
                            height: 8,
                          )
                        ],
                      )));
          } else {
            return Container(
              margin:
                  EdgeInsets.only(top: MediaQuery.of(context).padding.top + 10),
              child: Container(
                      child: Padding(
                padding: EdgeInsets.only(bottom: 5, top: 5, left: 5, right: 5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                   Padding(
                padding: EdgeInsets.only(bottom: 5, top: 5, left: 5, right: 5),
                child: Center(child:  Text( ' Messages ' ,
                    style: TextStyle(
                      fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.w900,
                        fontStyle: FontStyle.italic)))),
                    SizedBox(
                      height: 8,
                    ),
                    for (var _message in messages)
                     messageItem(_message),
                    SizedBox(
                      height: 8,
                    )
                  ],
                )),
              ),
            );
          }
        } else {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.black12,
            ),
          );
        }
      },
    );
    
  }

  Widget messageItem(_message) {

    return Padding(
        padding: EdgeInsets.only(bottom: 7, top: 7, left: 8, right: 8),
        child: Card(
          elevation: 5,
          // color: Colors.red,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 5,
              ),
              Row( 
                children:[
                    SizedBox(
                width: 9,
              ),
                  Icon(Icons.person, size: 17, color: Colors.black),
                  
                  Text(
                    '  ' + _message['by'],
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w800),
                  ),
                ]
              ),
              SizedBox(
                height: 7,
              ),
              Text('     ' + _message['body'],
                  style: TextStyle(
                      fontSize: 12,
                      color: Colors.black,
                      fontWeight: FontWeight.w500)),
              SizedBox(
                height: 8,
              ),
              Row( children:[
                 SizedBox(
                width: 9,
              ),
                  Icon(Icons.chat, size: 17, color: Colors.blue),
                
                  Text(
                    '    ' + _message['created'].substring(0, 10),
                    style: TextStyle(
                      fontSize: 10,
                        color: Colors.black54,
                        fontWeight: FontWeight.w500,
                        fontStyle: FontStyle.italic))
              ]),
              SizedBox(
                height:8,
              )
            ],
          ),
        ));
  }
}

class AnswerView extends StatefulWidget {
  final complaint;
  AnswerView({@required this.complaint});

  @override
  _AnswerView createState() => _AnswerView(complaint: complaint);
}

class _AnswerView extends State<AnswerView> {
  final complaint;

  _AnswerView({@required this.complaint});

  final answerController = TextEditingController();
  bool visible = false, visibleloading = false;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(
          bottom: 5.0,
          right: 5.0,
          left: 5.0,
        ),
        height: 45,
        width: MediaQuery.of(context).size.width,
        // decoration: BoxDecoration(
        //   borderRadius: BorderRadius.circular(20.0),
        //   color: Colors.black12,
        // ),
        child: Row(
          children: <Widget>[
            Container(
                padding: EdgeInsets.only(left: 7.0, right: 7.0),
                width: MediaQuery.of(context).size.width * 0.8,
                height: 42,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: Colors.black12,
                ),
                child: TextFormField(
                  maxLines: 1,
                  decoration: InputDecoration(
                    labelText: 'votre message ...',
                    labelStyle: TextStyle(color: Colors.grey, fontSize: 16),
                    prefixIcon:
                        Icon(Icons.comment, color: Colors.black, size: 21),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                  keyboardType: TextInputType.text,
                  style: TextStyle(color: Colors.black),
                  textInputAction: TextInputAction.done,
                  cursorColor: Colors.black,
                  controller: answerController,
                  onTap: () {
                     if(complaint.status!="closed")
                    { 

                      Navigator.push(context,MaterialPageRoute(builder: (context) => MessageComplaintScreen(complaint: complaint)));

                    }else{
                        Fluttertoast.showToast(
                            msg: 'Le staut est fermé, vous ne pouvez pas envoyer de message',
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0);
                    }
                  },
                )),
            Container(
                margin: EdgeInsets.only(left: 8.0),
                //  padding: EdgeInsets.all(5.0),
                width: MediaQuery.of(context).size.width * 0.15,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50.0),
                  color: Colors.red,
                ),
                child: Center(
                    child: IconButton(
                  color: Colors.white,
                  icon: Icon(
                    Icons.send,
                    size: 32,
                    color: Colors.white,
                  ),
                  onPressed: () {

                    if(complaint.status!='closed')
                    { 

                      Navigator.push(context,MaterialPageRoute(builder: (context) => MessageComplaintScreen(complaint: complaint)));

                    }else{
                        Fluttertoast.showToast(
                            msg: 'Le staut est fermé, vous ne pouvez pas envoyer de message',
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0);
                    }
                  },
                ))),
          ],
        ));
  }
}
