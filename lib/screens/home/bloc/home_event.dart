import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();
}

class LoadPopularMoviesEvent extends HomeEvent {
  @override
  List<Object?> get props => [];
}

class LoadMorePopularMoviesEvent extends HomeEvent {
  const LoadMorePopularMoviesEvent();

  @override
  List<Object?> get props => [];
}
