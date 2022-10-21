import 'package:delivery_owner/models/shopManager.dart';
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

class ShopManagerDetail extends StatefulWidget {



  ManagerModel manager ;

  ShopManagerDetail({Key key, this.manager}) : super(key: key);
  @override
  _ShopManagerDetailState createState() => _ShopManagerDetailState();
}

class _ShopManagerDetailState extends State<ShopManagerDetail>
    with SingleTickerProviderStateMixin {

  //////////////////////////////////////////////////////////////////////////////////////////////////////
  //
  //
  //
  String _sexe = "M";

  DateTime selectedDate = DateTime.now();
  _pressCreateAccountButton() async{

    if( editControllerName.text.isEmpty  || editControllerAddress.text.isEmpty){
      Fluttertoast.showToast(
          msg: "Noms , adresse et date de naissance ne doivent pas etre vide",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.blue,
          textColor: Colors.white,
          fontSize: 16.0
      );
    } else {
      widget.manager.userID..address = editControllerAddress.text;
      widget.manager.userID.sexe = _sexe;
      widget.manager.userID.name =  editControllerName.text;
      widget.manager.userID.birthday =   choseDate;
      widget.manager.userID.phone =   "+243${editControllerPhone.text}";

   ShopManagerService managerService = ShopManagerService();

     bool isLogin = await  managerService.update( widget.manager.userID);
        if(isLogin ) {

          int count = 0;
          Navigator.of(context).pop();

        }
    }
  }


  _pressDeleteBtnPress() async{



      ShopManagerService managerService = ShopManagerService();

      bool isLogin = await managerService.delete( widget.manager.userID);
      if(isLogin ){
        Navigator.of(context).pop();
      }

  }

  //
  //////////////////////////////////////////////////////////////////////////////////////////////////////
  var windowWidth;
  String phone ;
  String choseDate = 'Choisir la date';
  var windowHeight;
  final editControllerName = TextEditingController();
  final editControllerSexe = TextEditingController();
  final editControllerAddress = TextEditingController();
  final editControllerPhone = TextEditingController();
  //final editControllerPassword2 = TextEditingController();

  @override
  void initState() {
    editControllerName.text = widget.manager.userID.name;
    editControllerAddress.text = widget.manager.userID.address;
    editControllerSexe.text = widget.manager.userID.sexe;
    editControllerPhone.text = widget.manager.userID.phone.substring(4, 13);
    choseDate = widget.manager.userID.birthday;
   // print("${ widget.manager.userID.phone.substring(5, 13)}");
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
        padding: EdgeInsets.only(left: 40),
        child: Row(

          children: <Widget>[
            Text(
              //"${selectedDate.toLocal()}".split(' ')[0],
            "Date de Naissance : ",
              style: TextStyle(fontSize: 16, color: Colors.blue),
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
          alignment: Alignment.center,
          child: Text("Shop Manager",                        // "Create an Account!"
              style: theme.text20boldWhite
          ),
        ),
        SizedBox(height: 10,),
        IBox(
            color: theme.colorBackgroundDialog,
            child: Column(
              children: <Widget>[
                SizedBox(height: 15,),
                Container(
                    margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: IInputField2(
                        code: "+243",
                        hint: "",            // "Login"
                        icon: Icons.phone,
                        colorDefaultText: Colors.blue,
                        colorBackground: theme.colorBackgroundDialog,
                        controller: editControllerPhone,
                        type: TextInputType.emailAddress
                    )
                ),


                SizedBox(height: 15,),

              ],
            )
        ),
        SizedBox(height: 20,),

        IBox(
            color: theme.colorBackgroundDialog,
            child: Column(
              children: <Widget>[
                SizedBox(height: 15,),
                Container(
                    margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
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
                        padding: EdgeInsets.only(left: 40),
                        child: Text("Sexe  :    " ,style: TextStyle(color: Colors.blue,fontSize: 15),)),

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
                  child: Column(
                    children: [
                      IButton(pressButton: _pressCreateAccountButton, text: "Modifier ", // CREATE ACCOUNT
                        color: Colors.blue,
                        textStyle: theme.text16boldWhite,),
                      SizedBox(height: 5,),
                      IButton(pressButton:_pressDeleteBtnPress, text: "Supprimer ", // CREATE ACCOUNT
                        color: Color(0xffFF0000),
                        textStyle: theme.text16boldWhite,),
                    ],
                  ),
                ),
                SizedBox(height: 15,),
              ],
            )
        ),

      ],
    );
  }

}