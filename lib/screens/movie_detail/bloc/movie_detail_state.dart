import 'package:equatable/equatable.dart';
import 'package:movie_flutter/model/movie_detail_model.dart';

abstract class MovieDetailState extends Equatable {
  const MovieDetailState();

  @override
  List<Object?> get props => [];
}

class MovieDetailInitialState extends MovieDetailState {
  const MovieDetailInitialState();
}

class MovieDetailLoadingState extends MovieDetailState {
  const MovieDetailLoadingState();
}

class MovieDetailErrorState extends MovieDetailState {
  final String errorMessage;
  const MovieDetailErrorState({
    required this.errorMessage,
  });

  @override
  List<Object?> get props => [...super.props, errorMessage];
}

class MovieDetailLoadedState extends MovieDetailState {
  final MovieDetailModel movieDetailModel;
  final bool videoLoaded;
  const MovieDetailLoadedState(
      {required this.movieDetailModel, required this.videoLoaded});

  String videoThumbnailUrl() =>
      movieDetailModel.videos.results.first.thumbnailUrl();

  @override
  List<Object?> get props => [...super.props, videoLoaded];
}
