import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_flutter/model/movie_response_model.dart';
import 'package:movie_flutter/repository/repository.dart';
import 'package:movie_flutter/screens/home/bloc/home_event.dart';
import 'package:movie_flutter/screens/home/bloc/home_state.dart';

import '../../../model/movie_model.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final Repository _repository;
  int _currentPage = 0;
  bool _hasMoreData = false;
  List<MovieModel> _popularMovies = [];

  final int _maxPage = 5;

  HomeBloc(this._repository) : super(const HomeInitialState()) {
    on<LoadPopularMoviesEvent>((_onFetchPopularMoviesEvent));
    on<LoadMorePopularMoviesEvent>((_onLoadMorePopularMoviesEvent));
  }

  void _onFetchPopularMoviesEvent(
    LoadPopularMoviesEvent event,
    Emitter<HomeState> emitter,
  ) async {
    emitter(const HomeLoadingState());
    MovieResponseModel movieResponseModel =
        await _repository.getPopularMovies();
    _currentPage = movieResponseModel.currentPage;
    _popularMovies += movieResponseModel.movies;
    _hasMoreData = _currentPage < movieResponseModel.totalPages;
    emitter(HomeSuccessFetchPopularMoviesState(
        movies: _popularMovies, hasMoreData: _hasMoreData));
  }

  void _onLoadMorePopularMoviesEvent(
    LoadMorePopularMoviesEvent event,
    Emitter<HomeState> emitter,
  ) async {
    if (!_hasMoreData) {
      emitter(HomeSuccessFetchPopularMoviesState(
          movies: _popularMovies, hasMoreData: _hasMoreData));
      return;
    }
    MovieResponseModel movieResponseModel =
        await _repository.getPopularMovies(page: _currentPage + 1);
    _currentPage = movieResponseModel.currentPage;
    _popularMovies += movieResponseModel.movies;
    _hasMoreData = _currentPage < _maxPage;
    emitter(HomeSuccessFetchPopularMoviesState(
        movies: _popularMovies, hasMoreData: _hasMoreData));
  }
}
