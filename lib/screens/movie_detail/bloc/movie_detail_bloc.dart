import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:movie_flutter/model/movie_detail_model.dart';

import '../../../repository/repository.dart';
import 'movie_detail_event.dart';
import 'movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  final Repository _repository;
  final int _movieId;
  MovieDetailModel? _movieDetailModel;

  MovieDetailBloc(this._repository, this._movieId)
      : super(const MovieDetailInitialState()) {
    on<GetMovieDetailEvent>(_onGetMovieDetailEvent, transformer: restartable());
    on<VideoLoadedEvent>(_onVideoLoadedEvent);
  }

  void _onGetMovieDetailEvent(
      GetMovieDetailEvent event, Emitter<MovieDetailState> emit) async {
    emit(const MovieDetailLoadingState());
    try {
      MovieDetailModel movieDetailModel =
          await _repository.getMovieDetail(movieId: _movieId);
      _movieDetailModel = movieDetailModel;
      emit(MovieDetailLoadedState(
          movieDetailModel: movieDetailModel, videoLoaded: false));
    } catch (e) {
      emit(MovieDetailErrorState(errorMessage: e.toString()));
    }
  }

  void _onVideoLoadedEvent(
      VideoLoadedEvent event, Emitter<MovieDetailState> emit) async {
    if (_movieDetailModel != null) {
      emit(MovieDetailLoadedState(
          movieDetailModel: _movieDetailModel!, videoLoaded: true));
    }
  }
}
