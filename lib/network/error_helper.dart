import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:what_todo/network/api_error.dart';

class ErrorHelper {
  static late final StreamController<String> errorStream;

  static void broadcastError(Object e) {
    if (e is DioError && e.error is ApiError) {
      final message = (e.error as ApiError).message;
      errorStream.sink.add(message);
    } else {
      final message = e is ApiError ? e.message : e.toString();

      if (kDebugMode) {
        errorStream.sink.add(message);
      } else {
        errorStream.sink.add(ApiError.defaultErrorMessage);
      }
    }
  }
}
