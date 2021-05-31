import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task/Views/Login/offers_page.dart';
import 'package:task/webservices/repository.dart';

class LoginBloc {
  final Repository repository = Repository();

  var serviceFetcher = PublishSubject<Response>();

  Stream<Response> get responseData => serviceFetcher.stream;

  login(BuildContext context, String mail, pass) async {
    var response = await repository.login(mail, pass);
    serviceFetcher.sink.add(response);
    if (response.data['status'] == 200) {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setString('token', response.data["data"]["token"]);
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => OffersPage()),
          (route) => false);
    } else {
      print(response.data['message']);
    }
  }

  void dispose() async {
    await serviceFetcher.drain();
    serviceFetcher.close();
  }
}

final loginBloc = LoginBloc();
