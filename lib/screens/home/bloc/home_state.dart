import 'package:equatable/equatable.dart';
import 'package:movie_flutter/model/movie_model.dart';

abstract class HomeState extends Equatable {
  final List<MovieModel> movies;
  const HomeState({required this.movies});

  @override
  List<Object?> get props => [movies.map((e) => e.movieId).toList()];
}

class HomeInitialState extends HomeState {
  const HomeInitialState() : super(movies: const []);
}

class HomeLoadingState extends HomeState {
  const HomeLoadingState() : super(movies: const []);
}

class HomeErrorFetchPopularMoviesState extends HomeState {
  final String errorMessage;
  const HomeErrorFetchPopularMoviesState({
    required this.errorMessage,
  }) : super(movies: const []);

  @override
  List<Object?> get props => [...super.props, errorMessage];
}

class HomeSuccessFetchPopularMoviesState extends HomeState {
  final bool hasMoreData;
  const HomeSuccessFetchPopularMoviesState(
      {required List<MovieModel> movies, required this.hasMoreData})
      : super(movies: movies);

  @override
  List<Object?> get props => [...super.props, hasMoreData];
}

class HomeLoadingMoreState extends HomeState {
  const HomeLoadingMoreState({
    required List<MovieModel> movies,
  }) : super(movies: movies);
}
