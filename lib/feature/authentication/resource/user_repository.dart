import 'dart:async';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserRepository {
  static const String _token = 'token';
  static const String _name = 'name';
  static const String _email = 'email';

  Future<void> deleteAll() async {
    const FlutterSecureStorage storage = FlutterSecureStorage();
    try {
      await storage.deleteAll();
      return true;
    } on Exception catch (e) {
      print('custom exception is been obtained');
    }
    return false;
  }

  Future<void> deleteToken() async {
    const FlutterSecureStorage storage = FlutterSecureStorage();
    try {
      await storage.delete(key: _token);
      return true;
    } on Exception catch (e) {
      print('custom exception is been obtained');
    }
    return false;
  }

  Future<void> persistToken(String token) async {
    const FlutterSecureStorage storage = FlutterSecureStorage();
    try {
      await storage.write(key: _token, value: token);
      return true;
    } on Exception catch (e) {
      print('custom exception is been obtained');
    }
    return false;
  }

  Future<void> persistUser(String email, String name) async{
    const FlutterSecureStorage storage = FlutterSecureStorage();
    try {
      await storage.write(key: _name, value: name);
      await storage.write(key: _email, value: email);
      return true;
    } on Exception catch (e) {
      print('custom exception is been obtained');
    }
    return false;
  }

  Future<String> getName(String email, String name) async{
    const FlutterSecureStorage storage = FlutterSecureStorage();
    try {
     return await storage.read(key: _name);
    } on Exception catch (e) {
      print('custom exception is been obtained');
    }
    return "";
  }

  Future<String> getEmail(String email, String name) async{
    const FlutterSecureStorage storage = FlutterSecureStorage();
    try {
      return await storage.read(key: _email);
    } on Exception catch (e) {
      print('custom exception is been obtained');
    }
    return "";
  }

  Future<bool> hasToken() async {
    const FlutterSecureStorage storage = FlutterSecureStorage();
    try {
      String token = await storage.read(key: _token);
      if (token != null) {
        return true;
      }
    } on Exception catch (e) {
      print('custom exception is been obtained');
    }
    return false;
  }

  Future<String> fetchToken() async {
    const FlutterSecureStorage storage = FlutterSecureStorage();
    String token = '';
    try {
      token = await storage.read(key: _token);
    } on Exception catch (e) {
      print('custom exception is been obtained');
    }
    return token;
  }
}