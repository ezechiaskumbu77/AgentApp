import 'dart:convert';

import 'dart:io';

import 'package:delivery_owner/main.dart';
import 'package:delivery_owner/models/user.dart';
import 'package:delivery_owner/ressources/localeDB.dart';
import 'package:delivery_owner/ressources/user/userDio.dart';
import 'package:delivery_owner/service/UserData.dart';
import 'package:delivery_owner/ui/widgets/easyDialog2.dart';
import 'package:delivery_owner/ui/widgets/iAvatarWithPhotoFileCaching.dart';
import 'package:delivery_owner/ui/widgets/ibutton2.dart';
import 'package:delivery_owner/ui/widgets/ilist4.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../service/UserData.dart';
import '../../mixins/geroData.dart';

class AccountScreen extends StatefulWidget {
 UserModel userL ;
  final Function(String) callback;
  AccountScreen({Key key, this.callback, this.userL}) : super(key: key);

  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {

  ///////////////////////////////////////////////////////////////////////////////
  //

  LocalDB _db = LocalDB();
  UserModel userEdit ;

  List<DropdownMenuItem<dynamic>> _villeList = [];
  List<DropdownMenuItem<dynamic>> _communeList = [ ];
  String _ville="0";
  String _commune="0";
  String _province= "0" ;


  List<Map<String,String>> communeMap = communeDataMap ;

  

  String _name;
  String _adresse;
  String _provinceFront;
  String _communeFront;
  String _villeFront;


  String  _birthDate;


  DateTime selectedDate = DateTime.now();
  String choseDate;
  _makePhoto(){
    print("Make photo");
    getImage();
  }

  _pressLogOutButton(){
    print("User pressed Log Out");

    account.logOut();
    userD.logOut();
    Navigator.pushNamedAndRemoveUntil(context, "/login", (r) => false);
  }

  _pressEditProfileButton(UserModel uu){
    print("User pressed Edit profile");
    _openEditProfileDialog(uu);
  }

  _callbackSave(){
    print("User pressed Save profile");
  //  print("User Name: ${editControllerName.text}, E-mail: ${editControllerEmail.text}, Phone: ${editControllerPhone.text}");
  }

  _callbackChange(){
    print("User pressed Change password");
    print("Old password: ${editControllerOldPassword.text}, New password: ${editControllerNewPassword1.text}, "
        "New password 2: ${editControllerNewPassword2.text}");
  }


  //
  //
  ///////////////////////////////////////////////////////////////////////////////
  var windowWidth;
  var windowHeight;
  final picker = ImagePicker();
  final editControllerName = TextEditingController();
  final editControllerPhone = TextEditingController();
  final editControllerAdress = TextEditingController();
  final editControllerOldPassword = TextEditingController();
  final editControllerNewPassword1 = TextEditingController();
  final editControllerNewPassword2 = TextEditingController();
  double _show = 0;
  Widget _dialogBody = Container();
  String imageUrl = "https://secure-sea-91184.herokuapp.com/uploads/photo_user.png";

  Future getImage2(ImageSource source) async {
    UserDio uploadService = UserDio();
    final pickedFile = await ImagePicker.pickImage(source: source, imageQuality: 40,) ;
    if (pickedFile != null && pickedFile.path != null) {





      print("Photo file: ${pickedFile.path}");
      var respo = await uploadService.upload(pickedFile);

      if(respo==null){
        print("null reponse ${respo}");
      } else {


    respo.stream.transform(utf8.decoder).listen((value) async {
    //    print(value);

    var resp = jsonDecode(value);
    UserModel uu;

    if(resp["success"]){

    await  _db.saveJson("user",  resp["user"]);
    var lol = await _db.read("user");



    //print("see the data $lol");
    uu  = UserModel.fromJson(jsonDecode(lol));

    print("user ${uu.photo_url}");


    }

    setState(() {

      imageUrl = "https://secure-sea-91184.herokuapp.com/uploads/${uu.photo_url== null ? "photo_user.png":  uu.photo_url}";
    });


    });



      }


      print("Photo file: ${pickedFile.path}");
    }
  }

  UserData userD ;



  var _sexe ;
  @override
  void initState() {

    _villeList.add(DropdownMenuItem(
      child: Text("",style: TextStyle(color: Colors.red,) ),
      value: "0",

    ));

    _communeList.add(DropdownMenuItem(
      child: Text("",style: TextStyle(color: Colors.red,) ),
      value: "0",

    ));

    _villeList.add(DropdownMenuItem(
      child: Text("Kinshasa",style:  theme.text12bold ),
      value: "Kinshasa",

    ));


    
    



     userD = UserData();
     


     imageUrl = widget.userL.photo_url == null ? "https://secure-sea-91184.herokuapp.com/uploads/photo_user.png":  "https://secure-sea-91184.herokuapp.com/uploads/${widget.userL.photo_url}";
     userEdit = widget.userL;
     _sexe =   widget.userL.sexe==null  ? "M":  widget.userL.sexe;
     _name = widget.userL == null ? " " : widget.userL.name ;
     _province = "1009";
     _commune = widget.userL == null ? "" : widget.userL.commune;
     _ville = widget.userL == null ? "" : widget.userL.ville;
     _adresse = widget.userL == null ? " " : widget.userL.address==null ? "":" ${widget.userL.address}  " ;
     _provinceFront = widget.userL == null ? " " : widget.userL.province==null ? "":" ${widget.userL.province}  " ;
     _villeFront = widget.userL == null ? " " : widget.userL.ville==null ? "":" ${widget.userL.ville}  " ;
     _communeFront = widget.userL == null ? " " : widget.userL.commune==null ? "":" ${widget.userL.commune}  " ;
     _birthDate =  widget.userL == null ? " " : widget.userL.birthday==null ? "":" ${widget.userL.birthday}  ";
     choseDate =  widget.userL == null ? " " :  widget.userL.birthday==null ? "":"${widget.userL.birthday}";







        super.initState();
  }
  @override
  void dispose() {
    editControllerName.dispose();

    editControllerPhone.dispose();
    editControllerOldPassword.dispose();
    editControllerNewPassword1.dispose();
    editControllerNewPassword2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    UserModel uu =  widget.userL;
    windowWidth = MediaQuery
        .of(context)
        .size
        .width;
    windowHeight = MediaQuery
        .of(context)
        .size
        .height;
    return Stack(
          children: <Widget>[

            Container(
              margin: EdgeInsets.only(top: MediaQuery
                  .of(context)
                  .padding
                  .top + 40),
              child: Container(
                  child: ListView(
                    padding: EdgeInsets.only(top: 0),
                    shrinkWrap: true,
                    children: _getList(uu),
                  )
              ),
            ),

              IEasyDialog2(setPosition: (double value){_show = value;}, getPosition: () {return _show;}, color: theme.colorGrey,
                body: _dialogBody, backgroundColor: theme.colorBackground,),

          ],

        );
  }


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

        var dt =  picked.toLocal().toString().split(' ')[0];
        choseDate = "   ${ dt.substring(8,10)}/${ dt.substring(5,7)}/${ dt.substring(0,4)}";

        _openEditProfileDialog(widget.userL);

      });
  }
  dataPicker (TextStyle style) {
    return Container(
    //  padding: EdgeInsets.only(left: 40),
      child: Row(

        children: <Widget>[
          Text(
            //"${selectedDate.toLocal()}".split(' ')[0],
            "Date de Naissance : ",
            style: style,
          ),

          RaisedButton(

            onPressed: () => _selectDate(context), // Refer step 3
            child: Text(
              choseDate ,
              style:
              style,
            ),
           // color: Colors.blue,
          ),
        ],
      ),
    );
  }

  _getList(UserModel uu) {
    var list = List<Widget>();

    list.add(
        Stack(
          children: [
            IAvatarWithPhotoFileCaching(
              avatar:  imageUrl,
              color: theme.colorPrimary,
              colorBorder: theme.colorGrey,
              callback: _makePhoto,
            ),
            _logoutWidget(),
          ],
        ));

    list.add(SizedBox(height: 10,));

    list.add(Container(
      color: theme.colorBackgroundGray,
      child: _userInfo(uu),
    ));

    list.add(SizedBox(height: 30,));

    list.add(Container(
        margin: EdgeInsets.only(left: 30, right: 30),
        child: _logout(uu)
    ));

    list.add(SizedBox(height: 30,));

    // list.add(Container(
    //     margin: EdgeInsets.only(left: 30, right: 30),
    //     child: _changePassword()
    // ));

    list.add(SizedBox(height: 100,));

    return list;
  }

  _changePassword(){
    return Container(
      alignment: Alignment.center,
      child: IButton2(
          color: theme.colorPrimary,
          text: strings.get(70),                           // Change password
          textStyle: theme.text14boldWhite,
          padding: 40,
          pressButton: _pressChangePasswordButton
      ),
    );
  }

  _logout(UserModel uu){
    return Container(
      alignment: Alignment.center,
      child: IButton2(
          color: theme.colorPrimary,
          text: strings.get(64),                           // Edit profile
          textStyle: theme.text14boldWhite,
          padding: 40,
          pressButton: (){
            _pressEditProfileButton(uu);
          }
      ),
    );
  }

  _logoutWidget(){
    return  Container(
      alignment: Alignment.topRight,
      margin: EdgeInsets.only(top: 10, right: 10),
      child: Stack(
        children: <Widget>[
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: theme.colorBackgroundDialog,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 3,
                  blurRadius: 3,
                  offset: Offset(1, 1), // changes position of shadow
                ),
              ],
            ),
            child: Icon(Icons.exit_to_app, color: theme.colorDefaultText..withOpacity(0.1), size: 30),
          ),
          Positioned.fill(
            child: Material(
                color: Colors.transparent,
                shape: CircleBorder(),
                clipBehavior: Clip.hardEdge,
                child: InkWell(
                  splashColor: Colors.grey[400],
                  onTap: (){
                    _pressLogOutButton();
                  }, // needed
                )),
          )
        ],
      ),);
  }

  _userInfo(UserModel uu){
    return SingleChildScrollView(
      child: Container(
          margin: EdgeInsets.only(left: 25, right: 25),
          child: Column(
            children: <Widget>[

              IList4(text: "${strings.get(32)}:", // "Username",
                textStyle: theme.text14bold,
                text2: _name,
                textStyle2: theme.text14bold,
              ),
              SizedBox(height: 5,),
              IList4(text: "Sexe :", // "E-mail",
                textStyle: theme.text14bold,
                text2:uu == null ? " " : uu.sexe == null ? "": uu.sexe == "M"? "Homme" : "Femme" ,
                textStyle2: theme.text14bold,
              ),
              SizedBox(height: 5,),
              IList4(text: "${strings.get(63)}:", // "Phone",
                textStyle: theme.text14bold,
                text2: uu == null ? " " : uu.phone,
                textStyle2: theme.text14bold,
              ),

              SizedBox(height: 5,),
              IList4(text: "Date de naissance : ", // "Phone",
                textStyle: theme.text14bold,
                text2: _birthDate ,
                textStyle2: theme.text14bold,
              ),

              SizedBox(height: 5,),
              IList4(text: "Adresse : ", // "Phone",
                textStyle: theme.text14bold,
                text2: _adresse ,
                textStyle2: theme.text14bold,
              ),

              SizedBox(height: 5,),
              IList4(text: "Type D'utilisateur :", // "Phone",
                textStyle: theme.text14bold,
                text2: "Agent Commercial",
                textStyle2: theme.text14bold,
              ),

            ],
          )

      ),
    );
  }



  _edit(TextEditingController _controller, String _hint, bool _obscure){
    return Container(
      height: 30,
      child: TextField(
        controller: _controller,
        onChanged: (String value) async {
        },
        cursorColor: theme.colorDefaultText,
        style: theme.text14,
        cursorWidth: 1,
        obscureText: _obscure,
        textAlign: TextAlign.left,
        maxLines: 1,
        decoration: InputDecoration(
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            border: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            hintText: _hint,
            hintStyle: theme.text14
        ),
      ),
    );
  }

  _pressChangePasswordButton(){
    _dialogBody = Container(
      margin: EdgeInsets.only(left: 20, right: 20),
      width: double.maxFinite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
              alignment: Alignment.center,
              child: Text(strings.get(70), textAlign: TextAlign.center, style: theme.text18boldPrimary,) // "Change password",
          ), // "Reason to Reject",
          SizedBox(height: 20,),
          Text("${strings.get(72)}:", style: theme.text12bold,),  // "Old password",
          _edit(editControllerOldPassword, strings.get(73), true),                //  "Enter your old password",
          SizedBox(height: 20,),
          Text("${strings.get(74)}:", style: theme.text12bold,),  // "New password",
          _edit(editControllerNewPassword1, strings.get(75), true),                //  "Enter your new password",
          SizedBox(height: 20,),
          Text("${strings.get(76)}:", style: theme.text12bold,),  // "Confirm New password",
          _edit(editControllerNewPassword2, strings.get(75), true),                //  "Enter your new password",
          SizedBox(height: 30,),
          Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IButton2(
                      color: theme.colorPrimary,
                      text: strings.get(71),                  // Change
                      textStyle: theme.text14boldWhite,
                      pressButton: (){
                        setState(() {
                          _show = 0;
                        });
                        _callbackChange();
                      }
                  ),
                  SizedBox(width: 10,),
                  IButton2(
                      color: theme.colorPrimary,
                      text: strings.get(66),              // Cancel
                      textStyle: theme.text14boldWhite,
                      pressButton: (){
                        setState(() {
                          _show = 0;
                        });
                      }
                  ),
                ],
              )),

        ],
      ),
    );

    setState(() {
      _show = 1;
    });
  }


  _openEditProfileDialog(UserModel uu){

    editControllerName.text = uu == null ? " "  : uu.name;
  editControllerAdress.text = uu == null ? " "  : uu.address==null? "": uu.address;
    editControllerPhone.text = uu == null ? " " :  account.phone;



    _dialogBody = Container(
      width: double.maxFinite,
      margin: EdgeInsets.only(left: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
              alignment: Alignment.center,
              child: Text(strings.get(64), textAlign: TextAlign.center, style: theme.text18boldPrimary,) // "Edit profile",
          ), // "Reason to Reject",
          SizedBox(height: 20,),
          Text("${strings.get(32)}:", style: theme.text12bold,),  // "User Name",
          _edit(editControllerName, strings.get(67), false),                //  "Enter your User Name",
          SizedBox(height: 10,),





          //start

          SizedBox(height: 10,),




          //end

          Text("Adresse :", style: theme.text12bold,),  // "E-mail",
          _edit(editControllerAdress, "Adresse  ", false),                //  "Enter your User E-mail",
          SizedBox(height: 20,),
          dataPicker (theme.text12bold),
          SizedBox(height: 20,),

          Row(

            children: [
              Container(
                  //padding: EdgeInsets.only(left: 40),
                  child: Text("Sexe  :    " ,style: theme.text12bold)),

              Row(
                children: [
                  IButton2(
                      color: _sexe == "M" ? theme.colorPrimary : Colors.black12,
                      text: "Homme",              // Cancel
                      textStyle: theme.text14boldWhite,
                      pressButton: (){
                        setState(() {
                          _sexe = "M";

                          userEdit.sexe = _sexe;
                          userEdit.province = _province;
                          userEdit.commune = _commune;
                          userEdit.ville = _ville;
                          userEdit.address = editControllerAdress.text;
                          userEdit.name  = editControllerName.text;
                          userEdit.birthday = choseDate;
                          _openEditProfileDialog(userEdit);
                        });
                      }
                  ),
                  IButton2(
                      color:  _sexe == "M" ?Colors.black12  :  theme.colorPrimary,
                      text: "Femme",              // Cancel
                      textStyle: theme.text14boldWhite,
                      pressButton: (){
                        setState(() {
                          _sexe = "F";

                          userEdit.sexe = _sexe;
                          userEdit.province = _province;
                          userEdit.commune = _commune;
                          userEdit.ville = _ville;
                          userEdit.address = editControllerAdress.text;
                          userEdit.name  = editControllerName.text;
                          userEdit.birthday = choseDate;
                          _openEditProfileDialog(userEdit);

                        });
                      }
                  ),
                ],
              ),


            ],
          ),
          // SizedBox(height: 20,),
          // Text("${strings.get(63)}:", style: theme.text12bold,),  // Phone
          // _edit(editControllerPhone, strings.get(69), false),                //  "Enter your User Phone",
          SizedBox(height: 30,),
          Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IButton2(
                      color: theme.colorPrimary,
                      text: strings.get(71),                  // Change
                      textStyle: theme.text14boldWhite,
                      pressButton: () async {
                        bool resp;

                        userEdit.sexe = _sexe;
                        userEdit.address = editControllerAdress.text;
                        userEdit.name  = editControllerName.text;
                        userEdit.birthday =choseDate ;



                        UserDio userDio = UserDio();

                        resp = await userDio.update(userEdit);
                        if(resp){
                          setState(() {
                            _show = 0;

                            _name = editControllerName.text;
                            _adresse = editControllerAdress.text;
                            _birthDate =     userEdit.birthday;

                          });
                          _callbackSave();
                        }

                      }
                  ),
                  SizedBox(width: 10,),
                  IButton2(
                      color: theme.colorPrimary,
                      text: strings.get(66),              // Cancel
                      textStyle: theme.text14boldWhite,
                      pressButton: (){
                        setState(() {
                          _show = 0;
                        });
                      }
                  ),
                ],
              )),

        ],
      ),
    );

    setState(() {
      _show = 1;
    });
  }

  getImage(){
    _dialogBody = Column(
      children: [
        InkWell(
            onTap: () {
              getImage2(ImageSource.gallery);
              setState(() {
                _show = 0;
              });
            }, // needed
            child: Container(
                padding: EdgeInsets.only(top: 10, bottom: 10),
                margin: EdgeInsets.only(top: 10, bottom: 10),
                height: 40,
                color: theme.colorBackgroundGray,
                child: Center(
                  child: Text(strings.get(77)), // "Open Gallery",
                )
            )),
        InkWell(
            onTap: () {
              getImage2(ImageSource.camera);
              setState(() {
                _show = 0;
              });
            }, // needed
            child: Container(
              padding: EdgeInsets.only(top: 10, bottom: 10),
              margin: EdgeInsets.only(bottom: 10),
              height: 40,
              color: theme.colorBackgroundGray,
              child: Center(
                child: Text(strings.get(78)), //  "Open Camera",
              ),
            )),
        SizedBox(height: 20,),
        IButton2(
            color: theme.colorPrimary,
            text: strings.get(66),              // Cancel
            textStyle: theme.text14boldWhite,
            pressButton: (){
              setState(() {
                _show = 0;
              });
            }
        ),
      ],
    );
    setState(() {
      _show = 1;
    });
  }

}