

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class DioClient {
  static final Dio dio = Dio()
    ..options = BaseOptions(
      baseUrl: "https://jsonplaceholder.typicode.com/",
      connectTimeout: const Duration(seconds: 20),
      receiveTimeout: const Duration(seconds: 20),
      headers: {
        "Content-Type": "application/json",
      },
    )
    ..interceptors.add(ApiInterceptor());
}

class ApiInterceptor extends Interceptor {
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // ✅ Global success check
    if (response.statusCode == 200) {
      handler.next(response);
      debugPrint("checkingResponse------${response}");
    } else {
      handler.reject(
        DioException(
          requestOptions: response.requestOptions,
          response: response,
          error: "Error: ${response.statusMessage}",
          type: DioExceptionType.badResponse,
        ),
        true,
      );
    }
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // ✅ Global error handler
    print("API Error: ${err.response?.statusCode} ${err.message}");

    // You can even show a Snackbar/Toast here if you integrate GetX
    // Get.snackbar("Error", err.message ?? "Unknown error");

    handler.next(err);
  }
}

