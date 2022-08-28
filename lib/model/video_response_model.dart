import 'package:json_annotation/json_annotation.dart';
import 'package:movie_flutter/model/video_model.dart';

part 'video_response_model.g.dart';

@JsonSerializable()
class VideoResponseModel {
  VideoResponseModel(this.results);

  final List<VideoModel> results;

  factory VideoResponseModel.fromJson(Map<String, dynamic> json) =>
      _$VideoResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$VideoResponseModelToJson(this);
}
