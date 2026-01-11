class ApiEndPoints {
  static const String baseUrl = 'https://elegant-many-oyster.ngrok-free.app';
  static const String login = '$baseUrl/api/auth/login';
  static const String busSchedules = '$baseUrl/api/bus_schedules/by_route';
  static const String register = '$baseUrl/api/registrations';
  static const String otpVerify = '$baseUrl/api/auth/me';
}