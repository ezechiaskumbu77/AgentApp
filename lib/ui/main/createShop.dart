import 'dart:async';

import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';
import 'package:delivery_owner/models/Shop.dart';
import 'package:delivery_owner/models/user.dart';
import 'package:delivery_owner/service/shopService.dart';
import 'package:delivery_owner/ui/widgets/inputForm.dart';
import 'package:flutter/material.dart';
import 'package:delivery_owner/ui/menu/menu.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../mixins/geroData.dart';
import 'package:delivery_owner/main.dart';




class CreateShop extends StatefulWidget {
  ShopModel shop;
  final Function(String, Map<String, dynamic>) callback;
  UserModel userL ;
  BuildContext ctx;
 // ShopModel shop ;
  CreateShop({Key key, this.callback , this.userL, this.ctx ,this.shop }) : super(key: key);
  @override
  _CreateShopState createState() => _CreateShopState();
}

class _CreateShopState extends State<CreateShop> {



  TextEditingController nameController = TextEditingController();
  TextEditingController quantityContoller = TextEditingController();
  TextEditingController adressContoller = TextEditingController();
  TextEditingController descContoller = TextEditingController();
  String _province= "0" ;
  List<DropdownMenuItem<dynamic>> _villeList = [];
  List<DropdownMenuItem<dynamic>> _communeList = [ ];
  String _ville="0";
  String _commune="0";
  List<Map<String,String>> communeMap = communeDataMap ;


  @override
  void initState()  {

    communeMap.forEach((elm) {
      _communeList.add(DropdownMenuItem(
        child: Text(elm['commune'],style:  theme.text12bold ),
        value: elm['value'],

      ));

      // print("its execute${elm['commune']}");
    });



    _villeList.add(DropdownMenuItem(
      child: Text("",style: TextStyle(color: Colors.red,) ),
      value: "0",

    ));

    _communeList.add(DropdownMenuItem(
      child: Text("",style: TextStyle(color: Colors.red,) ),
      value: "0",

    ));


    super.initState();
  }



  @override
  Widget build(BuildContext context) {



    var windowWidth = MediaQuery.of(context).size.width;
    var  windowHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top+10),
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Column(
                children: [
                  Card(
                    elevation: 5,
                    margin: EdgeInsets.all(5),
                    child: InkWell(
                      onTap: (){
                        Navigator.of(context).pop();
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 0),
                        child: Icon(Icons.arrow_back_ios_sharp,size: 35,),
                      )

                      ,
                    ),
                  ),


                ],
              ),

              Column(
                children: [
                  SizedBox(height: 30,),
                  Center(
                    child: Text(

                      "Créer un Depot",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20
                      ),
                    ),
                  ),
                  Divider(),

                  SizedBox(height: 20,),
                  MyCustomInputBox(label : "Noms", inputHint: "Entrez le nom du depot", txtControler: nameController,),
                  SizedBox(height: 20,),

                  MyCustomInputBox(label : "Capacité", inputHint: "Entrez la capacité", txtControler: quantityContoller,),
                  SizedBox(height: 10,),


                  Row(

                    children: [
                      Container(
                          padding: EdgeInsets.only(left: 10),
                          child: Text("Province  :    " ,style: TextStyle(color :Colors.black45,fontSize: 13, fontWeight: FontWeight.w700),)),

                      DropdownButton(
                          hint: Text("Selectionner une province",style: TextStyle(color :Colors.black45,fontSize: 13, fontWeight: FontWeight.w700,)),

                          value: _province,
                          items:provinceDataMap ,

                          onChanged: (value) {
                            setState(() {
                              _province = value;
                              if(value=="1009"){
                                // _ville="Kinshasa";
                                if(_villeList.length>1)  {
                                  _villeList = [DropdownMenuItem(
                                    child: Text("",style: TextStyle(color :Colors.black45,fontSize: 13, fontWeight: FontWeight.w700,) ),
                                    value: "0",

                                  )];
                                }


                                _villeList.add(DropdownMenuItem(
                                  child: Text("Kinshasa",style: TextStyle(color :Colors.black45,fontSize: 13, fontWeight: FontWeight.w700,) ),
                                  value: "Kinshasa",

                                ));
                              } else {


                                _ville= "0";


                                _villeList = [DropdownMenuItem(
                                  child: Text("",style: TextStyle(color :Colors.black45,fontSize: 13, fontWeight: FontWeight.w700,) ),
                                  value: "0",

                                )];


                                _commune ="0";


                                _communeList = [DropdownMenuItem(
                                  child: Text("",style: TextStyle(color :Colors.black45,fontSize: 13, fontWeight: FontWeight.w700,) ),
                                  value: "0",

                                )];
                              }
                              //  print("sexe ${_sexe}");
                            });




                            // ville


                          }),




                    ],
                  ),


                  SizedBox(height: 10,),
                  Row(

                    children: [
                      Container(
                          padding: EdgeInsets.only(left: 10),
                          child: Text("Ville  :    " ,style: TextStyle(color :Colors.black45,fontSize: 13, fontWeight: FontWeight.w700),)),

                      DropdownButton(

                          value: _ville,
                          items: _villeList
                          ,
                          onChanged: (value) {
                            setState(() {
                              _ville = value;

                              if(value=="Kinshasa"){
                                print("print value $value");
                                //_commune="Kinshasa";

                                if(_communeList.length>1){
                                  _communeList = [DropdownMenuItem(
                                    child: Text("",style: TextStyle(color :Colors.black45,fontSize: 13, fontWeight: FontWeight.w700,) ),
                                    value: "0",

                                  )];
                                }
                                communeMap.forEach((elm) {
                                  _communeList.add(DropdownMenuItem(
                                    child: Text(elm['commune'],style: TextStyle(color :Colors.black45,fontSize: 13, fontWeight: FontWeight.w700) ),
                                    value: elm['value'],

                                  ));

                                  // print("its execute${elm['commune']}");
                                });

                              } else {

                                _commune ="0";


                                _communeList = [DropdownMenuItem(
                                  child: Text("",style: TextStyle(color :Colors.black45,fontSize: 13, fontWeight: FontWeight.w700) ),
                                  value: "0",

                                )];
                              }




                              //  print("sexe ${_sexe}");
                            });
                          }),




                    ],
                  ),
                  SizedBox(height: 10,),


                  Row(

                    children: [
                      Container(
                          padding: EdgeInsets.only(left: 10),
                          child: Text("Commune :    " ,style: TextStyle(color: Colors.black45,fontSize: 13, fontWeight: FontWeight.w700),)),

                      Expanded(
                        child: DropdownButton(
                            hint: Text("",style: TextStyle(color: Colors.red,)),

                            value: _commune,
                            items: _communeList,
                            onChanged: (value) {
                              setState(() {

                                _commune = value;
                                //  _province = value;

                                //  print("sexe ${_sexe}");
                              });
                            }),
                      ),




                    ],
                  ),
                  SizedBox(height: 20,),
                  MyCustomInputBox(label : "Adresse", inputHint: "Entrez l'adresse'", txtControler: adressContoller,),
                  SizedBox(height: 20,),
                  MyCustomInputBox(label : "Description", inputHint: "Entrez la Description'", txtControler: descContoller,),
                  SizedBox(height: 20,),
                  btnContinuer(context,nameController.text ,quantityContoller.text , adressContoller.text ,descContoller.text)

                ],
              )
            ],
          ),
        ),
      )





    );










  }


  Widget btnContinuer(BuildContext ctx , String name , String quantite , String addresse , String description) {

    return ArgonButton(
      height: 50,
      roundLoadingShape: true,
      width: MediaQuery.of(ctx).size.width * 0.45,
      onTap: (startLoading, stopLoading, btnState) {
        if (btnState == ButtonState.Idle) {
          startLoading();

          Timer(const Duration(milliseconds: 1000), () async {

            widget.shop.name = name ;
            widget.shop.capacity = quantite ;
            widget.shop.address = addresse ;
            widget.shop.description = description ;
            widget.shop.ville = _ville ;
            widget.shop.commune = _commune ;
            widget.shop.province = _province ;

            CreateService serv = CreateService();

       var resp = await serv.create(widget.shop);

       print("see the reponse" + resp.toString());

             int count = 0;
             Navigator.of(context).popUntil((_) => count++ >= 2);
             stopLoading();





          });

        } else {
          stopLoading();
        }
      },
      child: Text(
        "Créer",
        style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w700),
      ),
      loader: Expanded(
        child: Container(
            padding: EdgeInsets.all(10),
            child:  SpinKitWave(
                size: 16,
                color: Colors.white, type: SpinKitWaveType.start)
        ),
      ),
      borderRadius: 5.0,
      color: Colors.blueAccent,
    );
  }
}
