import 'package:dio/dio.dart';
import 'package:movie_flutter/data_provider/api_client.dart';
import 'package:movie_flutter/model/movie_detail_model.dart';
import 'package:movie_flutter/model/movie_response_model.dart';

import '../data_provider/api_constants.dart';
import '../data_provider/api_interceptor.dart';

abstract class Repository {
  Future<MovieResponseModel> getUpcomingMovies({int page = 1});
  Future<MovieResponseModel> getPopularMovies({int page = 1});
  Future<MovieDetailModel> getMovieDetail({required int movieId});
}

class RepositoryImpl extends Repository {
  late ApiClient _apiClient;

  RepositoryImpl() {
    _apiClient = ApiClient(_defaultDioClient);
  }

  Dio get _defaultDioClient {
    Dio dio = Dio();
    dio.options = BaseOptions(
        receiveTimeout: ApiConstants.timeout,
        connectTimeout: ApiConstants.timeout);
    dio.interceptors.add(ApiInterceptor());
    return dio;
  }

  Future<MovieResponseModel> getUpcomingMovies({int page = 1}) {
    return _apiClient.getUpcomingMovies(page);
  }

  Future<MovieResponseModel> getPopularMovies({int page = 1}) {
    return _apiClient.getPopularMovies(page);
  }

  Future<MovieDetailModel> getMovieDetail({required int movieId}) {
    return _apiClient.getMovieDetail(movieId);
  }
}
