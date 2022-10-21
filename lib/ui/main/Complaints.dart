import 'package:delivery_owner/ressources/getComplaintApi.dart';
import 'package:delivery_owner/ui/widgets/ICard27.dart';
import 'package:flutter/material.dart';
import 'package:delivery_owner/main.dart';
import '../../models/complaint.dart';
import '../../ressources/localeDB.dart';
import 'ComplaintAdd.dart';
import 'ComplaintDetails.dart';

class AllComplaintScreen extends StatefulWidget {
  final Function(String, dynamic) callback;

  AllComplaintScreen({Key key, this.callback}) : super(key: key);

  @override
  _AllComplaintScreenState createState() => _AllComplaintScreenState();
}

int _currentTabIndex = 0;

class _AllComplaintScreenState extends State<AllComplaintScreen>
    with TickerProviderStateMixin {
  ///////////////////////////////////////////////////////////////////////////////
  //
  //

  LocalDB db = LocalDB();
  var _myF;
  GetComplaint getComplaint;

  _onCallback(ComplaintModel complaint) {
//    print('User tap on complaint card with id: $id');
    account.currentOrder = complaint.id;
    account.backRoute = 'complaints';
    widget.callback('complaintDetails', complaint);
  }

  _tabIndexChanged() {
    print('Tab index is changed. New index: ${_tabController.index}');
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
    // _tabController.addListener(_tabIndexChanged);
    // _tabController.animateTo(_currentTabIndex);
    getComplaint = GetComplaint();
    _myF = getComplaint.fetchAll();
    super.initState();
  }

  @override
  void dispose() {
    //editController.dispose();
    //_tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    dprint('complaints build');
    windowWidth = MediaQuery.of(context).size.width;
    windowHeight = MediaQuery.of(context).size.height;
    _myF = getComplaint.fetchAll();
    return Scaffold(
      body: FutureBuilder(
        future: _myF,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            // return Center(
            // child: Text(
            // 'Something yes ${snapshot.hasData}wrong with message: ${snapshot.error.toString()}'),
            // );
            if (snapshot.connectionState == ConnectionState.done) {
            } else {
              print('has data ${snapshot.hasData}');
              return Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.black12,
                ),
              );
            }
          }

          if (snapshot.connectionState == ConnectionState.done) {
            List<ComplaintModel> complaintList;
            if (snapshot.data != null) {
              complaintList = snapshot.data;
              print(complaintList.length);
            }
            if (complaintList == null) {
              return Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                      height: 100,
                      width: 100,
                      child: Container(
                        child: Icon(
                          Icons.browser_not_supported_outlined,
                          size: 95,
                        ),
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  Text('Aucun Feedback', // 'Not Have Orders',
                      overflow: TextOverflow.clip,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 19,
                          fontWeight: FontWeight.bold)),
                  SizedBox(
                    height: 50,
                  ),
                ],
              ));
            } else {
              return Container(
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).padding.top + 10),
                child: Container(
                  child: _body(complaintList),
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
      ),
      bottomSheet: Container(
        width: MediaQuery.of(context).size.width,
        height: 50,
        margin: EdgeInsets.only(right: 10, left: 10),
        child: FlatButton(
            color: Colors.redAccent,
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => AddComplaintScreen(order: null)));
            },
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Icon(Icons.feedback, color: Colors.white, size: 35),
              Text(
                '  Envoyez un FeedBack',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.w800),
              ),
            ])),
      ),
    );
  }

  _body(List<ComplaintModel> listcomplaint) {
    return ListView(
      padding: EdgeInsets.only(top: 0, left: 5, right: 5),
      children: _body2(listcomplaint),
    );
  }

  _body2(List<ComplaintModel> listcomplaint) {
    var list = List<Widget>();

    for (var _data in listcomplaint) {
      list.add(cardComplaint(_data));
    }
    list.add(SizedBox(
      height: 100,
    ));
    return list;
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
}
