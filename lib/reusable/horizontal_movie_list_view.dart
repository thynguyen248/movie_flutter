import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_flutter/model/movie_model.dart';
import 'package:movie_flutter/reusable/shadow_card.dart';

import '../repository/repository.dart';
import '../screens/movie_detail/bloc/movie_detail_bloc.dart';
import '../screens/movie_detail/widget/movie_detail_screen.dart';
import '../utils/Utils.dart';
import 'cached_image_view.dart';

class HorizontalMovieListView extends StatelessWidget {
  final String title;
  final List<MovieModel> movies;
  final bool hasMoreData;
  final VoidCallback onScrollToEnd;
  final ScrollController _scrollController = ScrollController();
  final Size itemSize;
  final EdgeInsets insets;

  HorizontalMovieListView(
      {Key? key,
      required this.title,
      required this.movies,
      required this.hasMoreData,
      this.itemSize = const Size(200, 200),
      this.insets = EdgeInsets.zero,
      required this.onScrollToEnd})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 30,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: insets.left),
          child: ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(
              title,
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w200,
                  color: Colors.blueGrey),
              maxLines: 1,
            ),
          ),
        ),
        SizedBox(
          height: itemSize.height,
          child: ListView.separated(
            padding: insets,
            separatorBuilder: (context, index) => const SizedBox(
              height: 10,
            ),
            scrollDirection: Axis.horizontal,
            controller: _scrollController
              ..addListener(() {
                if (_scrollController.offset ==
                    _scrollController.position.maxScrollExtent) {
                  onScrollToEnd();
                }
              }),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              if (index == movies.length) {
                return Visibility(
                  visible: hasMoreData,
                  child: SizedBox(
                      width: 200.0,
                      child: ShadowCard(
                        child: Container(
                          color: Utils.randomColor.withOpacity(0.2),
                        ),
                      )),
                );
              }
              return InkWell(
                child: SizedBox(
                    width: itemSize.width,
                    child: ShadowCard(
                      child: CachedImageView(url: movies[index].posterUrl),
                    )),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BlocProvider(
                            lazy: false,
                            create: (context) => MovieDetailBloc(
                                RepositoryImpl(), movies[index].movieId),
                            child:
                                MovieDetailScreen(movieModel: movies[index]))),
                  );
                },
              );
            },
            itemCount: movies.length + 1,
          ),
        ),
      ],
    );
  }
}
