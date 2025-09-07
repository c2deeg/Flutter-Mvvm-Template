import 'package:dio/dio.dart';

import '../core/DioClient.dart';
import 'UserModel.dart';


class UserRepository {
  final Dio _dio = DioClient.dio;

  Future<List<UserModel>> fetchUsers() async {
    final response = await _dio.get("users");
    return (response.data as List)
        .map((json) => UserModel.fromJson(json))
        .toList();
  }

  Future<UserModel> login(String email, String password) async {
    final response = await _dio.post(
      "login",
      data: {
        "email": email,
        "password": password,
      },
    );

    return UserModel.fromJson(response.data);
  }
}
