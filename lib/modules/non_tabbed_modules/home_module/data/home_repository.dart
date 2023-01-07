import 'package:attendanceappadmin/shared/data/api_route.dart';
import 'package:attendanceappadmin/shared/models/shared_session_generated_model.dart';
import 'package:attendanceappadmin/shared/utils/helper/helper_http.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

class HomeRepository {
  Future<SharedSessionGenerated?> sessionStart() async {
    Dio http = AppHelperHttp().http();
    String userId = '1';
    String path = AppApiRoutes.pathGenerateSession;
    SharedSessionGenerated? data;

    try {
      FormData postData = FormData.fromMap({
        "date": DateFormat("y-M-d").format(DateTime.now()),
        "admin_id": userId,
      });

      Response response = await http.post(
        path,
        data: postData,
      );

      // print(response.data);

      data = SharedSessionGenerated.fromJson(
        response.data,
      );

      if (data.code == 200) {
        return data;
      } else {
        return null;
      }
    } on DioError catch (err) {
      // http error
      if (kDebugMode) {
        print("sessionStart(), http error at: $err");
      }
      return null;
    } catch (err) {
      // other error
      if (kDebugMode) {
        print("sessionStart(), unknown error at: $err");
      }
      return null;
    }
  }
}
