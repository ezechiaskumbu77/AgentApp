class OrderDetails {
  String id;
  String date;
  String productName;
  int count;
  double productPrice;
  String extras;
  int extrasCount;
  double extrasPrice;
  String image;

  OrderDetails({this.id, this.date, this.productName, this.count,
    this.productPrice, this.extras,
    this.extrasCount, this.extrasPrice, this.image,
  });
}