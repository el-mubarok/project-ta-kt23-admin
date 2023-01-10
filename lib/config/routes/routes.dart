import 'package:attendanceappadmin/config/routes/route_names.dart';
import 'package:attendanceappadmin/modules/non_tabbed_modules/account_module/screens/account_screen.dart';
import 'package:attendanceappadmin/modules/non_tabbed_modules/home_module/screens/home_screen.dart';
import 'package:attendanceappadmin/modules/non_tabbed_modules/login_module/screens/login_screen.dart';
import 'package:attendanceappadmin/modules/non_tabbed_modules/reset_password_module/screens/reset_password_screen.dart';
import 'package:attendanceappadmin/modules/non_tabbed_modules/session_module/screens/session_screen.dart';
import 'package:attendanceappadmin/modules/tabs/tabs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Routes {
  static Route<dynamic> generatedRoute(RouteSettings settings) {
    switch (settings.name) {
      //
      case NamedRoute.tab:
        return MaterialPageRoute(
          builder: (_) => const Tabs(),
        );

      case NamedRoute.pageLogin:
        return MaterialPageRoute(
          builder: (_) => const ModuleLogin(),
        );

      case NamedRoute.pageHome:
        return MaterialPageRoute(
          builder: (_) => const ModuleHome(),
        );

      case NamedRoute.pageAccount:
        return MaterialPageRoute(
          builder: (_) => const ModuleAccount(),
        );

      case NamedRoute.pageResetPassword:
        return MaterialPageRoute(
          builder: (_) => const ModuleResetPassword(),
        );

      case NamedRoute.pageSession:
        var arg = (settings.arguments as dynamic);
        return MaterialPageRoute(
          builder: (_) => ModuleSession(
            qrCode: arg['qrCode'],
            isHomeAttendance: arg['is_home_attendance'] ?? false,
            start: arg['start_date'],
            end: arg['end_date'],
            endSession: arg['end_date_session'],
          ),
        );

      // default page not found
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(
              child: Text('Wrong way.'),
            ),
          ),
        );
    }
  }
}
