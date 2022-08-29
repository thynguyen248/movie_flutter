import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();
}

class LoadPopularMoviesEvent extends HomeEvent {
  const LoadPopularMoviesEvent();

  @override
  List<Object?> get props => [];
}

class LoadMorePopularMoviesEvent extends HomeEvent {
  const LoadMorePopularMoviesEvent();

  @override
  List<Object?> get props => [];
}

class LoadUpcomingMoviesEvent extends HomeEvent {
  const LoadUpcomingMoviesEvent();

  @override
  List<Object?> get props => [];
}

class LoadMoreUpcomingMoviesEvent extends HomeEvent {
  const LoadMoreUpcomingMoviesEvent();

  @override
  List<Object?> get props => [];
}
