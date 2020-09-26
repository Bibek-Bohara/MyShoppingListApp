import 'dart:async';

import 'package:MyShoppingList/common/http/response.dart';
import 'package:MyShoppingList/feature/profile/model/profile.dart';
import 'package:MyShoppingList/feature/profile/resource/profile_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileRepository profileRepository;

  ProfileBloc({@required this.profileRepository})
      : assert(profileRepository != null),
        super(ProfileInitial());

  @override
  Stream<ProfileState> mapEventToState(
    ProfileEvent event,
  ) async* {
    final ProfileState currentState = state;
    if (event is FetchProfile) {
      try {
        if (currentState is ProfileInitial || currentState is ProfileLoaded) {
          yield ProfileLoading();
          final response = await profileRepository.fetchProfile();
          if (response.status == Status.ConnectivityError) {
            yield ProfileError("Network Error");
          }
          if (response.status == Status.Success) {
            yield ProfileLoaded(profile: response.data);
          }

          if (response.status == Status.Error) {
            yield ProfileError(response.message);
          }
        }
      } catch (e) {
        print(e);
        yield ProfileError("Error Occurred");
      }
    }

    if (event is EditProfile) {
      yield ProfileEdit();
    }

    if (event is CancelButtonPressed) {
      yield ProfileInitial();
    }

    if (event is SaveButtonPressed) {
      yield ProfileLoaded();
      final _profile = await profileRepository.saveProfile(event.profile);
      if (_profile.data != null) {
        ProfileSuccess();
      } else {
        ProfileError(_profile.message);
      }
    }
  }
}
