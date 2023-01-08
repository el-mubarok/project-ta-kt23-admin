import 'package:attendanceappadmin/config/routes/route_names.dart';
import 'package:attendanceappadmin/modules/non_tabbed_modules/home_module/screens/home_screen.dart';
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

      case NamedRoute.pageHome:
        return MaterialPageRoute(
          builder: (_) => const ModuleHome(),
        );

      case NamedRoute.pageSession:
        var arg = (settings.arguments as dynamic);
        return MaterialPageRoute(
          builder: (_) => ModuleSession(
            qrCode: arg['qrCode'],
            start: arg['start_date'],
            end: arg['end_date'],
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
