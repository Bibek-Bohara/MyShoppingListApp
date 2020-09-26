import 'dart:convert';

import 'package:MyShoppingList/common/http/api_provider.dart';
import 'package:meta/meta.dart';

class AuthApiProvider {
  final String baseUrl;
  ApiProvider apiProvider;
  AuthApiProvider({@required this.baseUrl, @required this.apiProvider})
      : assert(apiProvider != null);

  Future<Map<String, dynamic>> signIn(String email, String password) async {
    try {
      return await apiProvider.post('$baseUrl/auth/local', {'identifier': email, 'password': password});
    } on Error catch (e) {
      throw Exception('Failed to load post ' + e.toString());
    }
  }

  Future<Map<String, dynamic>> signUp(String email, String password, String name, String firstName, String lastName, String phone) async {
    try {
      return await apiProvider.post('$baseUrl/auth/local/register',
          {'email': email, 'password': password, 'username': name, 'firstname': firstName, 'lastname': lastName, 'phone': phone});
    } on Error catch (e) {
      throw Exception('Failed to load post ' + e.toString());
    }
  }
}
