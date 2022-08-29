import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_flutter/model/movie_response_model.dart';
import 'package:movie_flutter/repository/repository.dart';
import 'package:movie_flutter/screens/home/bloc/home_event.dart';
import 'package:movie_flutter/screens/home/bloc/home_state.dart';

import '../../../model/movie_model.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final Repository _repository;
  int _currentPopularMoviesPage = 0;
  int _currentUpcomingMoviesPage = 0;
  bool _hasMoreUpcomingMovies = false;
  bool _hasMorePopularMovies = false;
  List<MovieModel> _popularMovies = [];
  List<MovieModel> _upcomingMovies = [];

  final int _maxPage = 5;

  HomeBloc(this._repository) : super(const HomeInitialState()) {
    on<LoadPopularMoviesEvent>((_onLoadPopularMoviesEvent));
    on<LoadUpcomingMoviesEvent>((_onLoadUpcomingMoviesEvent));
    on<LoadMorePopularMoviesEvent>((_onLoadMorePopularMoviesEvent));
    on<LoadMoreUpcomingMoviesEvent>((_onLoadMoreUpcomingMoviesEvent));
  }

  void _onLoadPopularMoviesEvent(
    LoadPopularMoviesEvent event,
    Emitter<HomeState> emitter,
  ) async {
    if (state is HomeInitialState) {
      emitter(const HomeLoadingState());
    }
    MovieResponseModel movieResponseModel =
        await _repository.getPopularMovies();
    _currentPopularMoviesPage = movieResponseModel.currentPage;
    _popularMovies += movieResponseModel.movies;
    _hasMorePopularMovies =
        _currentPopularMoviesPage < movieResponseModel.totalPages;
    emitter(HomeSuccessLoadDataState(_upcomingMovies, _popularMovies,
        _hasMoreUpcomingMovies, _hasMorePopularMovies));
  }

  void _onLoadMorePopularMoviesEvent(
    LoadMorePopularMoviesEvent event,
    Emitter<HomeState> emitter,
  ) async {
    if (!_hasMorePopularMovies) {
      emitter(HomeSuccessLoadDataState(_upcomingMovies, _popularMovies,
          _hasMoreUpcomingMovies, _hasMorePopularMovies));
      return;
    }
    MovieResponseModel movieResponseModel =
        await _repository.getPopularMovies(page: _currentPopularMoviesPage + 1);
    _currentPopularMoviesPage = movieResponseModel.currentPage;
    _popularMovies += movieResponseModel.movies;
    _hasMorePopularMovies = _currentPopularMoviesPage < _maxPage;
    emitter(HomeSuccessLoadDataState(_upcomingMovies, _popularMovies,
        _hasMoreUpcomingMovies, _hasMorePopularMovies));
  }

  void _onLoadUpcomingMoviesEvent(
    LoadUpcomingMoviesEvent event,
    Emitter<HomeState> emitter,
  ) async {
    if (state is HomeInitialState) {
      emitter(const HomeLoadingState());
    }
    MovieResponseModel movieResponseModel =
        await _repository.getUpcomingMovies();
    _currentUpcomingMoviesPage = movieResponseModel.currentPage;
    _upcomingMovies += movieResponseModel.movies;
    _hasMoreUpcomingMovies =
        _currentUpcomingMoviesPage < movieResponseModel.totalPages;
    emitter(HomeSuccessLoadDataState(_upcomingMovies, _popularMovies,
        _hasMoreUpcomingMovies, _hasMorePopularMovies));
  }

  void _onLoadMoreUpcomingMoviesEvent(
    LoadMoreUpcomingMoviesEvent event,
    Emitter<HomeState> emitter,
  ) async {
    if (!_hasMoreUpcomingMovies) {
      emitter(HomeSuccessLoadDataState(_upcomingMovies, _popularMovies,
          _hasMoreUpcomingMovies, _hasMorePopularMovies));
      return;
    }
    MovieResponseModel movieResponseModel = await _repository.getUpcomingMovies(
        page: _currentUpcomingMoviesPage + 1);
    _currentUpcomingMoviesPage = movieResponseModel.currentPage;
    _upcomingMovies += movieResponseModel.movies;
    _hasMoreUpcomingMovies = _currentUpcomingMoviesPage < _maxPage;
    emitter(HomeSuccessLoadDataState(_upcomingMovies, _popularMovies,
        _hasMoreUpcomingMovies, _hasMorePopularMovies));
  }

  int listItemCount() =>
      _popularMovies.length +
      (_hasMorePopularMovies ? 1 : 0) +
      (_upcomingMovies.isNotEmpty ? 1 : 0);
}
