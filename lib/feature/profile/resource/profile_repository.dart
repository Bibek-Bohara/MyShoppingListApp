import 'package:MyShoppingList/common/constant/env.dart';
import 'package:MyShoppingList/common/http/api_provider.dart';
import 'package:MyShoppingList/common/http/response.dart';
import 'package:MyShoppingList/common/util/internet_check.dart';
import 'package:MyShoppingList/feature/authentication/resource/user_repository.dart';
import 'package:MyShoppingList/feature/profile/model/profile.dart';
import 'package:MyShoppingList/feature/profile/resource/profile_api_provider.dart';
import 'package:meta/meta.dart';

class ProfileRepository {
  ApiProvider apiProvider;
  ProfileApiProvider profileApiProvider;
  InternetCheck internetCheck;
  UserRepository userRepository;
  Env env;

  ProfileRepository(
      {@required this.env,
      @required this.apiProvider,
      @required this.internetCheck,
      @required this.userRepository}) {
    profileApiProvider = ProfileApiProvider(
        baseUrl: env.baseUrl,
        apiProvider: apiProvider,
        userRepository: userRepository);
  }

  Future<DataResponse<Profile>> fetchProfile() async {
    final response = await profileApiProvider.fetchProfile();

    if (response == null) {
      return DataResponse.connectivityError();
    }

    if (!response.containsKey('Error')) {
      print(response);
      final Profile _profile = Profile.fromJson(response as Map<String, dynamic>);
      return DataResponse.success(_profile);
    } else {
      return DataResponse.error("Error");
    }
  }

  Future<DataResponse<Profile>> saveProfile(Profile profile) async {
    final response = await profileApiProvider.saveProfile(profile);

    if (response == null) {
      return DataResponse.connectivityError();
    }

    if (!response.containsKey('Error')) {
      final Profile _profile = (response['data'])?.map((dynamic e) {
        return e == null ? null : Profile.fromJson(e as Map<String, dynamic>);
      });
      return DataResponse.success(_profile);
    } else {
      return DataResponse.error("Error");
    }
  }
}
