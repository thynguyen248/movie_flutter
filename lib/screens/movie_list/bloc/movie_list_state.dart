import 'package:equatable/equatable.dart';
import 'package:movie_flutter/model/movie_model.dart';

abstract class MovieListState extends Equatable {
  final List<MovieModel> upcomingMovies;
  final List<MovieModel> popularMovies;
  final bool hasMoreUpcomingMovies;
  final bool hasMorePopularMovies;

  const MovieListState(this.upcomingMovies, this.popularMovies,
      this.hasMoreUpcomingMovies, this.hasMorePopularMovies);

  @override
  List<Object?> get props => [
        popularMovies.map((e) => e.movieId).toList(),
        upcomingMovies.map((e) => e.movieId).toList(),
        hasMoreUpcomingMovies,
        hasMorePopularMovies
      ];
}

class HomeInitialState extends MovieListState {
  const HomeInitialState() : super(const [], const [], false, false);
}

class HomeLoadingState extends MovieListState {
  const HomeLoadingState() : super(const [], const [], false, false);
}

class HomeErrorState extends MovieListState {
  final String errorMessage;
  const HomeErrorState({
    required this.errorMessage,
  }) : super(const [], const [], false, false);
}

class HomeSuccessLoadDataState extends MovieListState {
  const HomeSuccessLoadDataState(super.upcomingMovies, super.popularMovies,
      super.hasMoreUpcomingMovies, super.hasMorePopularMovies);
}
