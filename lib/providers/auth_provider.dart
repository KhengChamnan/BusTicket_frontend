import 'package:citym/data/repository/rails/rails_auth_repository.dart';
import 'package:citym/providers/asyncvalue.dart';
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  final RailsAuthRepository _authRepository = RailsAuthRepository();

  AsyncValue<Map<String, dynamic>>? loginValue;
  AsyncValue<Map<String, dynamic>>? registerValue;

  String? _authToken;
  bool _isAuthenticated = false;

  bool get isAuthenticated => _isAuthenticated;

  String? get authToken => _authToken;

  Future<void> initializeAuth() async {
    final token = await _authRepository.getToken();
    if (token != null) {
      _authToken = token;
      _isAuthenticated = true;
      notifyListeners();
    }
  }

  Future<void> login(String email, String password) async {
    loginValue = AsyncValue.loading();
    notifyListeners();

    try {
      final result = await _authRepository.login(email, password);

      if (result['success']) {
        _authToken = await _authRepository.getToken();
        _isAuthenticated = true;
        loginValue = AsyncValue.success(result);
      } else {
        loginValue = AsyncValue.error(result['message']);
      }
    } catch (error) {
      loginValue = AsyncValue.error(error);
    }

    notifyListeners();
  }

  Future<void> register(
    String name,
    String email,
    String password,
  ) async {
    registerValue = AsyncValue.loading();
    notifyListeners();

    try {
      final result = await _authRepository.register(
        name,
        email,
        password
      );

      if (result['success']) {
        _authToken = await _authRepository.getToken();
        _isAuthenticated = true;
        registerValue = AsyncValue.success(result);
      } else {
        registerValue = AsyncValue.error(result['message']);
      }
    } catch (error) {
      registerValue = AsyncValue.error(error);
    }

    notifyListeners();
  }

  Future<void> logout() async {
    try {
      await _authRepository.logout();
    } finally {
      _authToken = null;
      _isAuthenticated = false;

      loginValue = null;
      registerValue = null;

      notifyListeners();
    }
  }

  void clearLoginValue() {
    loginValue = null;
    notifyListeners();
  }

  void clearRegisterValue() {
    registerValue = null;
    notifyListeners();
  }
}
