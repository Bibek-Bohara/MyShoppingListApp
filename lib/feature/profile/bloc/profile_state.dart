part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileEdit extends ProfileState {}

class ProfileSuccess extends ProfileState {}

class ProfileError extends ProfileState {
  final String error;

  ProfileError(this.error);

  @override
  List<Object> get props => [error];
}

class ProfileLoaded extends ProfileState {
  final Profile profile;

  const ProfileLoaded({this.profile});

  @override
  List<Object> get props => [profile];

  @override
  String toString() => 'PostLoaded { profile: $profile }';
}
