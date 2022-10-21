class Shop {
  String id;
  String name;
  int star;
  String image;
  String desc;
  String shop;
  String shopId;
  String shopPhone;
  String shopMobilePhone;
  double price;
  double discPrice;
  String currency;
  String details;

  bool delivered;
  int count;
  String category;

  Shop(
      {this.image,
      this.name,
      this.star,
      this.id,
      this.shop,
      this.price,
      this.currency,
      this.count,
      this.desc,
      this.details,
      this.shopPhone,
      this.shopMobilePhone,
      this.delivered = false,
      this.shopId,
      this.category,
      this.discPrice});
}

var dishes = [
  Shop(
      name: "Surecast",
      image:
          "https://www.moncongo.com/sites/default/files/images/business/photos/DRC%20SURECAST%20FRENCH_2016-09-20_1.jpg",
      id: "1",
      shopId: "1",
      desc: "Description surecast ciment . Meilleur ciment",
      price: 7.0,
      discPrice: 5.99,
      currency: "\S",
      details: "",
      category: "1"),
  Shop(
      name: "Surecem",
      image:
          "https://ppc-jhb-web.azureedge.net/website/attachments/cjp2enumr019u0fqtwjfr3amx-surecem.full.png",
      id: "2",
      shopId: "1",
      desc: "Description Surecem , Meilleur ciment",
      price: 8.0,
      discPrice: 6.99,
      currency: "\S",
      details: "",
      category: "2"),
];
