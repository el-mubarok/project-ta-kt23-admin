class AppApiRoutes {
  static const baseEndpoint = 'http://192.168.43.21';
  // static const baseEndpoint = 'https://squidwarestudio.com/@dev/kt23/api.php';
  static const apiEndpoint =
      '$baseEndpoint/projects/TA/attendence_app/api.php?';
  // static const apiEndpoint = '$baseEndpoint/api.php?';
  //
  // Login
  // POST
  // params: username, password, device_id, role, messaging_id
  static const pathLogin = '${apiEndpoint}login=true';
  // Generate session
  // POST
  // params: date, admin_id
  static const pathGenerateSession = '${apiEndpoint}generate=true';
  // User detail
  // GET
  // params: user_id
  static const pathUserDetail = '${apiEndpoint}user_detail=true';
  // Reset user password
  // POST
  // params: user_id, password, device_id
  static const pathResetPassword = '${apiEndpoint}reset_password=true';
  // List session history
  // GET
  // params: -
  static const pathHistorySession = '${apiEndpoint}session_history=true';
}
