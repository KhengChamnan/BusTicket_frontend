import 'package:citym/data/repository/abstract/auth_repository.dart';
import 'package:citym/data/repository/rails/rails_auth_repository.dart';
import 'package:citym/models/users.dart';
import 'package:flutter/material.dart';
import 'package:citym/providers/asyncvalue.dart';

class UserProfileProvider extends ChangeNotifier {
  final AuthRepository _authRepository = RailsAuthRepository();
  
  AsyncValue<Users>? userProfileValue;

  Future<Users?> getUserProfile() async {
    userProfileValue = AsyncValue.loading();
    notifyListeners();

    try {
      final results = await Future.wait([
        _authRepository.getUserProfile(),
        Future.delayed(const Duration(seconds: 1)),
      ]);

      final userProfile = results[0] as Users;

      userProfileValue = AsyncValue.success(userProfile);
      notifyListeners();
      return userProfile;
    } catch (error) {
      userProfileValue = AsyncValue.error(error);
      notifyListeners();
      return null;
    }
  }

  void clearProfile() {
    userProfileValue = null;
    notifyListeners();
  }
}
