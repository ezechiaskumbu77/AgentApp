import 'package:delivery_owner/models/user.dart';
import 'package:delivery_owner/service/authservice.dart';
import 'package:delivery_owner/service/shopManagerService.dart';
import 'package:flutter/material.dart';
import 'package:delivery_owner/main.dart';
import 'package:delivery_owner/ui/widgets/iappBar.dart';
import 'package:delivery_owner/ui/widgets/ibackground4.dart';
import 'package:delivery_owner/ui/widgets/ibox.dart';
import 'package:delivery_owner/ui/widgets/ibutton.dart';
import 'package:delivery_owner/ui/widgets/iinputField2.dart';
import 'package:delivery_owner/ui/widgets/iinputField2Password.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../mixins/geroData.dart';

class CreateShopManager extends StatefulWidget {
  final Function(String, Map<String, dynamic>) callback;


  UserModel user ;

  CreateShopManager({Key key, this.user, this.callback }) : super(key: key);
  @override
  _CreateShopManagerState createState() => _CreateShopManagerState();
}

class _CreateShopManagerState extends State<CreateShopManager>
    with SingleTickerProviderStateMixin {

  //////////////////////////////////////////////////////////////////////////////////////////////////////
  //
  //
  //
  String _sexe = "M";

  DateTime selectedDate = DateTime.now();
  _pressCreateAccountButton() async{

    if( editControllerName.text.isEmpty  || editControllerAddress.text.isEmpty|| _ville.isEmpty || _province.isEmpty || _commune.isEmpty){
      Fluttertoast.showToast(
          msg: "Noms , adresse , date de naissance , ville , commune et province ne doivent pas etre vide",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.blue,
          textColor: Colors.white,
          fontSize: 16.0
      );
    } else {

      widget.user.address = editControllerAddress.text;
      widget.user.sexe = _sexe;
      widget.user.name =  editControllerName.text;
      widget.user.birthday =   choseDate;
      widget.user.commune =   _commune;
      widget.user.province =   _province;
      widget.user.ville =   _ville;
      print("see your date ${ widget.user.birthday}");

      ShopManagerService managerService = ShopManagerService();




        bool isLogin = await  managerService.create( widget.user);
        if(isLogin ) {

          int count = 0;
          Navigator.of(context).popUntil((_) => count++ >= 2);


        //  Navigator.pushNamed(context,"/setotp");
        }





    }

    //Navigator.pushNamedAndRemoveUntil(context, "/main", (r) => false);
  }

  //
  //////////////////////////////////////////////////////////////////////////////////////////////////////
  var windowWidth;
  String _province= "0" ;
  List<DropdownMenuItem<dynamic>> _villeList = [];
  List<DropdownMenuItem<dynamic>> _communeList = [ ];
  String _ville="0";
  String _commune="0";

  List<Map<String,String>> communeMap = communeDataMap ;
  String choseDate = 'Choisir la date';
  var windowHeight;
  final editControllerName = TextEditingController();
  final editControllerSexe = TextEditingController();
  final editControllerAddress = TextEditingController();
  //final editControllerPassword2 = TextEditingController();

  @override
  void initState() {
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
  void dispose() {
    editControllerName.dispose();
    editControllerSexe.dispose();
    editControllerAddress.dispose();
  //  editControllerPassword2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    windowWidth = MediaQuery.of(context).size.width;
    windowHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: theme.colorBackground,

      body: Stack(
        children: <Widget>[

          IBackground4(width: windowWidth, colorsGradient: [Colors.blue , Colors.blueAccent , Colors.blueGrey]),

          IAppBar(context: context, text: "", color: Colors.white),

          Center(
                child: Container(
                  margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  width: windowWidth,
                  child: _body(context),
                  )
           ),

        ],
      ),
    );
  }

  _body(context){




    _selectDate(BuildContext context) async {
      final DateTime picked = await showDatePicker(

       locale: const Locale("fr","FR"),
        context: context,
        initialDate: selectedDate, // Refer step 1
        firstDate: DateTime(1900),
        lastDate: DateTime( DateTime.now().year+1),
        builder: (BuildContext context, Widget child) {
          return Theme(
            data: ThemeData.dark().copyWith(
              colorScheme: ColorScheme.dark(
                primary: Colors.white,
                onPrimary: Colors.black,
                surface: Colors.blue,
                onSurface: Colors.white,

              ),
              dialogBackgroundColor:Colors.blue,
            ),
            child: child,
          );
        },
      );
      if (picked != null && picked != selectedDate)
        setState(() {
          selectedDate = picked;
          choseDate = picked.toLocal().toString().split(' ')[0];

        });
    }
    dataPicker () {
      return Container(
        padding: EdgeInsets.only(left: 10),
        child: Row(

          children: <Widget>[
            Text(
              //"${selectedDate.toLocal()}".split(' ')[0],
            "Date de Naissance : ",
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: Colors.blue),
            ),

            RaisedButton(

              onPressed: () => _selectDate(context), // Refer step 3
              child: Text(
                 choseDate ,
                style:
                TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              color: Colors.blue,
            ),
          ],
        ),
      );
    }


    return ListView(
      shrinkWrap: true,
      children: <Widget>[

        Container(
          margin: EdgeInsets.only(left: 15, right: 20),
          alignment: Alignment.centerLeft,
          child: Text("Créer un Shop Manager",                        // "Create an Account!"
              style:  TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: Colors.blue)
          ),
        ),
        SizedBox(height: 20,),

        IBox(
            color: theme.colorBackgroundDialog,
            child: Column(
              children: <Widget>[
                SizedBox(height: 15,),
                Container(
                    margin: const EdgeInsets.fromLTRB(8, 0, 20, 0),
                    child:
                    IInputField2(
                      hint: "Noms",            // "Login"
                      icon: Icons.attribution_sharp,
                      colorDefaultText: Colors.blue,
                      colorBackground: theme.colorBackgroundDialog,
                      controller: editControllerName,
                    )
                ),
                SizedBox(height: 10,),

                Row(

                  children: [
                    Container(
                        padding: EdgeInsets.only(left: 10),
                        child: Text("Province  :    " ,style:  TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: Colors.blue))),

                    DropdownButton(
                        hint: Text("Selectionner une province",style:  TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: Colors.blue)),

                        value: _province,
                        items:provinceDataMap ,

                        onChanged: (value) {
                          setState(() {
                            _province = value;
                            if(value=="1009"){
                              // _ville="Kinshasa";
                              if(_villeList.length>1)  {
                                _villeList = [DropdownMenuItem(
                                  child: Text("",style:  TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: Colors.blue) ),
                                  value: "0",

                                )];
                              }


                              _villeList.add(DropdownMenuItem(
                                child: Text("Kinshasa",style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: Colors.blue) ),
                                value: "Kinshasa",

                              ));
                            } else {


                              _ville= "0";


                              _villeList = [DropdownMenuItem(
                                child: Text("",style:  TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: Colors.blue)),
                                value: "0",

                              )];


                              _commune ="0";


                              _communeList = [DropdownMenuItem(
                                child: Text("",style:   TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: Colors.blue) ),
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
                        child: Text("Ville  :    " ,style:  TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: Colors.blue))),

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
                                  child: Text("",style:  TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: Colors.blue)),
                                  value: "0",

                                )];
                              }
                              communeMap.forEach((elm) {
                                _communeList.add(DropdownMenuItem(
                                  child: Text(elm['commune'],style:   TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: Colors.blue) ),
                                  value: elm['value'],

                                ));

                                // print("its execute${elm['commune']}");
                              });

                            } else {

                              _commune ="0";


                              _communeList = [DropdownMenuItem(
                                child: Text("",style:   TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: Colors.blue) ),
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
                        child: Text("Commune :    " ,style:  TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: Colors.blue))),

                    Expanded(
                      child: DropdownButton(
                          hint: Text("",style:  TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: Colors.blue)),

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

                SizedBox(height: 10,),

                Container(
                    margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child:
                    IInputField2(
                      hint: "Adresse",            // "E-mail address",
                      icon: Icons.add_location_alt,
                      colorDefaultText:Colors.blue,
                      colorBackground: theme.colorBackgroundDialog,
                      controller: editControllerAddress,
                    )
                ),
                SizedBox(height: 10,),
                dataPicker (),
                SizedBox(height: 10,),
                Row(

                  children: [
                    Container(
                        padding: EdgeInsets.only(left: 10),
                        child: Text("Sexe  :    " ,style:  TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: Colors.blue),)),

                    DropdownButton(

                        value: _sexe,
                        items: [
                          DropdownMenuItem(
                            child: Text("Homme",style: TextStyle(color: Colors.blue,) ),
                            value: "M",
                          ),
                          DropdownMenuItem(
                            child: Text("Femme" ,style: TextStyle(color: Colors.blue,)),
                            value: "F",
                          ),

                        ],
                        onChanged: (value) {
                          setState(() {
                            _sexe = value;
                            print("sexe ${_sexe}");
                          });
                        }),
                  ],
                ),

                SizedBox(height: 20,),
                Container(
                  margin: EdgeInsets.only(left: 20, right: 20),
                  child: IButton(pressButton: _pressCreateAccountButton, text: "Créer ", // CREATE ACCOUNT
                    color: Colors.blue,
                    textStyle: theme.text16boldWhite,),
                ),
                SizedBox(height: 15,),
              ],
            )
        ),

      ],
    );
  }

}