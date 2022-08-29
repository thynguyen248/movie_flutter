import 'package:flutter/material.dart';

import '../../../model/movie_model.dart';
import '../../movie_detail/widget/movie_detail_screen.dart';
import 'cached_image_view.dart';

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
            child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(5.0),
                      topRight: Radius.circular(5.0),
                    ),
                    child: AspectRatio(
                      aspectRatio: 16 / 9,
                      // child: Image.network(
                      //   ApiClient.posterUrl + movieModel.posterPath,
                      //   fit: BoxFit.cover,
                      // ),
                      child: CachedImageView(url: movieModel.posterUrl()),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 16,
                    ),
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
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    right: 8,
                                  ),
                                  child: Text(
                                    movieModel.releaseDate,
                                    style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w200,
                                        color: Colors.black87),
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}