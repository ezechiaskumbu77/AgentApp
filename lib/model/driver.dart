class Driver {
  String id;
  bool online;
  String name;
  String phone;
  String image;

  Driver({this.id, this.online, this.name, this.phone, this.image
  });
}

var drivers = [
  Driver(id: "1", online: true, name: "Percy Mpoyi", phone: "+243 813478735980",
      image: "https://scontent-ams4-1.xx.fbcdn.net/v/t1.0-9/44300380_110160479972454_500564067388227584_o.jpg?_nc_cat=104&_nc_sid=174925&_nc_ohc=NcdO1vhFcbwAX_m4fIJ&_nc_ht=scontent-ams4-1.xx&oh=3115b9a201b1e462678f011c8a530dfd&oe=5FA13F88"),
  Driver(id: "2", online: false, name: "Maria Ngalula", phone: "+243 8984937297389238",
      image: "https://scontent-amt2-1.xx.fbcdn.net/v/t1.0-9/120841548_336302530955777_7643751555154372108_o.jpg?_nc_cat=106&_nc_sid=8bfeb9&_nc_ohc=E5CcsVOa3EEAX_NWjXT&_nc_ht=scontent-amt2-1.xx&oh=2dff13a061d617f38e790cbfa68bd297&oe=5FA0A579"),
  Driver(id: "3", online: true, name: "Jeremie Moya", phone: "+243 895340353242",
      image: "https://scontent-amt2-1.xx.fbcdn.net/v/t1.0-9/120851174_2661341294118559_4449448563416451843_n.jpg?_nc_cat=106&_nc_sid=8bfeb9&_nc_ohc=L0nBD_eUyhUAX_OO4mh&_nc_oc=AQkw50Hk3etsFMytRb8CdRhwFUnUbhlHLV6ScgurvW_Okdi2X4qsqJrG3vxmoOZ24eU&_nc_ht=scontent-amt2-1.xx&oh=582ec8bee3809b3ab688da2cd9b1b164&oe=5FA281EE"),

  Driver(id: "4", online: false, name: "Gauis Mapela", phone: "+243 8922745242",
      image: "https://scontent-amt2-1.xx.fbcdn.net/v/t1.0-9/93716721_3136752836376881_8461478760196079616_o.jpg?_nc_cat=111&_nc_sid=09cbfe&_nc_ohc=Z2NdHQRgAhgAX_SS0kk&_nc_ht=scontent-amt2-1.xx&oh=d4c990e99157f13b970cf6f8fac1c72c&oe=5FA27E86"),
  Driver(id: "5", online: true, name: "Matuta Junior", phone: "+243 81223284248",
      image: "https://scontent-amt2-1.xx.fbcdn.net/v/t1.0-9/87040395_795073437671614_8978322347069014016_n.jpg?_nc_cat=111&_nc_sid=174925&_nc_ohc=-0LRjkC1V_sAX-7nJ64&_nc_ht=scontent-amt2-1.xx&oh=8ac1e3bbda4b9bc43886604cbbee178d&oe=5FA095F4"),
  Driver(id: "6", online: true, name: "Tania Kamba", phone: "+243 8228747384",
      image: "https://scontent-ams4-1.xx.fbcdn.net/v/t1.0-9/91568547_809835269538709_8230970605608894464_o.jpg?_nc_cat=104&_nc_sid=09cbfe&_nc_ohc=hIYuX_4hl70AX8aegR1&_nc_ht=scontent-ams4-1.xx&oh=1b3940c1c1db29ea6f2bdd23eac7f6d4&oe=5FA265AD"),

];