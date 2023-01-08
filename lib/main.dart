import 'package:attendanceappadmin/config/constants.dart';
import 'package:attendanceappadmin/config/routes/route_names.dart';
import 'package:attendanceappadmin/config/routes/routes.dart';
import 'package:attendanceappadmin/shared/models/shared_attendance_changed_model.dart';
import 'package:attendanceappadmin/shared/utils/utils_global.dart';
import 'package:attendanceappadmin/themes/color.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  const MyApp myApp = MyApp();

  runApp(myApp);
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _MyApp();
  }
}

class _MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<_MyApp> {
  AppUtilsGlobal appUtilsGlobal = AppUtilsGlobal();

  @override
  void initState() {
    super.initState();
    initMessaging();
  }

  Future<void> initMessaging() async {
    OneSignal.shared.setLogLevel(OSLogLevel.none, OSLogLevel.none);

    await OneSignal.shared.setAppId(AppConfigConstant.onesignalAppId);

    OneSignal.shared.setNotificationWillShowInForegroundHandler(
        (OSNotificationReceivedEvent event) {
      // Will be called whenever a notification is received in foreground
      // Display Notification, pass null param for not displaying the notification
      try {
        Map<String, dynamic>? additionalData =
            event.notification.additionalData;
        SharedAttendanceChanged? data = SharedAttendanceChanged.fromJson(
          additionalData ?? {},
        );

        appUtilsGlobal.attendanceChanged.value = data;
        print("WOWOOWOWOWO: $data");
      } catch (e) {
        print("error shared: $e");
      }
      event.complete(null);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: AppUtilsGlobal().snackbarKey,
      onGenerateRoute: Routes.generatedRoute,
      initialRoute: NamedRoute.pageHome,
      theme: ThemeData(
        fontFamily: 'Poppins',
        primaryColor: AppColors.primary,
        useMaterial3: true,
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: AppColors.secondary,
        ),
      ),
      darkTheme: ThemeData(
        fontFamily: 'Poppins',
        primaryColor: AppColors.primary,
        useMaterial3: true,
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: AppColors.secondary,
        ),
      ),
    );
  }
}
