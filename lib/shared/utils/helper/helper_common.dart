import 'package:attendanceappadmin/shared/ui/widgets/widget_dialog.dart';
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

  showAlert({
    required BuildContext context,
    String? title,
    String? subtitle,
    String? content,
    VoidCallback? onTapOk,
    VoidCallback? onDismissed,
    bool okOnly = false,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return WidgetDialog(
          title: title,
          subtitle: subtitle,
          content: content,
          okOnly: okOnly,
          onOk: () {
            onTapOk!();
          },
        );
      },
    ).then((value) {
      onDismissed!();
    });
  }
}
