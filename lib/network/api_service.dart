import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:shopping_list_app_flutter/data/entities/grocery.dart';
import 'package:shopping_list_app_flutter/data/entities/shopping_list.dart';
import 'package:shopping_list_app_flutter/di/injection.dart';
import 'package:shopping_list_app_flutter/routes/navigator_service.dart';

class ApiService {
  var _navigationService = injection<NavigationService>();
  ApiService();
  static const String READ_SHOPPING_LIST_URL = "shopping_list/read_shopping_list.php";
  static const String READ_GROCERY_URL = "grocery/read_grocery.php";
  Dio _dio = Dio(
    BaseOptions(
      baseUrl: "https://piekarskipiotr.com/flutter_api/api/",
      connectTimeout: 5000,
      receiveTimeout: 3000,
    )
  );

  Future<List<ShoppingList>> fetchShoppingList() async {
    try {
      Response response = await _dio.get(READ_SHOPPING_LIST_URL);
      var json = response.data as List;
      return json.map((json) => ShoppingList.fromJson(json)).toList();
    } on DioError catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        log('Dio error!');
        log('STATUS: ${e.response?.statusCode}');
        log('DATA: ${e.response?.data}');
        log('HEADERS: ${e.response?.headers}');
      } else {
        // Error due to setting up or sending the request
        log('Error sending request!');
        log(e.message);
      }

      _navigationService.openDialog();
      return List.empty();
    }
  }

  Future<List<Grocery>> fetchGrocery() async {
    try {
      Response response = await _dio.get(READ_GROCERY_URL);
      var json = response.data as List;
      return json.map((json) => Grocery.fromJson(json)).toList();
    } on DioError catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        log('Dio error!');
        log('STATUS: ${e.response?.statusCode}');
        log('DATA: ${e.response?.data}');
        log('HEADERS: ${e.response?.headers}');
      } else {
        // Error due to setting up or sending the request
        log('Error sending request!');
        log(e.message);
      }
    }

    return new List.empty();
  }
}