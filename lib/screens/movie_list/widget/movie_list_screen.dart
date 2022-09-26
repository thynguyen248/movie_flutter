import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_flutter/reusable/horizontal_movie_list_view.dart';
import 'package:movie_flutter/screens/movie_list/bloc/movie_list_bloc.dart';
import 'package:movie_flutter/screens/movie_list/bloc/movie_list_event.dart';
import 'package:movie_flutter/screens/movie_list/bloc/movie_list_state.dart';
import 'package:movie_flutter/screens/movie_list/widget/movie_list_item.dart';
import 'package:scrolls_to_top/scrolls_to_top.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late MovieListBloc _bloc;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _bloc = context.read<MovieListBloc>();
    _scrollController.addListener(() {
      if (_scrollController.offset ==
          _scrollController.position.maxScrollExtent) {
        _bloc.add(const LoadMorePopularMoviesEvent());
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
      home: ScrollsToTop(
        onScrollsToTop: _scrollToTop,
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Movies"),
          ),
          body: BlocConsumer<MovieListBloc, MovieListState>(
            listener: (context, state) {
              if (state is HomeErrorState) {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("There's something wrong")));
              }
            },
            builder: (context, state) {
              if (state is HomeInitialState) {
                _bloc.add(const LoadPopularMoviesEvent());
                _bloc.add(const LoadUpcomingMoviesEvent());
              }
              if (state is HomeLoadingState) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state is HomeSuccessLoadDataState) {
                return RefreshIndicator(
                  onRefresh: _onRefresh,
                  child: ListView.builder(
                    controller: _scrollController,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return Visibility(
                          visible: state.upcomingMovies.isNotEmpty,
                          child: HorizontalMovieListView(
                              title: "Upcoming".toUpperCase(),
                              insets:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              movies: state.upcomingMovies,
                              hasMoreData: state.hasMoreUpcomingMovies,
                              onScrollToEnd: () => _bloc
                                  .add(const LoadMoreUpcomingMoviesEvent())),
                        );
                      }
                      index -= 1;
                      if (index == state.popularMovies.length) {
                        return Visibility(
                          visible: state.hasMorePopularMovies,
                          child: const SizedBox(
                            height: 100.0,
                            width: 100.0,
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                        );
                      }
                      return MovieListItem(
                        movieModel: state.popularMovies[index],
                        header: index == 0 ? "POPULAR" : "",
                      );
                    },
                    itemCount: _bloc.listItemCount,
                  ),
                );
                // );
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }

  Future<void> _onRefresh() async {
    _bloc.add(const RefreshEvent());
  }

  Future<void> _scrollToTop(ScrollsToTopEvent event) async {
    _scrollController.animateTo(0,
        duration: const Duration(milliseconds: 300), curve: Curves.linear);
  }
}
