import 'package:json_annotation/json_annotation.dart';
import 'package:movie_flutter/model/movie_model.dart';

part 'movie_response_model.g.dart';

@JsonSerializable()
class MovieResponseModel {
  MovieResponseModel(this.movies, this.currentPage, this.totalPages);

  @JsonKey(name: 'results')
  final List<MovieModel> movies;

  @JsonKey(name: 'page')
  final int currentPage;

  @JsonKey(name: 'total_pages')
  final int totalPages;

  factory MovieResponseModel.fromJson(Map<String, dynamic> json) =>
      _$MovieResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$MovieResponseModelToJson(this);
}
