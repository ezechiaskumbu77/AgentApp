import 'package:delivery_owner/models/Shop.dart';
import 'package:delivery_owner/ui/main/AllShopManager.dart';
import 'package:delivery_owner/ui/main/addProduct.dart';
import 'package:delivery_owner/ui/main/editShop.dart';
import 'package:delivery_owner/ui/main/product.dart';
import 'package:delivery_owner/ui/main/allProduct.dart';
import 'package:delivery_owner/ui/main/driver.dart';
import 'package:delivery_owner/ui/main/map2.dart';
import 'package:delivery_owner/ui/main/AllShop.dart';
import 'package:delivery_owner/ui/main/reclamation.dart';
import 'package:delivery_owner/ui/main/statistics.dart';
import 'package:delivery_owner/ui/main/tableauDeBord.dart';
import 'package:delivery_owner/ui/order/selectShop.dart';
import 'package:flutter/material.dart';
import 'package:delivery_owner/main.dart';
import 'package:delivery_owner/model/order.dart';
import 'package:delivery_owner/ui/main/account.dart';
import 'package:delivery_owner/ui/main/header.dart';
import 'package:delivery_owner/ui/main/map.dart';
import 'package:delivery_owner/ui/main/notification.dart';
import 'package:delivery_owner/ui/main/orders.dart';
import 'package:delivery_owner/ui/menu/help.dart';
import 'package:delivery_owner/ui/menu/language.dart';
import 'package:delivery_owner/ui/main/orderdetails.dart';
import 'package:delivery_owner/ui/menu/menu.dart';
// ignore: unused_import
import '../../ressources/localeDB.dart';
import '../../models/user.dart';
import '../../service/UserData.dart';
import 'package:floating_action_bubble/floating_action_bubble.dart';
// ignore: unused_import
import '../order/startorder.dart';

import '../../models/orderPPC.dart';

var _mainMap;

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() {
    _mainMap = MapScreen();
    return _MainScreenState();
  }
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  //////////////////////////////////////////////////////////////////////////////////////////////////////
  //
  //
  //

  Animation<double> _animation;
  AnimationController _animationController;

  _openMenu() {
    print("Open menu");
    setState(() {
      _scaffoldKey.currentState.openDrawer();
    });
  }

  //
  //////////////////////////////////////////////////////////////////////////////////////////////////////
  var windowWidth;
  var windowHeight;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  var _currentPage = "restaurants";
  OrderPPCModel orderObjet;

  UserData uudata = UserData();
  UserModel uu;
  ShopModel shop;

  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 260),
    );

    final curvedAnimation =
        CurvedAnimation(curve: Curves.easeInOut, parent: _animationController);
    _animation = Tween<double>(begin: 0, end: 1).animate(curvedAnimation);

    orderObjet = OrderPPCModel();
    _initDistance();
    _mainMap.callback = routes;
    account.setRedraw(_redraw);
    uudata.getUser().then((vsync) {
      uu = vsync;
    });
    super.initState();
  }

  _initDistance() async {
    await ordersSetDistance();
    setState(() {});
  }

  _redraw() {
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    uudata.getUser().then((vsync) {
      uu = vsync;
    });

    windowWidth = MediaQuery.of(context).size.width;
    windowHeight = MediaQuery.of(context).size.height;

    var _headerText = strings.get(21); //
    switch (_currentPage) {
      case "addDishes":
        _headerText = strings.get(136); // "Add Dishes",
        break;
      case "editDishes":
        _headerText = strings.get(137); // "Edit Dishes",
        break;
      case "editRestaurant":
        _headerText = strings.get(131); // "Edit Restaurant",
        break;
      case "addRestaurant":
        _headerText = strings.get(106); // "Add new Restaurant",
        break;
      case "statistics":
        _headerText = strings.get(79); // "Statistics",
        break;
      case "orderDetails":
        _headerText = strings.get(56); // "Order Details",
        break;
      case "map":
        _headerText = strings.get(89); // "Map",
        break;
      case "mapRestaurant":
        _headerText = strings.get(89); // "Map",
        break;
      case "language":
        _headerText = strings.get(28); // "Languages",
        break;
      case "account":
        _headerText = strings.get(27); // "Account",
        break;
      case "help":
        _headerText = strings.get(38); // "Help & support",
        break;
      case "notification":
        _headerText = strings.get(25); // "Notifications",
        break;
      case "orders":
        _headerText = "Commandes de sa zone"; // "Orders",
        break;
      case "reclamation":
        _headerText = "Réclamation"; // "Orders",
        break;
      case "drivers":
        _headerText = strings.get(101); // "Change Driver",
        break;
      case "restaurants":
        _headerText = "Les dépôts de sa zone"; // "My Restaurants",
        break;
      case "dishes":
        _headerText = strings.get(134); // "My Dishes",
        break;
      case "board":
        _headerText = "Tableau de Bord"; // "My Dishes",
        break;
      case "board":
        _headerText = "Tableau de Bord"; // "My Dishes",
        break;
      case "manager":
        _headerText = "Shop Manager"; // "My Dishes",
        break;
      
      default:
        break;
    }

    return Scaffold(
      key: _scaffoldKey,
      drawer: Menu(context: context, callback: routes, userL: uu),
      backgroundColor: theme.colorBackground,
      // floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: _floatBtn(context),
      body: Stack(
        children: <Widget>[
          if (_currentPage.isEmpty) 
            OrdersScreen(callback: routes),
          if (_currentPage == "dishesAll")
            DishesAllScreen(callback: routes2, params: _params),
          if (_currentPage == "addDishes" || _currentPage == "editDishes")
            AddDishesScreen(callback: routes2, params: _params),
          if (_currentPage == "dishes")
            ProductScreen(callback: routes2, params: _params),
          if (_currentPage == "addRestaurant" ||
              _currentPage == "editRestaurant")
            EditShopScreen(callback: routes, shopEdit: shop),
          if (_currentPage == "mapRestaurant")
            MapInfoScreen(callback: routes2, params: _params),
          if (_currentPage == "restaurants")
            AllShopScreen(
              callback: routes2,
              userL: uu,
              ctx: context,
            ),
          if (_currentPage == "manager")
            AllShopManager(
              callback: routes2,
              userL: uu,
              ctx: context,
            ),
          if (_currentPage == "drivers") 
          DriverChangeScreen(callback: routes),
          if (_currentPage == "board") 
          TableauDeBord(callback: routes),
          if (_currentPage == "statistics")
           StatisticsScreen(callback: routes),
          if (_currentPage == "reclamation")
           Reclamation(callback: routes),
          if (_currentPage == "orderDetails")
            OrderDetailsScreen(callback: routes, order: orderObjet),
          if (_currentPage == "map") _mainMap,
          if (_currentPage == "language") 
          LanguageScreen(),
          if (_currentPage == "account")
            AccountScreen(callback: routes, userL: uu),
          if (_currentPage == "help")
           HelpScreen(),
          if (_currentPage == "notification")
            NotificationScreen(callback: routes),
          if (_currentPage == "orders")
           OrdersScreen(callback: routes),
          Container(
              margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
              child: Header(
                title: _headerText,
                onMenuClick: _openMenu,
                callback: routes,
                userL: uu,
              )),
        ],
      ),
    );
  }

  Map<String, dynamic> _params = {};

  routes2(String route, Map<String, dynamic> params) {
    _params = params;
    if (route != "redraw") _currentPage = route;
    setState(() {});
  }

  showDialogInformation(
      BuildContext context, String informationmessage) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title:   Column(children: <Widget>[
            Row(
              children: <Widget>[
                Icon(Icons.info, color:  Colors.red, size: 30),
                Text('Contact',
                    style: TextStyle(
                        fontSize: 27,
                        fontWeight: FontWeight.w800,
                        color: Colors.black))
              ],
            ),
            Text(
              informationmessage,
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
              overflow: TextOverflow.visible,
            )
          ]),
          actions: <Widget>[
            FlatButton(
              shape:   RoundedRectangleBorder(
                borderRadius:   BorderRadius.circular(40.0),
              ),
              textColor: Colors.white,
              color: Colors.black,
              child:   Text(
                'D\'accord',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            
          ],
        );
      },
    );
  }

  _floatBtn(BuildContext context) {
    return FloatingActionBubble(
        // Menu items
        items: <Bubble>[
          // Floating action menu item
          Bubble(
            title: "Commander",
            iconColor: Colors.white,
            bubbleColor: Colors.green,
            icon: Icons.add_shopping_cart,
            titleStyle: TextStyle(
                fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
            onPress: () {
              _animationController.reverse();

              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => SelectShop()));
            },
          ),
          // Floating action menu item
          /*Bubble(
          title:"Créer un dépot ",
          iconColor :Colors.white,
          bubbleColor : Colors.blueAccent,
          icon:Icons.home_work_outlined,
          titleStyle:TextStyle(fontSize: 16 , color: Colors.white,fontWeight: FontWeight.bold),
          onPress: () {
            _animationController.reverse();
          },
        ),*/
          //Floating action menu item
          Bubble(
            title: "Contactez-Nous",
            iconColor: Colors.white,
            bubbleColor: Colors.deepPurple,
            icon: Icons.phone,
            titleStyle: TextStyle(
                fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
            onPress: () {
              
              _animationController.reverse();
              showDialogInformation( context, 'Pour tout problème, veuillez contacter le service client au +243 821 770 225');
                // Navigator.of(context)
                //   .push(MaterialPageRoute(builder: (context) => Conta()));
            },
          ),
        ],

        // animation controller
        animation: _animation,

        // On pressed change animation state
        onPress: () => _animationController.isCompleted
            ? _animationController.reverse()
            : _animationController.forward(),

        // Floating Action button Icon color
        iconColor: Colors.white,
        animatedIconData: AnimatedIcons.add_event,
        backGroundColor: Colors.green

        // Flaoting Action button Icon
        //icon: AnimatedIcons.add_event,

        );
  }

  routes(String route, [var ob]) {
    if (!(ob == null)) {
      print("here");
      if (ob is OrderPPCModel) {
        orderObjet = ob;
      } else if (ob is ShopModel) {
        shop = ob;
      } else {
        print("it's not success ${ob}");
      }

      print("after ${orderObjet.customer}  $route");
    }

    _params = {};
    if (route != "redraw") {
      // print("here 1");
      _currentPage = route;
    }
    //  print("here 2 $_currentPage");

    setState(() {});
  }
}
