import 'package:json_annotation/json_annotation.dart';

part 'movie_model.g.dart';

@JsonSerializable()
class MovieModel {
  MovieModel(this.movieId, this.posterPath, this.title, this.releaseDate);

  @JsonKey(name: 'id')
  final int movieId;

  @JsonKey(name: 'poster_path')
  final String posterPath;

  @JsonKey(name: 'title')
  final String title;

  @JsonKey(name: 'release_date')
  final String releaseDate;

  factory MovieModel.fromJson(Map<String, dynamic> json) =>
      _$MovieModelFromJson(json);

  Map<String, dynamic> toJson() => _$MovieModelToJson(this);
}
