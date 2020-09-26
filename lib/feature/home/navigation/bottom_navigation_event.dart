part of 'bottom_navigation_bloc.dart';

@immutable
abstract class BottomNavigationEvent extends Equatable {
  const BottomNavigationEvent();
  @override
  List<Object> get props => [];
}

class AppStarted extends BottomNavigationEvent {}


class PageTapped extends BottomNavigationEvent {
  final int index;

  const PageTapped({@required this.index});

  @override
  String toString() => 'PageTapped: $index';
}



class SearchButtonPressed extends BottomNavigationEvent {
  final String query;

  const SearchButtonPressed({
    @required this.query,
  });

  @override
  List<Object> get props => [query];
}
