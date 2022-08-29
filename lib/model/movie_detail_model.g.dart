// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieDetailModel _$MovieDetailModelFromJson(Map<String, dynamic> json) =>
    MovieDetailModel(
      json['id'] as int,
      json['poster_path'] as String?,
      json['backdrop_path'] as String,
      json['title'] as String,
      json['overview'] as String,
      json['release_date'] as String,
      (json['vote_average'] as num).toDouble(),
      VideoResponseModel.fromJson(json['videos'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MovieDetailModelToJson(MovieDetailModel instance) =>
    <String, dynamic>{
      'id': instance.movieId,
      'poster_path': instance.posterPath,
      'backdrop_path': instance.backDropPath,
      'title': instance.title,
      'overview': instance.overview,
      'release_date': instance.releaseDate,
      'vote_average': instance.rating,
      'videos': instance.videos,
    };
