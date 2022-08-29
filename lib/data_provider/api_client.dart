import 'package:dio/dio.dart';
import 'package:movie_flutter/model/movie_response_model.dart';

import '../model/movie_detail_model.dart';

class ApiClient {
  static String apiKey = "7a20b718d2507f11dad2d84d6b028fdd";
  static String mainUrl = "https://api.themoviedb.org/3";
  static String posterUrl = "https://image.tmdb.org/t/p/original/";
  static String getPopularMoviesUrl = '$mainUrl/movie/top_rated';
  static String getUpcomingMoviesUrl = '$mainUrl/movie/upcoming';
  static String getMovieDetailUrl = '$mainUrl/movie/';

  final Dio _dio;

  ApiClient(this._dio);

  Future<MovieResponseModel> getPopularMovies({int page = 1}) async {
    var params = {"api_key": apiKey, "language": "en-US", "page": page};
    try {
      Response response =
          await _dio.get(getPopularMoviesUrl, queryParameters: params);
      return MovieResponseModel.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      throw "$error";
    }
  }

  Future<MovieResponseModel> getUpcomingMovies({int page = 1}) async {
    var params = {"api_key": apiKey, "language": "en-US", "page": page};
    try {
      Response response =
          await _dio.get(getUpcomingMoviesUrl, queryParameters: params);
      return MovieResponseModel.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      throw "$error";
    }
  }

  Future<MovieDetailModel> getMovieDetail({required int movieId}) async {
    var params = {
      "api_key": apiKey,
      "language": "en-US",
      "append_to_response": "credits,videos,reviews,recommendations"
    };
    var url = "$getMovieDetailUrl$movieId";
    try {
      Response response = await _dio.get(url, queryParameters: params);
      return MovieDetailModel.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      throw "$error";
    }
  }
}
