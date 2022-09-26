import 'package:equatable/equatable.dart';

abstract class MovieListEvent extends Equatable {
  const MovieListEvent();

  @override
  List<Object?> get props => [toString()];
}

class RefreshEvent extends MovieListEvent {
  const RefreshEvent();
}

class LoadPopularMoviesEvent extends MovieListEvent {
  const LoadPopularMoviesEvent();
}

class LoadMorePopularMoviesEvent extends MovieListEvent {
  const LoadMorePopularMoviesEvent();
}

class LoadUpcomingMoviesEvent extends MovieListEvent {
  const LoadUpcomingMoviesEvent();
}

class LoadMoreUpcomingMoviesEvent extends MovieListEvent {
  const LoadMoreUpcomingMoviesEvent();
}
