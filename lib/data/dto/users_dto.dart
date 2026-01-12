import 'package:citym/models/users.dart';

class UserDto {
  /// Convert API response to Users model
  static Users fromJson(Map<String, dynamic> json) {
    return Users(
      id: json['id'].toString(),
      email: json['email_address'] as String,
      fullname: json['full_name'] as String,
      credit: json['credit'] as String? ?? '0.0',
      avatarImage: json['avatar_image'] as String?,
    );
  }
}