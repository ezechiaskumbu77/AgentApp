import 'dart:async';

import 'package:delivery_owner/mixins/validation_mixin.dart';
import 'package:delivery_owner/ui/order/startorder.dart';
import 'package:delivery_owner/ui/widgets/ICard27.dart';
import 'package:flutter/material.dart';
import 'package:delivery_owner/main.dart';
import 'package:delivery_owner/model/order.dart';
import '../../models/orderPPC.dart';
import '../../ressources/getOrdersApi.dart';
import '../../ressources/localeDB.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';

class Reclamation extends StatefulWidget {
  final Function(String) callback;

  Reclamation({Key key, this.callback}) : super(key: key);

  @override
  _ReclamationState createState() => _ReclamationState();
}



class _ReclamationState extends State<Reclamation>  with ValidationMixin{

  final formkey = GlobalKey<FormState>();
  double windowWidth = 0.0;
  double windowHeight = 0.0;
  String titre ;


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
      children: [

       Container(
         margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top+10, left: 20, right: 20),
         child: Center(

           child: SingleChildScrollView(
             child: Column(
               crossAxisAlignment: CrossAxisAlignment.center,
              // mainAxisAlignment: MainAxisAlignment.center,
               children: [
                // SizedBox(height: 15,),
                 sujet(),
                // SizedBox(height: 10,),
                 message(),
                 SizedBox(height: 30,),
                 btn("Envoyer" , "callback",Colors.blue)

               ],
             ),
           ),
         ),
       )
      ],
    );



  }


  Widget sujet(){
    return TextFormField(
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
            labelText: 'Sujet',
            labelStyle: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)
        ),
      validator: emptyCheck,
        onSaved: (String value){
          titre = value;
        }

    );
  }

  Widget message(){
    return TextFormField(
      maxLines: 20,
      minLines: 10,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
            labelText: 'Message',
            labelStyle: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)
        ),
           validator: emptyCheck,
        onSaved: (String value){
          titre = value;
        }

    );
  }








  Widget btn (String name, String callback ,dynamic col) {

    return   ArgonButton(
      height: 50,
      roundLoadingShape: true,
      width: MediaQuery.of(context).size.width * 0.45,
      onTap: (startLoading, stopLoading, btnState) {
        if (btnState == ButtonState.Idle) {
          startLoading();
          Timer(const Duration(milliseconds: 1000), () {

            stopLoading();

            if(formkey.currentState.validate()) {
              formkey.currentState.save();
            };

            // Navigator.of(context).push(
            // MaterialPageRoute(
            // builder: (context) => SelectShop(myOrder,surecastItem,surecemItem)
            //                     )
            //                                  );
          });

        } else {
          stopLoading();
        }
      },
      child: Text(
        name,
        style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.w700),
      ),
      loader: Expanded(
        child: Container(
            padding: EdgeInsets.all(10),
            child:  SpinKitWave(
                size: 16,
                color: Colors.white, type: SpinKitWaveType.start) ),
      ),
      borderRadius: 5.0,
      color: col,
    );

  }


}

