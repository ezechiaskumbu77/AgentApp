class Reviews {
  final String image;
  final String name;
  final String text;
  final String date;
  final double star;
  final String id;
  Reviews({this.image, this.text, this.star, this.id, this.name, this.date});
}

var reviews = [
  Reviews(image: "https://scontent-ams4-1.xx.fbcdn.net/v/t1.0-9/91568547_809835269538709_8230970605608894464_o.jpg?_nc_cat=104&_nc_sid=09cbfe&_nc_ohc=hIYuX_4hl70AX8aegR1&_nc_ht=scontent-ams4-1.xx&oh=1b3940c1c1db29ea6f2bdd23eac7f6d4&oe=5FA265AD",
    name: "Sandra Mayamba", text: "Livraison rapide . et un bon service de support",
    date: "2020-08-11 13:15",
    id : "1", star: 4.2, ),

  Reviews(image: "https://scontent-amt2-1.xx.fbcdn.net/v/t1.0-9/119070381_1655697367931386_8382281761324731958_n.jpg?_nc_cat=102&_nc_sid=09cbfe&_nc_ohc=XDcsRFe3WToAX8iNf-x&_nc_ht=scontent-amt2-1.xx&oh=0e354efd65cca6d2d7815ceb98c3625a&oe=5F9FEE39",
    name: "Adeje Nseka", text: "Meilleur de meilleur",
    date: "2020-08-13 14:15",
    id : "2", star: 4.6, ),

  Reviews(image: "https://scontent-ams4-1.xx.fbcdn.net/v/t1.0-9/110167932_328249295234515_8838108279980163638_o.jpg?_nc_cat=108&_nc_sid=09cbfe&_nc_ohc=t6YXmCSWieIAX-IDhC5&_nc_ht=scontent-ams4-1.xx&oh=a801f1a9e59439c730b59dbc45c55c2e&oe=5FA133BF",
    name: "Abele Baya", text: " livraison lente , mauvaise concervation de ciment ",
    date: "2020-08-15 18:45",
    id : "3", star: 4.0, ),

  Reviews(image: "https://scontent-amt2-1.xx.fbcdn.net/v/t1.0-9/104795633_2560841810895049_4877697033322167551_n.jpg?_nc_cat=101&_nc_sid=09cbfe&_nc_ohc=H-Pxjmuu_U4AX-8iDmw&_nc_ht=scontent-amt2-1.xx&oh=3cd4a866abedf42ea6ef79e92ba100de&oe=5FA22766",
    name: "jared lukoji", text: "Top de top",
    date: "2020-08-20 09:10",
    id : "4", star: 5.0, ),
];


