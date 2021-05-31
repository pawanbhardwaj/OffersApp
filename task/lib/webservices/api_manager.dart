import 'package:dio/dio.dart';
import 'package:task/Utils/constants.dart';

class ApiManager {
  Dio dio() {
    Dio dio = Dio(
      new BaseOptions(
        baseUrl: baseUrl,
      ),
    );

    return dio;
  }
}
