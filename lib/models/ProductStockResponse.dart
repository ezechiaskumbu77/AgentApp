import 'package:delivery_owner/models/ProductStock.dart';

class ProductStockReponse {

  final List<ProductStockModel> results;
  final String error;

  ProductStockReponse({this.results, this.error});

  ProductStockReponse.fromJson(Map<String ,dynamic> json):
      results = (json["data"] as List).map((i) => new ProductStockModel.fromJson(i)).toList(),
      error = "";

  ProductStockReponse.withError(String errorValue) :
      results = List(),
  error = errorValue;


}