import 'package:delivery_owner/main.dart';
import 'package:delivery_owner/ui/widgets/ICard25.dart';
import 'package:delivery_owner/ui/widgets/ICard26.dart';
import 'package:delivery_owner/ui/widgets/IList1.dart';
import 'package:flutter/material.dart';

class StatisticsScreen extends StatefulWidget {
  final Function(String) callback;
  StatisticsScreen({Key key, this.callback}) : super(key: key);

  @override
  _StatisticsScreenState createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {

  ///////////////////////////////////////////////////////////////////////////////
  //
  //

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
    return Stack(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(left: 10, right: 10, top: MediaQuery.of(context).padding.top+30),
          child: _body(),
        )
      ],
    );
  }

  _body(){
    return ListView(
      children: _body2(),
    );
  }

  _body2(){
    var list = List<Widget>();

    list.add(
        ICard26(
          color: theme.colorBackgroundDialog,
          text: "\$35383.33",
          text2: strings.get(90), // "Total Earning",
          text3: "367",
          text4: strings.get(91), // "Orders",
          textStyle: theme.text18bold,
          text2Style: theme.text16,
          enable56: false,
        )
    );

    list.add(SizedBox(height: 10,));

    list.add(Container(
      margin: EdgeInsets.only(left: 20),
      child: IList1(imageAsset: "assets/earning.png", text: strings.get(90),        // "Total Earning",
          textStyle: theme.text16bold, imageColor: theme.colorDefaultText),
    ));

    list.add(
        ICard25(
          bottomTexts: ["Lu", "Ma", "Mer", "Jeu", "Ven", "Sam", "Dim"],
          bottomTexts2: ["5", "10", "15", "20", "25"],
          bottomTextStyle: theme.text14,

          width: windowWidth,
          height: windowWidth * 0.45,

          color: theme.colorPrimary.withOpacity(0.1),
          colorTimeIcon: theme.colorGrey,

          colorAction: theme.colorPrimary,
          actionText: strings.get(81), // "week",
          actionText2: strings.get(82), // month
          action: theme.text12white,

          data: [2200, 1345, 3453, 2765, 2856, 3323, 2333],
          data2: [2200, 2345, 3453, 2765, 2856, 3323, 2333, 2200, 2345, 3453, 2765, 2856, 2323, 2333, 2200, 2345, 2453, 2765, 2856, 3323, 2333, 2200, 2345, 2453, 2765, 2856, 3323, 2333],
          colorLine: theme.colorPrimary,
          shadowColor: Colors.white,
        )
    );
    list.add(SizedBox(height: 10,));

    list.add(Container(
      margin: EdgeInsets.only(left: 20),
      child: IList1(imageAsset: "assets/statistics.png", text: strings.get(24),        // "Orders",
          textStyle: theme.text16bold, imageColor: theme.colorDefaultText),
    ));

    list.add(
        ICard25(
          bottomTexts: ["Lu", "Ma", "Mer", "Jeu", "Ven", "Sam", "Dim"],
          bottomTexts2: ["5", "10", "15", "20", "25"],
          bottomTextStyle: theme.text14,

          width: windowWidth,
          height: windowWidth * 0.45,

          color: theme.colorPrimary.withOpacity(0.1),
          colorTimeIcon: theme.colorGrey,

          colorAction: theme.colorPrimary,
          actionText: strings.get(81), // "week",
          actionText2: strings.get(82), // month
          action: theme.text12white,

          data: [4, 5, 6, 5, 5, 4, 4],
          data2: [2, 3, 5, 5, 5, 4, 3, 4, 6, 6, 6, 4, 4, 5, 2, 3, 5, 2, 8, 5, 6, 2, 3, 5, 2, 3, 5, 6],
          colorLine: theme.colorPrimary,
          shadowColor: Colors.white,
        )
    );

    list.add(
        ICard26(
          color: theme.colorBackgroundDialog,
          text: "3",
          text2: strings.get(92), // "Total Restaurants",
          text3: "45",
          text4: strings.get(93), // "Total Foods",
          textStyle: theme.text18bold,
          text2Style: theme.text16,
          enable56: false,
        )
    );

    list.add(SizedBox(height: 10,));

    list.add(Container(
      margin: EdgeInsets.only(left: 20),
      child: IList1(imageAsset: "assets/food.png", text: strings.get(94),        // Foods
          textStyle: theme.text16bold, imageColor: theme.colorDefaultText),
    ));

    list.add(
        ICard25(
          bottomTexts: ["Lu", "Ma", "Mer", "Jeu", "Ven", "Sam", "Dim"],
          bottomTexts2: ["5", "10", "15", "20", "25"],
          bottomTextStyle: theme.text14,

          width: windowWidth,
          height: windowWidth * 0.45,

          color: theme.colorPrimary.withOpacity(0.1),
          colorTimeIcon: theme.colorGrey,

          colorAction: theme.colorPrimary,
          actionText: strings.get(81), // "week",
          actionText2: strings.get(82), // month
          action: theme.text12white,

          data: [44, 45, 46, 44, 44, 45, 45],
          data2: [42, 42, 43, 43, 43, 47, 43, 44, 44, 44, 45, 45],
          colorLine: theme.colorPrimary,
          shadowColor: Colors.white,
        )
    );


    list.add(SizedBox(height: 100,));
    return list;
  }

}

