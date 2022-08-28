import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_flutter/screens/home/bloc/home_bloc.dart';
import 'package:movie_flutter/screens/home/bloc/home_event.dart';
import 'package:movie_flutter/screens/home/bloc/home_state.dart';
import 'package:movie_flutter/screens/movie_detail/widget/movie_detail_screen.dart';

import 'movie_list_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late HomeBloc bloc;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    bloc = context.read<HomeBloc>();
    _scrollController.addListener(() {
      if (_scrollController.offset ==
          _scrollController.position.maxScrollExtent) {
        bloc.add(const LoadMorePopularMoviesEvent());
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: Scaffold(
        appBar: AppBar(title: const Text("Movies")),
        body: BlocConsumer<HomeBloc, HomeState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is HomeInitialState) {
              bloc.add(LoadPopularMoviesEvent());
            }
            if (state is HomeLoadingState) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is HomeSuccessFetchPopularMoviesState) {
              return SafeArea(
                child: Center(
                  child: ListView.builder(
                    controller: _scrollController,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      if (index == state.movies.length) {
                        if (state.hasMoreData) {
                          return const SizedBox(
                            height: 100.0,
                            width: 100.0,
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        } else {
                          return const SizedBox(height: 1);
                        }
                      } else {
                        return InkWell(
                          child: MovieListItem(movieModel: state.movies[index]),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MovieDetailScreen(
                                      movieModel: state.movies[index])),
                            );
                          },
                        );
                      }
                    },
                    itemCount: state.movies.length + 1,
                  ),
                ),
              );
            }
            return Container(color: Colors.white);
          },
        ),
      ),
    );
  }
}
