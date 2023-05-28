import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:getx_gpt_example/domain/core/constants/storage.constants.dart';

import '../../infrastructure/dal/services/user/auth.service.dart';
import 'model/user.dart';

class UserRepository {
  final _authService = AuthService();
  final _storage = const FlutterSecureStorage();

  ///function signin google
  Future<void> signInWithGoogle() async {
    try {
      ///do sign in with google
      final user = await _authService.signInWithGoogle();
      
      /// store user result to local storage;
      await _storage.write(
        key: StorageConstants.user,
        value: jsonEncode(
          User.toJson(user),
        ),
      );

    } catch (e) {
      throw 'error';
    }
  }
  ///sign out google
  Future<void>signOutGoogle() async{
    ///do signout
    await _authService.signOutGoogle();
    ///clear all local data
    await _storage.deleteAll();
  }

  /// check if user is signIn
  Future<bool> isSignIn() async {
    try {
      final result = await _storage.read(key: StorageConstants.user);
      User user = User.fromJson(jsonDecode(result!));
      if (user.accToken!.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  ///get local user info
  Future<User> getUserInfo()async{
    try{
      final result = await _storage.read(key: StorageConstants.user);
      User user = User.fromJson(jsonDecode(result!));
      return user;
    }catch(e){
      throw 'error';
    }


  }
}
