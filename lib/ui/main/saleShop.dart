// import 'dart:async';
//
// import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';
// import 'package:delivery_owner/models/Shop.dart';
// import 'package:delivery_owner/models/ShopProduct.dart';
// import 'package:delivery_owner/models/user.dart';
// import 'package:delivery_owner/service/shopService.dart';
// import 'package:delivery_owner/ui/widgets/inputForm.dart';
// import 'package:flutter/material.dart';
// import 'package:delivery_owner/ui/menu/menu.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
//
//
//
//
// class SaleShop extends StatefulWidget {
//   List<ShopProductModel> listProd ;
//   //ShopModel shop;
// //  final Function(String, Map<String, dynamic>) callback;
//
//  // BuildContext ctx;
//  // ShopModel shop ;
//   SaleShop({Key key, this.listProd }) : super(key: key);
//   @override
//   _SaleShopState createState() => _SaleShopState();
// }
//
// class _SaleShopState extends State<SaleShop> {
//
//
//
//   TextEditingController nameController = TextEditingController();
//   TextEditingController quantityContoller = TextEditingController();
//   TextEditingController adressContoller = TextEditingController();
//   TextEditingController descContoller = TextEditingController();
//
//
//   @override
//   Widget build(BuildContext context) {
//
//
//
//     var windowWidth = MediaQuery.of(context).size.width;
//     var  windowHeight = MediaQuery.of(context).size.height;
//     return Scaffold(
//       body: Container(
//         margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top+10),
//         child: Stack(
//           children: [
//             Column(
//               children: [
//                 Card(
//                   elevation: 5,
//                   margin: EdgeInsets.all(5),
//                   child: InkWell(
//                     onTap: (){
//                       Navigator.of(context).pop();
//                     },
//                     child: Padding(
//                       padding: const EdgeInsets.only(left: 0),
//                       child: Icon(Icons.arrow_back_ios_sharp,size: 35,),
//                     )
//
//                     ,
//                   ),
//                 ),
//
//
//               ],
//             ),
//
//             Column(
//               children: [
//                 SizedBox(height: 30,),
//                 Center(
//                   child: Text(
//
//                     "Créer un Depot",
//                     style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       fontSize: 20
//                     ),
//                   ),
//                 ),
//                 Divider(),
//
//                 SizedBox(height: 20,),
//                 MyCustomInputBox(label : "Noms", inputHint: "Entrez le nom du depot", txtControler: nameController,),
//                 SizedBox(height: 20,),
//
//                 MyCustomInputBox(label : "Capacité", inputHint: "Entrez la capacité", txtControler: quantityContoller,),
//                 SizedBox(height: 20,),
//                 MyCustomInputBox(label : "Adresse", inputHint: "Entrez l'adresse'", txtControler: adressContoller,),
//                 SizedBox(height: 20,),
//                 MyCustomInputBox(label : "Description", inputHint: "Entrez la Description'", txtControler: descContoller,),
//                 SizedBox(height: 20,),
//                 btnContinuer(context,nameController.text ,quantityContoller.text , adressContoller.text ,descContoller.text)
//
//               ],
//             )
//           ],
//         ),
//       )
//
//
//
//
//
//     );
//
//
//
//
//
//
//
//
//
//
//   }
//
//
//   Widget btnContinuer(BuildContext ctx , String name , String quantite , String addresse , String description) {
//
//     return ArgonButton(
//       height: 50,
//       roundLoadingShape: true,
//       width: MediaQuery.of(ctx).size.width * 0.45,
//       onTap: (startLoading, stopLoading, btnState) {
//         if (btnState == ButtonState.Idle) {
//           startLoading();
//
//           Timer(const Duration(milliseconds: 1000), () async {
//
//             widget.shop.name = name ;
//             widget.shop.capacity = quantite ;
//             widget.shop.address = addresse ;
//             widget.shop.description = description ;
//             CreateService serv = CreateService();
//
//        var resp = await serv.create(widget.shop);
//
//        print("see the reponse" + resp.toString());
//
//              int count = 0;
//              Navigator.of(context).popUntil((_) => count++ >= 2);
//              stopLoading();
//
//
//
//
//
//           });
//
//         } else {
//           stopLoading();
//         }
//       },
//       child: Text(
//         "Créer",
//         style: TextStyle(
//             color: Colors.white,
//             fontSize: 18,
//             fontWeight: FontWeight.w700),
//       ),
//       loader: Expanded(
//         child: Container(
//             padding: EdgeInsets.all(10),
//             child:  SpinKitWave(
//                 size: 16,
//                 color: Colors.white, type: SpinKitWaveType.start)
//         ),
//       ),
//       borderRadius: 5.0,
//       color: Colors.blueAccent,
//     );
//   }
// }
