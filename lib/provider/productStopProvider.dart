import 'package:delivery_owner/models/ProductStockResponse.dart';
import 'package:dio/dio.dart';
import 'interceptor.dart';


 class ProductStockApiProvider {
 // BaseOptions options = BaseOptions(receiveTimeout: 5000, connectTimeout: 5000);
  Dio _dio = Dio();
  final String _endpoint = "https://admin.ppc-drc.com/api/v1/productstock";

  addInterceptors(Dio dio) {
    dio.interceptors.add(AppInterceptors());
  }

  Future<ProductStockReponse> getProduct() async {

    print("provider begin");
    addInterceptors(_dio);
    try {
      Response response = await _dio.get(_endpoint);
      return ProductStockReponse.fromJson(response.data);
    } catch (error, stacktrace) {

      print("Exception occured : $error stackTrace : $stacktrace");
      return ProductStockReponse.withError("$error");

    }
  }





}



