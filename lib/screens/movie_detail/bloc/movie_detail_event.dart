import 'package:equatable/equatable.dart';

abstract class MovieDetailEvent extends Equatable {
  const MovieDetailEvent();

  @override
  List<Object?> get props => [toString()];
}

class GetMovieDetailEvent extends MovieDetailEvent {
  const GetMovieDetailEvent();
}

class VideoLoadedEvent extends MovieDetailEvent {
  const VideoLoadedEvent();
}
