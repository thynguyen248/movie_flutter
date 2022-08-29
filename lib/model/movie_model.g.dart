// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieModel _$MovieModelFromJson(Map<String, dynamic> json) => MovieModel(
      json['id'] as int,
      json['poster_path'] as String?,
      json['title'] as String,
      json['release_date'] as String,
    );

Map<String, dynamic> _$MovieModelToJson(MovieModel instance) =>
    <String, dynamic>{
      'id': instance.movieId,
      'poster_path': instance.posterPath,
      'title': instance.title,
      'release_date': instance.releaseDate,
    };
