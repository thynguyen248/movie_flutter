import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_flutter/data_provider/api_client.dart';
import 'package:movie_flutter/model/movie_model.dart';
import 'package:movie_flutter/repository/repository.dart';
import 'package:movie_flutter/screens/movie_detail/bloc/movie_detail_bloc.dart';
import 'package:movie_flutter/screens/movie_detail/bloc/movie_detail_event.dart';
import 'package:movie_flutter/screens/movie_detail/bloc/movie_detail_state.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../home/widget/cached_image_view.dart';

class MovieDetailScreen extends StatefulWidget {
  final MovieModel movieModel;
  const MovieDetailScreen({Key? key, required this.movieModel})
      : super(key: key);

  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  late YoutubePlayerController _ytController;

  @override
  void initState() {
    super.initState();
  }

  @override
  void deactivate() {
    _ytController.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MovieDetailBloc(
          Repository(ApiClient(Dio())), widget.movieModel.movieId),
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.movieModel.title),
          iconTheme: const IconThemeData(
            color: Colors.white,
          ),
        ),
        body: BlocConsumer<MovieDetailBloc, MovieDetailState>(
          listener: (context, state) {
            if (state is MovieDetailLoadedState) {
              _ytController = YoutubePlayerController(
                  initialVideoId:
                      state.movieDetailModel.videos.results.first.key);
              BlocProvider.of<MovieDetailBloc>(context).add(VideoLoadedEvent());
            }
          },
          builder: (context, state) {
            if (state is MovieDetailInitialState) {
              BlocProvider.of<MovieDetailBloc>(context)
                  .add(GetMovieDetailEvent());
            }
            if (state is MovieDetailLoadingState) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is MovieDetailLoadedState) {
              return Stack(
                children: [
                  Positioned(
                      top: 0,
                      left: 0,
                      width: _videoThumbnailSize().width,
                      height: _videoThumbnailSize().height,
                      child: BlocBuilder<MovieDetailBloc, MovieDetailState>(
                        builder: (context, state) {
                          if (state is MovieDetailLoadedState) {
                            if (state.videoLoaded) {
                              return YoutubePlayer(
                                controller: _ytController,
                                showVideoProgressIndicator: true,
                                progressIndicatorColor: Colors.lightBlueAccent,
                                topActions: <Widget>[
                                  const SizedBox(width: 8.0),
                                  Expanded(
                                    child: Text(
                                      _ytController.metadata.title,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 18.0,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    ),
                                  ),
                                ],
                                bottomActions: [
                                  CurrentPosition(),
                                  ProgressBar(isExpanded: true),
                                  FullScreenButton(),
                                ],
                                onReady: () {},
                                onEnded: (YoutubeMetaData _md) {
                                  _ytController
                                      .seekTo(const Duration(seconds: 0));
                                },
                              );
                            } else {
                              return CachedImageView(
                                  url: state.videoThumbnailUrl());
                            }
                          }
                          return Container(
                            color: Colors.orange,
                          );
                        },
                      )),
                  Positioned(
                    top: _videoThumbnailSize().height - _posterOverlaidHeight(),
                    left: 16,
                    width: _posterSize().width,
                    height: _posterSize().height,
                    child: ClipRRect(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(5.0)),
                      child: CachedImageView(
                          url: state.movieDetailModel.posterUrl()),
                    ),
                  ),
                  Positioned(
                      top: _videoThumbnailSize().height + 16,
                      left: 16 + _posterSize().width + 16,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Rating: ${state.movieDetailModel.rating}",
                              style: const TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.w200,
                                  color: Colors.black87),
                              maxLines: 1,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              state.movieDetailModel.releaseDate,
                              style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w200,
                                  color: Colors.blueGrey),
                            ),
                          ])),
                  Positioned(
                      top: _videoThumbnailSize().height +
                          _posterSize().height -
                          _posterOverlaidHeight() +
                          16,
                      left: 0,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width - 26,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  state.movieDetailModel.title,
                                  style: const TextStyle(
                                      fontSize: 27,
                                      fontWeight: FontWeight.w200,
                                      color: Colors.black),
                                  maxLines: 1,
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  state.movieDetailModel.overview,
                                  style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w200,
                                      color: Colors.blueGrey),
                                ),
                              ]),
                        ),
                      )),
                ],
              );
            }
            return Container(color: Colors.white);
          },
        ),
      ),
    );
  }

  Size _videoThumbnailSize() => Size(MediaQuery.of(context).size.width,
      MediaQuery.of(context).size.width * 9 / 16);
  Size _posterSize() => const Size(120, 120 * 3 / 2);
  double _posterOverlaidHeight() => _posterSize().height / 4;
}
