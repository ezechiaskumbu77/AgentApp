import 'package:cached_network_image/cached_network_image.dart';
import 'package:delivery_owner/ui/main/customerservice.dart';
import 'package:flutter/material.dart';
import 'package:delivery_owner/main.dart';
import 'package:delivery_owner/ui/widgets/ibackground4.dart';
import 'package:delivery_owner/ui/widgets/iline.dart';
// ignore: unused_import
import 'package:delivery_owner/ui/widgets/ilist5.dart';

// ignore: unused_import
import '../../service/UserData.dart';
import '../../models/user.dart';

class Menu extends StatelessWidget {


    UserModel userL;
  @required final BuildContext context;
  final Function(String) callback;
  Menu({this.context, this.callback ,this.userL});
 
  _onMenuClickItem(int id){
    print("User click menu item: $id");
    switch(id){
      case 1:
        callback("orders");
        break;
      case 17:
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => CustomerServicePage())); 
      break;
      case 12:
        callback("manager");
        break;
      case 20:
        callback("board");
        break;
      case 15:   // my restaurants
        callback("restaurants");
        break;
      case 16:   // My Dishes
        callback("dishesAll");
        break;
      case 2:
        callback("notification");
        break;
      case 3:
        callback("statistics");
        break;
      case 7:
        callback("help");
        break;
      case 8:
        callback("account");
        break;
      case 9:
        callback("language");
        break;
      case 10:   // dark & light mode
        theme.changeDarkMode();
        callback("redraw");
        break;
      case 11:   // sign out
        account.logOut();
        Navigator.pushNamedAndRemoveUntil(context, "/login", (r) => false);
        break;

    }
  }

  _changeNotify(bool value){
    print("Notification button change value: $value");
  }
  //
  //
  //
  //////////////////////////////////////////////////////////////////

  @override
  Widget build(BuildContext context) {
    affi(userL);
    return Drawer(
        child: Container(
          color: theme.colorBackground,
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              if (!account.isAuth())
              Container(
                height: 100+MediaQuery
                    .of(context)
                    .padding
                    .top,
                child: IBackground4(colorsGradient: theme.colorsGradient),
              ),
              if (account.isAuth())
              SizedBox(height: MediaQuery
                  .of(context)
                  .padding
                  .top,),
              if (account.isAuth())
              Container(
                  height: 100,
                  child: Row(
                    children: <Widget>[
                      UnconstrainedBox(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: new BorderRadius.circular(50),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                spreadRadius: 2,
                                blurRadius: 2,
                                offset: Offset(1, 1), // changes position of shadow
                              ),
                            ],
                          ),
                          child: _avatar("https://secure-sea-91184.herokuapp.com/uploads/${userL.photo_url== null ? "photo_user.png": userL.photo_url}"),
                          margin: EdgeInsets.only(left: 10, top: 10, bottom: 10, right: 10),
                        )
                      ),
                      SizedBox(width: 20,),

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(userL==null ?  "" : userL.name ,  style: theme.text18boldPrimary,),
                            Text(userL==null ? "": userL.phone == null ? " ": userL.phone, style: theme.text16,),
                          ],
                        ),
                      )
                    ],

                  )
              ),
              if (account.isAuth())
                ILine(),
              _item(15, "Les depots de sa zone", "assets/categories.png"), 
              _item(1, "Commandes de sa zone", "assets/shop.png"), 
              _item(2, strings.get(25), "assets/notifyicon.png"),  // Notifications 
              ILine(),
             _item(17, "Contactez-nous", 'assets/help.png'), // Help & Support
              _item(8, strings.get(27), 'assets/account.png'), // "Account",
        
              // IList5(icon:  UnconstrainedBox(
              //     child: Container(
              //         height: 25,
              //         width: 25,
              //         child: Image.asset("assets/notifyicon.png",
              //             fit: BoxFit.contain, color: theme.colorPrimary,
              //         )
              //     )),
              //   text : strings.get(25),                                   // Notifications
              //   textStyle: theme.text16bold,
              //   activeColor: theme.colorPrimary,
              //   inactiveTrackColor: theme.colorGrey,
              //   press: _changeNotify,
              // ),

              // ILine(),
              // _darkMode(),
              if (account.isAuth())
                ILine(),
              if (account.isAuth())
                _item(11, strings.get(29), "assets/signout.png"), // "Sign Out",

            ],
          ),
        )
    );
  }

  _avatar(String url){
    if (!account.isAuth())
      return Container();
    else
      return Container(
        width: 55,
        height: 55,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(55),
          child: Container(
            child: CachedNetworkImage(
              placeholder: (context, url) =>
                  CircularProgressIndicator(backgroundColor: theme.colorPrimary,),
              imageUrl: url,
              imageBuilder: (context, imageProvider) => Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              errorWidget: (context,url,error) => new Icon(Icons.error),
            ),
          ),
        ),
      );
  }

  _darkMode(){
    if (theme.darkMode)
      return _item(10, "Light colors", "assets/brands.png");
    return _item(10, "Dark colors", "assets/brands.png");
  }

  _item(int id, String name, String imageAsset){
    return Stack(
      children: <Widget>[
        ListTile(
          title: Text(name, style: theme.text16bold,),
          leading:  UnconstrainedBox(
              child: Container(
                  height: 25,
                  width: 25,
                  child: Image.asset(imageAsset,
                      fit: BoxFit.contain,
                      color: theme.colorPrimary,
                  )

              )),
        ),
        Positioned.fill(
          child: Material(
              color: Colors.transparent,
              child: InkWell(
                splashColor: Colors.grey[400],
                onTap: () {
                  Navigator.pop(context);
                  _onMenuClickItem(id);
                }, // needed
              )),
        )
      ],
    );
  }

}

void affi(UserModel uu) {
if (!(uu==null)){
  print("seeeeeeee ${uu.name}");
}

}