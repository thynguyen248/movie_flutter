import 'dart:math';

import 'package:bloc_concurrency/bloc_concurrency.dart';
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
    on<LoadPopularMoviesEvent>((_onLoadPopularMoviesEvent),
        transformer: restartable());
    on<LoadUpcomingMoviesEvent>((_onLoadUpcomingMoviesEvent),
        transformer: restartable());
    on<LoadMorePopularMoviesEvent>((_onLoadMorePopularMoviesEvent),
        transformer: restartable());
    on<LoadMoreUpcomingMoviesEvent>((_onLoadMoreUpcomingMoviesEvent),
        transformer: restartable());
  }

  void _onLoadPopularMoviesEvent(
    LoadPopularMoviesEvent event,
    Emitter<HomeState> emit,
  ) async {
    if (state is HomeInitialState) {
      emit(const HomeLoadingState());
    }
    try {
      MovieResponseModel movieResponseModel =
          await _repository.getPopularMovies();
      _currentPopularMoviesPage = movieResponseModel.currentPage;
      _popularMovies += movieResponseModel.movies;
      _hasMorePopularMovies = _currentPopularMoviesPage <
          min(movieResponseModel.totalPages, _maxPage);
      emit(HomeSuccessLoadDataState(_upcomingMovies, _popularMovies,
          _hasMoreUpcomingMovies, _hasMorePopularMovies));
    } catch (e) {
      emit(HomeErrorState(errorMessage: e.toString()));
    }
  }

  void _onLoadMorePopularMoviesEvent(
    LoadMorePopularMoviesEvent event,
    Emitter<HomeState> emit,
  ) async {
    if (!_hasMorePopularMovies) {
      return;
    }
    try {
      MovieResponseModel movieResponseModel = await _repository
          .getPopularMovies(page: _currentPopularMoviesPage + 1);
      _currentPopularMoviesPage = movieResponseModel.currentPage;
      _popularMovies += movieResponseModel.movies;
      _hasMorePopularMovies = _currentPopularMoviesPage <
          min(movieResponseModel.totalPages, _maxPage);
      emit(HomeSuccessLoadDataState(_upcomingMovies, _popularMovies,
          _hasMoreUpcomingMovies, _hasMorePopularMovies));
    } catch (e) {
      emit(HomeErrorState(errorMessage: e.toString()));
    }
  }

  void _onLoadUpcomingMoviesEvent(
    LoadUpcomingMoviesEvent event,
    Emitter<HomeState> emit,
  ) async {
    if (state is HomeInitialState) {
      emit(const HomeLoadingState());
    }
    try {
      MovieResponseModel movieResponseModel =
          await _repository.getUpcomingMovies();
      _currentUpcomingMoviesPage = movieResponseModel.currentPage;
      _upcomingMovies += movieResponseModel.movies;
      _hasMoreUpcomingMovies = _currentUpcomingMoviesPage <
          min(movieResponseModel.totalPages, _maxPage);
      emit(HomeSuccessLoadDataState(_upcomingMovies, _popularMovies,
          _hasMoreUpcomingMovies, _hasMorePopularMovies));
    } catch (e) {
      emit(HomeErrorState(errorMessage: e.toString()));
    }
  }

  void _onLoadMoreUpcomingMoviesEvent(
    LoadMoreUpcomingMoviesEvent event,
    Emitter<HomeState> emit,
  ) async {
    if (!_hasMoreUpcomingMovies) {
      return;
    }
    try {
      MovieResponseModel movieResponseModel = await _repository
          .getUpcomingMovies(page: _currentUpcomingMoviesPage + 1);
      _currentUpcomingMoviesPage = movieResponseModel.currentPage;
      _upcomingMovies += movieResponseModel.movies;
      _hasMoreUpcomingMovies = _currentUpcomingMoviesPage <
          min(movieResponseModel.totalPages, _maxPage);
      emit(HomeSuccessLoadDataState(_upcomingMovies, _popularMovies,
          _hasMoreUpcomingMovies, _hasMorePopularMovies));
    } catch (e) {
      emit(HomeErrorState(errorMessage: e.toString()));
    }
  }

  int listItemCount() =>
      _popularMovies.length +
      (_hasMorePopularMovies ? 1 : 0) +
      (_upcomingMovies.isNotEmpty ? 1 : 0);
}
