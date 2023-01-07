import 'package:attendanceappadmin/shared/models/shared_attendance_changed_model.dart';
import 'package:flutter/material.dart';

class AppUtilsGlobal {
  static final AppUtilsGlobal instance = AppUtilsGlobal.internal();
  final GlobalKey<ScaffoldMessengerState> snackbarKey =
      GlobalKey<ScaffoldMessengerState>();

  factory AppUtilsGlobal() => instance;

  AppUtilsGlobal.internal();

  final darkMode = ValueNotifier<bool>(false);
  final attendanceChanged = ValueNotifier<SharedAttendanceChanged?>(null);
}
