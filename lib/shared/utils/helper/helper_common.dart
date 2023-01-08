import 'package:attendanceappadmin/shared/ui/widgets/widget_dialog.dart';
import 'package:attendanceappadmin/shared/utils/helper/helper_device.dart';
import 'package:attendanceappadmin/shared/utils/utils_global.dart';
import 'package:attendanceappadmin/themes/color.dart';
import 'package:flutter/material.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

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

  showDeviceId(BuildContext context) async {
    String deviceId = "";

    AppHelperDevice().getEncodedDeviceId().then((value) {
      deviceId = value;
      print(deviceId);
    });
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.transparent,
      builder: (BuildContext context) {
        return FractionallySizedBox(
          heightFactor: 0.7,
          child: Container(
            decoration: const BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Center(
              child: PrettyQr(
                size: 200,
                data: deviceId,
                errorCorrectLevel: QrErrorCorrectLevel.M,
                roundEdges: true,
              ),
            ),
          ),
        );
      },
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
