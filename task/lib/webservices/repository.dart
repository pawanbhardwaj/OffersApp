import 'package:dio/dio.dart';
import 'package:task/Model/all_offers_model.dart';
import 'package:task/webservices/api_provider.dart';

class Repository {
  final ApiProvider apiProvider = ApiProvider();

  Future<Response> login(String mail, String pass) =>
      apiProvider.login(mail, pass);
  Future<AllOffers> getOffers() => apiProvider.getOffers();
}
