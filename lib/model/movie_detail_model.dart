import 'package:collection/collection.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:movie_flutter/data_provider/api_constants.dart';
import 'package:movie_flutter/model/video_response_model.dart';

import 'movie_response_model.dart';

part 'movie_detail_model.g.dart';

@JsonSerializable()
class MovieDetailModel {
  MovieDetailModel(
      this.movieId,
      this.posterPath,
      this.backDropPath,
      this.title,
      this.overview,
      this.releaseDate,
      this.rating,
      this.videos,
      this.recommendations);

  @JsonKey(name: 'id')
  final int movieId;

  @JsonKey(name: 'poster_path')
  final String? posterPath;

  @JsonKey(name: 'backdrop_path')
  final String? backDropPath;

  @JsonKey(name: 'title')
  final String title;

  @JsonKey(name: 'overview')
  final String overview;

  @JsonKey(name: 'release_date')
  final String releaseDate;

  @JsonKey(name: 'vote_average')
  final double rating;

  final VideoResponseModel? videos;

  final MovieResponseModel? recommendations;

  factory MovieDetailModel.fromJson(Map<String, dynamic> json) =>
      _$MovieDetailModelFromJson(json);

  Map<String, dynamic> toJson() => _$MovieDetailModelToJson(this);

  String? get posterUrl =>
      posterPath == null ? null : ApiConstants.posterUrl + posterPath!;

  String get videoThumbnailUrl =>
      videos?.results?.firstOrNull?.thumbnailUrl ?? "";

  String? get videoKey => videos?.results?.firstOrNull?.key;
}
