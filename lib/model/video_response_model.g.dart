// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'video_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VideoResponseModel _$VideoResponseModelFromJson(Map<String, dynamic> json) =>
    VideoResponseModel(
      (json['results'] as List<dynamic>)
          .map((e) => VideoModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$VideoResponseModelToJson(VideoResponseModel instance) =>
    <String, dynamic>{
      'results': instance.results,
    };
