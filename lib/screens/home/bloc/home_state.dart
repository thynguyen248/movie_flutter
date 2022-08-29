import 'package:equatable/equatable.dart';
import 'package:movie_flutter/model/movie_model.dart';

abstract class HomeState extends Equatable {
  final List<MovieModel> upcomingMovies;
  final List<MovieModel> popularMovies;
  final bool hasMoreUpcomingMovies;
  final bool hasMorePopularMovies;

  const HomeState(this.upcomingMovies, this.popularMovies,
      this.hasMoreUpcomingMovies, this.hasMorePopularMovies);

  @override
  List<Object?> get props => [
        popularMovies.map((e) => e.movieId).toList(),
        upcomingMovies.map((e) => e.movieId).toList(),
        hasMoreUpcomingMovies,
        hasMorePopularMovies
      ];
}

class HomeInitialState extends HomeState {
  const HomeInitialState() : super(const [], const [], false, false);
}

class HomeLoadingState extends HomeState {
  const HomeLoadingState() : super(const [], const [], false, false);
}

class HomeErrorState extends HomeState {
  final String errorMessage;
  const HomeErrorState({
    required this.errorMessage,
  }) : super(const [], const [], false, false);
}

class HomeSuccessLoadDataState extends HomeState {
  const HomeSuccessLoadDataState(super.upcomingMovies, super.popularMovies,
      super.hasMoreUpcomingMovies, super.hasMorePopularMovies);
}
