
class AuthDto {
  /// Convert login request to JSON
  static Map<String, dynamic> loginToJson(String email, String password) {
    return {
      'email_address': email,
      'password': password,
    };
  }

  /// Convert register request to JSON
  static Map<String, dynamic> registerToJson(String name, String email, String password) {
    return {
      'full_name': name,
      'email_address': email,
      'password': password,
      'password_confirmation':password
    };
  }


}