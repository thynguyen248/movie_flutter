import 'package:equatable/equatable.dart';

abstract class MovieDetailEvent extends Equatable {}

class GetMovieDetailEvent extends MovieDetailEvent {
  @override
  List<Object?> get props => [toString()];
}

class VideoLoadedEvent extends MovieDetailEvent {
  @override
  List<Object?> get props => [toString()];
}
