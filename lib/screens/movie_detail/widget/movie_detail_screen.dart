import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_flutter/model/movie_model.dart';
import 'package:movie_flutter/screens/movie_detail/bloc/movie_detail_bloc.dart';
import 'package:movie_flutter/screens/movie_detail/bloc/movie_detail_event.dart';
import 'package:movie_flutter/screens/movie_detail/bloc/movie_detail_state.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../reusable/cached_image_view.dart';
import '../../../reusable/horizontal_movie_list_view.dart';

class MovieDetailScreen extends StatefulWidget {
  final MovieModel movieModel;
  const MovieDetailScreen({Key? key, required this.movieModel})
      : super(key: key);

  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  late MovieDetailBloc _bloc;
  YoutubePlayerController? _ytController;

  @override
  void initState() {
    _bloc = context.read<MovieDetailBloc>();
    super.initState();
  }

  @override
  void deactivate() {
    _ytController?.pause();
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.movieModel.title),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: BlocConsumer<MovieDetailBloc, MovieDetailState>(
        listener: (context, state) {
          if (state is MovieDetailLoadedState) {
            if (state.movieDetailModel.videoKey != null) {
              _ytController = YoutubePlayerController(
                  initialVideoId: state.movieDetailModel.videoKey!);
            }
            _bloc.add(const VideoLoadedEvent());
          }
          if (state is MovieDetailErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("There's something wrong")));
          }
        },
        builder: (context, state) {
          if (state is MovieDetailInitialState) {
            _bloc.add(const GetMovieDetailEvent());
          }
          if (state is MovieDetailLoadingState) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is MovieDetailLoadedState) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width,
                    maxHeight: MediaQuery.of(context).size.height),
                child: Stack(
                  children: [
                    Positioned(
                        top: 0,
                        left: 0,
                        width: _videoThumbnailSize.width,
                        height: _videoThumbnailSize.height,
                        child: BlocBuilder<MovieDetailBloc, MovieDetailState>(
                          builder: (context, state) {
                            if (state is MovieDetailLoadedState) {
                              if (state.videoLoaded && _ytController != null) {
                                return YoutubePlayer(
                                  controller: _ytController!,
                                  showVideoProgressIndicator: true,
                                  progressIndicatorColor:
                                      Colors.lightBlueAccent,
                                  onEnded: (YoutubeMetaData _md) {
                                    _ytController
                                        ?.seekTo(const Duration(seconds: 0));
                                  },
                                );
                              }
                              return CachedImageView(
                                  url:
                                      state.movieDetailModel.videoThumbnailUrl);
                            }
                            return const SizedBox.shrink();
                          },
                        )),
                    Positioned(
                      top: _videoThumbnailSize.height - _posterOverlaidHeight,
                      left: 16,
                      width: _posterSize.width,
                      height: _posterSize.height,
                      child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5.0)),
                        child: CachedImageView(
                            url: state.movieDetailModel.posterUrl),
                      ),
                    ),
                    Positioned(
                        top: _videoThumbnailSize.height + 16,
                        left: 16 + _posterSize.width + 16,
                        child: Column(
                            mainAxisSize: MainAxisSize.min,
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
                        top: _videoThumbnailSize.height +
                            _posterSize.height -
                            _posterOverlaidHeight,
                        left: 0,
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 16, top: 32, right: 8, bottom: 0),
                            child: Column(
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
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Visibility(
                                    visible: (state.movieDetailModel
                                                .recommendations?.movies ??
                                            [])
                                        .isNotEmpty,
                                    child: HorizontalMovieListView(
                                        title: "Recommendation".toUpperCase(),
                                        itemSize: const Size(150, 150),
                                        movies: state.movieDetailModel
                                                .recommendations?.movies ??
                                            [],
                                        hasMoreData: false,
                                        onScrollToEnd: () => {}),
                                  ),
                                ]),
                          ),
                        )),
                  ],
                ),
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Size get _videoThumbnailSize => Size(MediaQuery.of(context).size.width,
      MediaQuery.of(context).size.width * 9 / 16);
  Size get _posterSize => const Size(120, 120 * 3 / 2);
  double get _posterOverlaidHeight => _posterSize.height / 4;
}
