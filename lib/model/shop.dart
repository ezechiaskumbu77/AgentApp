class Restaurant {
  String id;
  String name;
  String address;
  String published;
  double lat;
  double lng;
  String image;
  String phone;
  String desc;
  String mobilePhone;
  Restaurant({this.id, this.name, this.address, this.published, this.lat, this.lng, this.image, this.phone, this.mobilePhone, this.desc});
}


var restaurants = [
  Restaurant(id: "1", name: "Tonga ndaku", address: "24 Bakole , Righini Lemba , Kinshasa , RDC",
    lat: 48.881916, lng: 2.336729, image: "https://live.staticflickr.com/5242/5252707576_03f729e2c5_b.jpg",
    phone: "+243 9740506070", mobilePhone: "+243 8150987689",
    desc: "Meilleur Depot ",
  ),
  Restaurant(id: "2", name: "Ebenzer ", address: "Vitamine 34 , Matete Kinshasa, RDC",
    lat: 48.886648, lng: 2.334182, image: "https://i1.wp.com/theconstructor.org/wp-content/uploads/2018/03/storage-of-cement.jpg?resize=683%2C345&ssl=1",
    phone: "+243 8289485778", mobilePhone: "+243 97567488738",
    desc: "Livraison gratuite . Retour sans frais",
  ),
  Restaurant(id: "3", name: "Dept Béton", address: "Beni 45 , Lemba Righini, kinshasa , RDC ",
    lat: 48.869884, lng: 2.300196, image: "https://pbs.twimg.com/media/EFOvMfSX4AAh3rF.jpg",
    phone: "+243 97465783824", mobilePhone: "+243 907464838373",
    desc: "-50 reduction , Livraison gratuite",
  ),
];