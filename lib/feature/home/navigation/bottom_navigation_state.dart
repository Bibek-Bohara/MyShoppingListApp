part of 'bottom_navigation_bloc.dart';

@immutable
abstract class BottomNavigationState extends Equatable {
  const BottomNavigationState();
  @override
  List<Object> get props => [];
}
class PageLoading extends BottomNavigationState {}

class CurrentIndexChanged extends BottomNavigationState {
  final int currentIndex;

  const CurrentIndexChanged({this.currentIndex});

  @override
  List<Object> get props => [currentIndex];

  @override
  String toString() => 'current index changed { current: ${currentIndex} }';
}

class UnauthorizedError extends BottomNavigationState {}
