part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class FetchProfile extends ProfileEvent {}

class EditProfile extends ProfileEvent {}

class CancelButtonPressed extends ProfileEvent {}

class SaveButtonPressed extends ProfileEvent {
  final Profile profile;

  const SaveButtonPressed({@required this.profile});

  @override
  List<Object> get props => [profile];

  @override
  String toString() =>
      'SaveButtonPressed ${profile.toJson()}';
}
