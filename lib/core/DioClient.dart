import 'package:dio/dio.dart';

class DioClient {
  static Dio dio = Dio(
    BaseOptions(
      baseUrl: "https://jsonplaceholder.typicode.com/",
    ),
  );
}
