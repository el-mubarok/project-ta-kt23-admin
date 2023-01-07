class AppApiRoutes {
  static const baseEndpoint = 'http://192.168.43.21';
  // static const baseEndpoint = 'https://squidwarestudio.com/@dev/kt23/api.php';
  static const apiEndpoint =
      '$baseEndpoint/projects/TA/attendence_app/api.php?';
  // static const apiEndpoint = '$baseEndpoint/api.php?';
  //
  // Generate session
  // POST
  // params: date, admin_id
  static const pathGenerateSession = '${apiEndpoint}generate=true';
}
