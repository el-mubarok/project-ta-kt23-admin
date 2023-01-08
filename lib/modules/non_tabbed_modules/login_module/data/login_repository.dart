import 'package:attendanceappadmin/config/constants.dart';
import 'package:attendanceappadmin/shared/data/api_route.dart';
import 'package:attendanceappadmin/shared/models/shared_user_data_model.dart';
import 'package:attendanceappadmin/shared/utils/helper/helper_device.dart';
import 'package:attendanceappadmin/shared/utils/helper/helper_http.dart';
import 'package:attendanceappadmin/shared/utils/helper/helper_storage.dart';
import 'package:attendanceappadmin/shared/utils/utils_global.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class LoginRepository {
  Future<SharedUserData?> submitLogin(String username, String password) async {
    Dio http = AppHelperHttp().http();
    String path = AppApiRoutes.pathLogin;
    String deviceId = await AppHelperDevice().getEncodedDeviceId();
    String role = "admin";
    String? messagingId = AppUtilsGlobal().messagingId.value;
    SharedUserData? data;

    try {
      FormData postData = FormData.fromMap({
        "username": username,
        "password": password,
        "device_id": deviceId,
        "role": role,
        "messaging_id": messagingId,
      });

      if (kDebugMode) {
        print({
          "username": username,
          "password": password,
          "device_id": deviceId,
          "role": role,
          "messaging_id": messagingId,
        });
      }

      Response response = await http.post(
        path,
        data: postData,
      );
      data = SharedUserData.fromJson(response.data);

      if (data.code == 200) {
        return data;
      } else {
        return null;
      }
    } on DioError catch (err) {
      // http error
      /**
       * code:
       * 402 -> wrong password
       * 403 -> wrong username/password
       * 404 -> max attempt reached
       */
      if (kDebugMode) {
        print("submitLogin(): http error at: $err");
      }
      data = SharedUserData.fromJson(err.response?.data);
      return data;
    } catch (err) {
      // unknown error
      if (kDebugMode) {
        print("submitLogin(): unknwon error at: $err");
      }
      return null;
    }
  }

  Future<bool> checkIsLoggedIn() async {
    bool isExists = await AppHelperStorage().checkIsExists(
      AppConfigConstant.sessionUserData,
    );

    if (isExists) {
      // load userdata to active state
      await AppHelperStorage().loadUserDataToState();
      bool reload = await reloadUserData();
      if (!reload) {}
    }

    return isExists;
  }

  Future<bool> reloadUserData() async {
    Dio http = AppHelperHttp().http();
    String path = AppApiRoutes.pathUserDetail;
    String? userId = AppUtilsGlobal().userData.value?.data?.id.toString();
    SharedUserData? data;

    try {
      Response response = await http.get(path, queryParameters: {
        "user_id": userId,
      });

      data = SharedUserData.fromJson(response.data);

      await AppHelperStorage().storeUserData(data);

      return true;
    } on DioError catch (err) {
      // http error
      if (kDebugMode) {
        print("reloadUserData(): unknown error at: $err");
      }
      return false;
    } catch (err) {
      // unknown error
      if (kDebugMode) {
        print("reloadUserData(): unknown error at: $err");
      }
      return false;
    }
  }

  Future<bool> submitResetPassword(String password) async {
    Dio http = AppHelperHttp().http();
    String path = AppApiRoutes.pathResetPassword;
    String? userId = AppUtilsGlobal().userData.value?.data?.id.toString();
    String deviceId = await AppHelperDevice().getEncodedDeviceId();
    SharedUserData? data;

    try {
      FormData postData = FormData.fromMap({
        "password": password,
        "device_id": deviceId,
        "user_id": userId,
      });

      if (kDebugMode) {
        print({
          "password": password,
          "device_id": deviceId,
          "user_id": userId,
        });
      }

      Response response = await http.post(
        path,
        data: postData,
      );
      data = SharedUserData.fromJson(response.data);

      if (data.code == 200) {
        return true;
      } else {
        return false;
      }
    } on DioError catch (err) {
      // http error
      if (kDebugMode) {
        print("submitLogin(): http error at: $err");
      }
      return false;
    } catch (err) {
      // unknown error
      if (kDebugMode) {
        print("submitLogin(): unknwon error at: $err");
      }
      return false;
    }
  }
}
