import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:task/Model/all_offers_model.dart';
import 'package:task/webservices/api_manager.dart';

class ApiProvider {
  final ApiManager apiManager = ApiManager();

  ///API to login
  Future<Response> login(String email, String pass) async {
    try {
      Response response = await apiManager.dio().post(
          '/login?email=$email&password=$pass&device_type=android&device_id=12345&country=IN');
      print(response.data);
      return response;
    } on DioError catch (e) {
      print('ERROR=> ${e.response?.data}');
      return e.response?.data;
    }
  }

  /// API to get offers
  Future<AllOffers> getOffers() async {
    try {
      Response response =
          await apiManager.dio().get('/offer/search?start=0&count=10');
      print(response.data);
      return allOffersFromJson(jsonEncode(response.data));
    } on DioError catch (e) {
      print('ERROR=> ${e.response?.data}');
      return e.response?.data;
    }
  }
}
