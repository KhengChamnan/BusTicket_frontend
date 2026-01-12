class ApiEndPoints {
  static const String baseUrl = 'https://elegant-many-oyster.ngrok-free.app';
  static const String login = '$baseUrl/api/auth/login';
  static const String busSchedules = '$baseUrl/api/bus_schedules/by_route';
  static const String register = '$baseUrl/api/registrations';
  static const String userProfile = '$baseUrl/api/auth/me';
  static const String busBooking='$baseUrl/api/bookings';
  static const String payment='$baseUrl/api/payments';
}