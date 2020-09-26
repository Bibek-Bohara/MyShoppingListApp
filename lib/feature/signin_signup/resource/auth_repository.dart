import 'package:MyShoppingList/common/constant/env.dart';
import 'package:MyShoppingList/common/http/api_provider.dart';
import 'package:MyShoppingList/common/http/response.dart';
import 'package:MyShoppingList/common/util/internet_check.dart';
import 'package:MyShoppingList/feature/signin_signup/resource/auth_api_provider.dart';
import 'package:meta/meta.dart';

class AuthRepository {
  final ApiProvider apiProvider;
  AuthApiProvider authApiProvider;
  InternetCheck internetCheck;
  Env env;

  AuthRepository(
      {@required this.apiProvider,
      @required this.internetCheck,
      @required this.env}) {
    authApiProvider =
        AuthApiProvider(baseUrl: env.baseUrl, apiProvider: apiProvider);
  }

  Future<DataResponse<String>> signIn(String email, String password) async {
    final response = await authApiProvider.signIn(email, password);
    if (response == null) {
      return DataResponse.connectivityError();
    }

    if (!response.containsKey('error')) {
      final String token = response['jwt'];
      apiProvider.setToken(token);
      return DataResponse.success(token);
    } else {
      return DataResponse.error('Error');
    }
  }

  Future<Map<String, dynamic>> signUp(
    String email, String password, String username, String firstName, String lastName, String phone){
      return authApiProvider.signUp(email, password, username, firstName, lastName, phone );
    }
}
