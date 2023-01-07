import 'package:attendanceappadmin/config/assets.dart';
import 'package:attendanceappadmin/shared/ui/widgets/widget_tabbed_page_wrapper.dart';
import 'package:attendanceappadmin/shared/utils/helper/helper_device.dart';
import 'package:attendanceappadmin/themes/color.dart';
import 'package:flutter/material.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

class PageTabHome extends StatefulWidget {
  const PageTabHome({super.key});

  @override
  State<StatefulWidget> createState() => _PageTabHome();
}

class _PageTabHome extends State<PageTabHome> {
  late String deviceId;

  @override
  void initState() {
    super.initState();

    deviceId = "";
    AppHelperDevice().getEncodedDeviceId().then((value) {
      setState(() {
        deviceId = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return WidgetTabbedPageWrapper(
      child: Container(
        color: AppColors.primary,
        child: Center(
          child: PrettyQr(
            image: const AssetImage(AppAssets.deviceId),
            // typeNumber: 3,
            size: 200,
            data: deviceId,
            errorCorrectLevel: QrErrorCorrectLevel.M,
            roundEdges: true,
          ),
        ),
      ),
    );
  }
}
