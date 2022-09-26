import 'package:dio/dio.dart';
import 'package:movie_flutter/data_provider/api_constants.dart';
import 'package:retrofit/http.dart';

import '../model/movie_detail_model.dart';
import '../model/movie_response_model.dart';

part 'api_client.g.dart';

@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  @GET("/movie/top_rated")
  Future<MovieResponseModel> getPopularMovies(@Query("page") int page);

  @GET("/movie/upcoming")
  Future<MovieResponseModel> getUpcomingMovies(@Query("page") int page);

  @GET("/movie/{movieId}")
  Future<MovieDetailModel> getMovieDetail(@Path("movieId") int movieId,
      {@Query("append_to_response") String append =
          "credits,videos,reviews,recommendations"});
}
