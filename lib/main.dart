import 'package:delivery_owner/ui/login/setOtp.dart';
import 'package:delivery_owner/ui/productStock/productstock.dart';
import 'package:flutter/material.dart';
import 'package:delivery_owner/config/theme.dart';
import 'package:delivery_owner/model/account.dart';
import 'package:delivery_owner/model/pref.dart';
import 'package:delivery_owner/ui/login/createaccount.dart';
import 'package:delivery_owner/ui/login/forgot.dart';
import 'package:delivery_owner/ui/login/login.dart';
import 'package:delivery_owner/ui/main/mainscreen.dart';
import 'package:delivery_owner/ui/start/splash.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'config/lang.dart';
import 'ressources/localeDB.dart';
import 'models/user.dart';

//
// Theme
//
AppThemeData theme = AppThemeData();
//
// Language data
//
Lang strings = Lang();
//
// Account
//
Account account = Account();
Pref pref = Pref();

void main()  {

  timeago.setLocaleMessages('fr', timeago.FrMessages());



  theme.init();
  strings.setLang(Lang.french);  // set default language - English
  runApp(AppDelivery());
}

class AppDelivery  extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    var _theme = ThemeData(
      fontFamily: 'Raleway',
      primarySwatch: theme.primarySwatch,
    );

    if (theme.darkMode){
      _theme = ThemeData(
        fontFamily: 'Raleway',
        brightness: Brightness.dark,
        unselectedWidgetColor:Colors.white,
        primarySwatch: theme.primarySwatch,
      );
    }

    return MaterialApp(
      title: strings.get(10),
      debugShowCheckedModeBanner: false,
      theme: _theme,

      initialRoute: '/splash',
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate
      ],
      supportedLocales: [
        const Locale('en'),
        const Locale('fr')
      ],
      //initialRoute: '/main',
      routes: {
        '/splash': (BuildContext context) => SplashScreen(),
        '/login': (BuildContext context) => LoginScreen(),
        '/forgot': (BuildContext context) => ForgotScreen(),
        '/createaccount': (BuildContext context) => CreateAccountScreen(),
        '/main': (BuildContext context) => MainScreen(),
        '/setotp': (BuildContext context) => SetOtp(),

      },
    );
  }
}


dprint(String str){
  //
  // comment this line for release app
  //
  print(str);
}