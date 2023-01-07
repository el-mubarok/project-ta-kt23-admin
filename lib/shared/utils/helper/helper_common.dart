import 'package:attendanceappadmin/shared/utils/utils_global.dart';
import 'package:flutter/material.dart';

class AppHelperCommon {
  showSnackBar(
    BuildContext context,
    String message, [
    int duration = 4,
  ]) {
    // print(AppUtilsGlobal().snackbarKey.currentState);
    // return true;
    // close all active snackbar
    AppUtilsGlobal().snackbarKey.currentState?.clearSnackBars();
    //
    final snackBarContent = SnackBar(
      content: Text(message),
      duration: Duration(seconds: duration),
    );
    AppUtilsGlobal().snackbarKey.currentState?.showSnackBar(
          snackBarContent,
        );
  }
}
