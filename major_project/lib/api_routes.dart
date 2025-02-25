class ApiRoutes {
  static const String serverUrl = 'http://localhost:3300';

  // Auth routes
  static const String loginRoute = '$serverUrl/api/v1/user/send-otp';
  static const String registerRoute = '$serverUrl/api/v1/user/register';
  static const String verifyOtpRoute = '$serverUrl/api/v1/user/verify';
  static const String resendOtpRoute = '$serverUrl/api/v1/user/resend-otp';
}
