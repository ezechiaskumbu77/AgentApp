class AddressModel {
  String code;
  String commune;
  String ville;
  String province;

  AddressModel({this.code, this.commune, this.ville, this.province});

  AddressModel.fromJson(Map<String, dynamic> parsedJson)
      : code = parsedJson['code'],
        commune = parsedJson['name'],
        ville = parsedJson['location'],
        province =parsedJson['province'] ;
}


List<AddressModel> AddressModelFromJson( dynamic jsonData) {
  // print("Strat here ${jsonData}");
  // final data = jsonDecode(jsonData);
  List<AddressModel> listAll = List<AddressModel>.from(jsonData.map( (item){
    if(item["name"]=="Masina"  ){
 print("see data ${item}");
    };
    
     AddressModel adds = AddressModel.fromJson(item);
   //  print("done");
    return adds ;} ) );
//  print("russell voici ${data['data']}");

  print("All are Success");
  return listAll;
}

