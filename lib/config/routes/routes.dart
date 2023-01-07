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
        return CupertinoPageRoute(
          builder: (_) => const Tabs(),
        );

      case NamedRoute.pageHome:
        return CupertinoPageRoute(
          builder: (_) => const ModuleHome(),
        );

      case NamedRoute.pageSession:
        var arg = (settings.arguments as dynamic);
        return CupertinoPageRoute(
          builder: (_) => ModuleSession(
            qrCode: arg['qrCode'],
          ),
        );

      // default page not found
      default:
        return CupertinoPageRoute(
          builder: (_) => const Scaffold(
            body: Center(
              child: Text('Wrong way.'),
            ),
          ),
        );
    }
  }
}
