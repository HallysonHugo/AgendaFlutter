import 'package:dio/dio.dart';

class CustomDio{
  static final BaseOptions options = BaseOptions(
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
  );
}