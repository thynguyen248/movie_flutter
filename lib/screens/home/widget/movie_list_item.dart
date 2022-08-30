import 'package:flutter/material.dart';
import 'package:movie_flutter/reusable/shadow_card.dart';

import '../../../model/movie_model.dart';
import '../../../reusable/cached_image_view.dart';
import '../../movie_detail/widget/movie_detail_screen.dart';

class MovieListItem extends StatelessWidget {
  final MovieModel movieModel;
  final String header;

  const MovieListItem(
      {Key? key, required this.movieModel, required this.header})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Visibility(
          visible: header.isNotEmpty,
          child: Padding(
            padding: const EdgeInsets.only(top: 30),
            child: ListTile(
              title: Text(
                header,
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w200,
                    color: Colors.blueGrey),
                maxLines: 1,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 4,
          ),
          child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          MovieDetailScreen(movieModel: movieModel)),
                );
              },
              child: ShadowCard(
                child: Column(
                  children: [
                    AspectRatio(
                      aspectRatio: 16 / 9,
                      child: CachedImageView(url: movieModel.posterUrl),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            movieModel.title,
                            style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w200,
                                color: Colors.blueGrey),
                            maxLines: 1,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  movieModel.releaseDate,
                                  style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w200,
                                      color: Colors.black87),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              )),
        ),
      ],
    );
  }
}
