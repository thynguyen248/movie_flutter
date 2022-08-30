import 'package:flutter/material.dart';
import 'package:movie_flutter/model/movie_model.dart';
import 'package:movie_flutter/util/random_color.dart';

import '../../movie_detail/widget/movie_detail_screen.dart';
import 'cached_image_view.dart';

class UpcomingMoviesListView extends StatelessWidget {
  final List<MovieModel> movies;
  final bool hasMoreData;
  final VoidCallback onScrollToEnd;
  final ScrollController _scrollController = ScrollController();
  final double _listHeight = 200.0;

  UpcomingMoviesListView(
      {Key? key,
      required this.movies,
      required this.hasMoreData,
      required this.onScrollToEnd})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 30,
        ),
        const ListTile(
          title: Text(
            "UPCOMING",
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w200,
                color: Colors.blueGrey),
            maxLines: 1,
          ),
        ),
        SizedBox(
          height: _listHeight,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 10),
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
                if (hasMoreData) {
                  return SizedBox(
                    width: 200.0,
                    child: Card(
                        elevation: 5.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(5.0)),
                          child: Container(
                            color: RandomColor.primaryColor.withOpacity(0.2),
                          ),
                        )),
                  );
                }
                return const SizedBox.shrink();
              } else {
                return InkWell(
                  child: SizedBox(
                    width: _listHeight,
                    child: Card(
                        elevation: 5.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(5.0)),
                          child: CachedImageView(url: movies[index].posterUrl),
                        )),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              MovieDetailScreen(movieModel: movies[index])),
                    );
                  },
                );
              }
            },
            itemCount: movies.length + 1,
          ),
        ),
      ],
    );
  }
}
