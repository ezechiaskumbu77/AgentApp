import 'package:cached_network_image/cached_network_image.dart';
import 'package:delivery_owner/main.dart';
import 'package:delivery_owner/model/category.dart';
import 'package:delivery_owner/model/shops.dart';
import 'package:delivery_owner/model/shopreview.dart';
import 'package:delivery_owner/ui/widgets/ICard12FileCaching.dart';
import 'package:delivery_owner/ui/widgets/ICard1FileCaching.dart';
import 'package:delivery_owner/ui/widgets/ICard21FileCaching.dart';
import 'package:delivery_owner/ui/widgets/IList1.dart';
import 'package:delivery_owner/ui/widgets/iboxCircle.dart';
import 'package:delivery_owner/ui/widgets/iinkwell.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ShopDetailsScreen extends StatefulWidget {
  final Map<String, dynamic> params;
  ShopDetailsScreen({Key key, this.params}) : super(key: key);
  @override
  _ShopDetailsScreenState createState() => _ShopDetailsScreenState();
}

class _ShopDetailsScreenState extends State<ShopDetailsScreen> with SingleTickerProviderStateMixin {

  ///////////////////////////////////////////////////////////////////////////////
  //

  _onBackClick(){
    Navigator.pop(context);
  }

  _onCategoriesClick(String id, String heroId){

    _currentCategoryId = id;
    for (var item in categories)
      if (item.id == id)
        _categoryName = item.name;
    setState(() {
    });
  }

  _onShopClick(String id, String heroId){

  }

  ///////////////////////////////////////////////////////////////////////////////
  var windowWidth;
  var windowHeight;
  var _currentCategoryId = "";
  var _controller = ScrollController();
  var _categoryName = "";

  @override
  void initState() {
    _categoryName = strings.get(147); // All
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    windowWidth = MediaQuery.of(context).size.width;
    windowHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: theme.colorBackground,
        body: NestedScrollView(
            controller: _controller,
            headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  expandedHeight: windowHeight*0.35,
                  automaticallyImplyLeading: false,
                  pinned: true,
                  elevation: 0,
                  backgroundColor: theme.colorPrimary,
                  flexibleSpace: FlexibleSpaceBar(
                    collapseMode: CollapseMode.pin,
                    background: _imageBuild(),
                  ),
                  title: Container(
                    width: windowWidth,
                    height: 30,
                    child: UnconstrainedBox(
                      alignment: Alignment.centerLeft,
                      child: IInkWell(child: _iconBackWidget(), onPress: _onBackClick,),
                    ),
                  ),
                )];
            },

            body: Stack (
              children: <Widget>[

                Container(
                  child: _body(),
                ),

              ],
            )
        ));
  }

  _body(){
    return Container(
      child: ListView(
        padding: EdgeInsets.only(top: 0),
        children: _children(),
      ),
    );
  }

  _children(){
    var list = List<Widget>();

    list.add(SizedBox(height: 20,));

    list.add(Container(
      margin: EdgeInsets.only(left: 20, right: 20),
      child: IList1(imageAsset: "assets/orders.png", text: _getStringParam("name"),                // name
          textStyle: theme.text16bold, imageColor: theme.colorDefaultText),
    ));

    list.add(SizedBox(height: 20,));

    list.add(Container(
      margin: EdgeInsets.only(left: 20, right: 20),
      child: Text(_getStringParam("desc"), style: theme.text14),                                               // description
    ));

    list.add(SizedBox(height: 20,));

    list.add(Container(
      margin: EdgeInsets.only(left: 20, right: 20),
      child: IList1(imageAsset: "assets/info.png", text: strings.get(69),                 // Information
          textStyle: theme.text16bold, imageColor: theme.colorDefaultText),
    ));

    list.add(_phone());
    list.add(_phoneMobile());

    // list.add(SizedBox(height: 20,));
    //
    // list.add(Container(
    //   margin: EdgeInsets.only(left: 20),
    //   child: IList1(imageAsset: "assets/categories.png", text: strings.get(149),             // "Menu",
    //       textStyle: theme.text16bold, imageColor: theme.colorDefaultText),
    // ));
    //
    // list.add(SizedBox(height: 10,));
    //
    // list.add(_horizontalCategories());

    list.add(SizedBox(height: 20,));

    list.add(Container(
      margin: EdgeInsets.only(left: 20, right: 20),
      child: IList1(imageAsset: "assets/top.png", text: "${strings.get(150)} - $_categoryName",                // Dishes
          textStyle: theme.text16bold, imageColor: theme.colorDefaultText),
    ));

    _mostPopular(list);

    list.add(SizedBox(height: 20,));

    list.add(Container(
      margin: EdgeInsets.only(left: 20),
      child: IList1(imageAsset: "assets/reviews.png", text: strings.get(151),            // "Reviews",
          textStyle: theme.text16bold, imageColor: theme.colorDefaultText),
    ));

    list.add(SizedBox(height: 10,));

    _reviews(list);

    list.add(SizedBox(height: 200,));

    return list;
  }

  _iconBackWidget(){
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.fromLTRB(20, 0, 10, 0),
      child: UnconstrainedBox(
          child: Container(
              height: 25,
              width: 25,
              child: Image.asset("assets/back.png",
                fit: BoxFit.contain, color: Colors.white,
              )
          )),
    );
  }

  _mostPopular(List<Widget> list){
    var height = windowWidth*0.5*0.8;

    bool first = true;
    Widget t1;
    for (var item in dishes) {
      if (item.shopId != _getStringParam("id"))
        continue;
      if (_currentCategoryId.isNotEmpty)
        if (item.category != _currentCategoryId)
          continue;
      if (first) {
        t1 = ICard21FileCaching(
          enableFavorites: false,
          color: theme.colorBackground,
          colorProgressBar: theme.colorPrimary,
          text: item.name,
          width: windowWidth * 0.5 - 25,
          height: height,
          image: item.image,
          id: item.id,
          text2: "${item.currency}${item.price.toStringAsFixed(2)}",
          textStyle2: theme.text14primary,
          textStyle: theme.text16bold,
          callback: _onShopClick,
        );
        first = false;
      }else{
        var t2 = ICard21FileCaching(
          enableFavorites: false,
          color: theme.colorBackground,
          colorProgressBar: theme.colorPrimary,
          text: item.name,
          width: windowWidth * 0.5 - 25,
          height: height,
          image: item.image,
          id: item.id,
          text2: "${item.currency}${item.price.toStringAsFixed(2)}",
          textStyle2: theme.text14primary,
          textStyle: theme.text16bold,
          callback: _onShopClick,
        );
        list.add(Container(
          margin: EdgeInsets.only(left: 5, right: 5),
          child: Row(
            children: <Widget>[
              t1,
              SizedBox(width: 10,),
              t2
            ],
          ),
        ));
        first = true;
      }
    }

    if (!first){
      list.add(Container(
        margin: EdgeInsets.only(left: 5, right: 5),
        child: Row(
          children: <Widget>[
            t1,
            SizedBox(width: 10,),
            Container(width: windowWidth * 0.5 - 15,)
          ],
        ),
      ));
    }
  }

  _reviews(List<Widget> list){
    for (var item in reviews) {
      list.add(Container(
        margin: EdgeInsets.only(left: 20, right: 20),
        child: ICard1FileCaching(
          color: theme.colorPrimary,
          title: item.name,
          text: item.text,
          date: item.date,
          titleStyle: theme.text18bold,
          textStyle: theme.text16,
          dateStyle: theme.text14grey,
          userAvatar: item.image,
          rating: item.star,
        ),
      ));
    }
  }

  _imageBuild(){
      return Container(
          child: Hero(
            tag: _getStringParam("heroid"),
              child: ClipRRect(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15)),
                  child: Container(
                    child: CachedNetworkImage(
                      placeholder: (context, url) =>
                          UnconstrainedBox(child:
                          Container(
                            alignment: Alignment.center,
                            width: 40,
                            height: 40,
                            child: CircularProgressIndicator(backgroundColor: theme.colorPrimary, ),
                          )),
                      imageUrl: _getStringParam("image"),
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
                  )
              )
          )
      );
  }

  _phone(){
    if (_getStringParam("phone").isEmpty)
      return Container();

    return Container(
      margin: EdgeInsets.only(left: 20, right: 20),
      child: Row(
        children: <Widget>[
          Expanded(
              child: Text("${strings.get(63)}: ${_getStringParam("phone")}", style: theme.text14)  //  "Phone",
          ),
          IInkWell(child: IBoxCircle(child: _icon(), color: Colors.white,), onPress: _callMe,)
        ],
      ),
    );
  }

  _phoneMobile(){
    if (_getStringParam("mobilephone").isEmpty)
      return Container();

    return Container(
      margin: EdgeInsets.only(left: 20, right: 20),
      child: Row(
        children: <Widget>[
          Expanded(
              child: Text("${strings.get(148)}: ${_getStringParam("mobilephone")}", style: theme.text14) // "Mobile Phone",
          ),
          IInkWell(child: IBoxCircle(child: _icon()), onPress: _callMeMobile,)
        ],
      ),
    );
  }

  _icon(){
    String icon = "assets/call.png";
    return Container(
        padding: EdgeInsets.all(5),
        child: UnconstrainedBox(
            child: Container(
                height: 30,
                width: 30,
                child: Image.asset(icon,
                  fit: BoxFit.contain, color: Colors.black,
                )
            ))
    );
  }

  _callMe() async {
    var uri = 'tel:${_getStringParam("phone")}';
    if (await canLaunch(uri))
      await launch(uri);
  }

  _callMeMobile() async {
    var uri = 'tel:${_getStringParam("mobilephone")}';
    if (await canLaunch(uri))
      await launch(uri);
  }

  _horizontalCategories(){
    var list = List<Widget>();
    var height = windowWidth*0.4*0.8;
    for (var item in categories) {
      list.add(ICard12FileCaching(
        color: theme.colorBackground,
        text: item.name,
        width: windowWidth * 0.4,
        height: height,
        image: item.image,
        id: item.id,
        textStyle: theme.text16bold,
        callback: _onCategoriesClick,
      ));
      list.add(SizedBox(width: 10,));
    }
    return Container(
      height: height+20,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: list,
      ),
    );
  }

  String _getStringParam(String name){
    if (widget.params != null){
      var _ret = widget.params[name];
      if (_ret == null)
        _ret = "";
      return _ret;
    }
    return "";
  }
}

