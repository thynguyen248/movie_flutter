import 'package:json_annotation/json_annotation.dart';

part 'video_model.g.dart';

@JsonSerializable()
class VideoModel {
  VideoModel(this.id, this.key);

  final String id;

  final String key;

  factory VideoModel.fromJson(Map<String, dynamic> json) =>
      _$VideoModelFromJson(json);

  Map<String, dynamic> toJson() => _$VideoModelToJson(this);

  String get thumbnailUrl => "https://img.youtube.com/vi/$key/hqdefault.jpg";
}
