import 'dart:convert';
import 'package:citym/data/dto/auth_dto.dart';
import 'package:citym/data/dto/users_dto.dart';
import 'package:citym/data/repository/abstract/auth_repository.dart';
import 'package:citym/models/users.dart';
import 'package:citym/network/api_constant.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class RailsAuthRepository extends AuthRepository {
  final _storage = const FlutterSecureStorage();
  static const String _tokenKey = 'auth_token';

  Future<String?> getToken() async {
    return await _storage.read(key: _tokenKey);
  }

  Future<void> saveToken(String token) async {
    await _storage.write(key: _tokenKey, value: token);
  }

  Future<void> deleteToken() async {
    await _storage.delete(key: _tokenKey);
  }

  @override
  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse(ApiEndPoints.login),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(AuthDto.loginToJson(email, password)),
      );

      final data = json.decode(response.body);

      if (response.statusCode == 200 && data['token'] != null) {
        await saveToken(data['token']);
        return {'success': true, 'data': data['user'], 'message': data['message']};
      }

      return {'success': false, 'message': data['error'] ?? data['message'] ?? 'Login failed'};
    } catch (e) {
      return {'success': false, 'message': 'Network error: ${e.toString()}'};
    }
  }

  @override
  Future<Map<String, dynamic>> register(String name, String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse(ApiEndPoints.register),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(AuthDto.registerToJson(name, email, password)),
      );

      final data = json.decode(response.body);

      if (response.statusCode == 201 && data['token'] != null) {
        await saveToken(data['token']);
        return {'success': true, 'data': data['user'], 'message': data['message']};
      }

      return {'success': false, 'message': data['error'] ?? data['message'] ?? 'Registration failed'};
    } catch (e) {
      return {'success': false, 'message': 'Network error: ${e.toString()}'};
    }
  }

  Future<Map<String, dynamic>> logout() async {
    await deleteToken();
    return {'success': true, 'message': 'Logged out successfully'};
  }

  @override
  Future<Users> getUserProfile() async {
    try {
      final token = await getToken();
      if (token == null) {
        throw Exception('No authentication token found');
      }

      final response = await http.get(
        Uri.parse(ApiEndPoints.userProfile),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
          'ngrok-skip-browser-warning': 'true',
        },
      );

      final data = json.decode(response.body);

      if (response.statusCode == 200 && data['user'] != null) {
        return UserDto.fromJson(data['user']);
      }

      throw Exception(data['error'] ?? data['message'] ?? 'Failed to fetch user profile');
    } catch (e) {
      throw Exception('Failed to get user profile: ${e.toString()}');
    }
  }
}