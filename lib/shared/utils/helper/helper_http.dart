import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';

class AppHelperHttp {
  Dio http() {
    Dio http = Dio();
    (http.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };
    return http;
  }
}
