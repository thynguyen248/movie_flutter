import 'package:movie_flutter/data_provider/api_client.dart';
import 'package:movie_flutter/model/movie_detail_model.dart';
import 'package:movie_flutter/model/movie_response_model.dart';

class Repository {
  final ApiClient apiClient;

  Repository(this.apiClient);

  Future<MovieResponseModel> getPopularMovies({int page = 1}) async {
    final MovieResponseModel popularMovies =
        await apiClient.getPopularMovies(page: page);
    return popularMovies;
  }

  Future<MovieDetailModel> getMovieDetail({required int movieId}) async {
    final MovieDetailModel movieDetailModel =
        await apiClient.getMovieDetail(movieId: movieId);
    return movieDetailModel;
  }
}
