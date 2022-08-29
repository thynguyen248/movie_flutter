import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object?> get props => [toString()];
}

class LoadPopularMoviesEvent extends HomeEvent {
  const LoadPopularMoviesEvent();
}

class LoadMorePopularMoviesEvent extends HomeEvent {
  const LoadMorePopularMoviesEvent();
}

class LoadUpcomingMoviesEvent extends HomeEvent {
  const LoadUpcomingMoviesEvent();
}

class LoadMoreUpcomingMoviesEvent extends HomeEvent {
  const LoadMoreUpcomingMoviesEvent();
}
