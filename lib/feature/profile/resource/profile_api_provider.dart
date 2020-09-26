
import 'package:MyShoppingList/common/http/api_provider.dart';
import 'package:MyShoppingList/feature/authentication/resource/user_repository.dart';
import 'package:MyShoppingList/feature/profile/model/profile.dart';
import 'package:meta/meta.dart';

class ProfileApiProvider {
    ProfileApiProvider(
      {@required this.baseUrl,
      @required this.apiProvider,
      @required this.userRepository})
      : assert(apiProvider != null),
        assert(userRepository != null);

  final ApiProvider apiProvider;
  final UserRepository userRepository;
  final String baseUrl;

  Future<dynamic> fetchProfile() async {
    var token = await this.userRepository.fetchToken();
    return apiProvider.get('$baseUrl/users/me', token: token);
  }

  Future<Map<String, dynamic>> saveProfile(Profile profile) async {
    var token = await this.userRepository.fetchToken();
    return apiProvider.put('$baseUrl/users/${profile.id.toString()}',profile.toJson(), token: token);
  }
}