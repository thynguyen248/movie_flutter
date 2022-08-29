import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_flutter/screens/home/bloc/home_bloc.dart';
import 'package:movie_flutter/screens/home/bloc/home_event.dart';
import 'package:movie_flutter/screens/home/bloc/home_state.dart';
import 'package:movie_flutter/screens/home/widget/movie_list_item.dart';
import 'package:movie_flutter/screens/home/widget/upcoming_movies_list_view.dart';

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
        appBar: AppBar(
          title: const Text("Movies"),
        ),
        body: BlocConsumer<HomeBloc, HomeState>(
          listener: (context, state) {
            if (state is HomeErrorState) {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("There's something wrong")));
            }
          },
          builder: (context, state) {
            if (state is HomeInitialState) {
              bloc.add(const LoadPopularMoviesEvent());
              bloc.add(const LoadUpcomingMoviesEvent());
            }
            if (state is HomeLoadingState) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is HomeSuccessLoadDataState) {
              return ListView.builder(
                controller: _scrollController,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    if (state.upcomingMovies.isNotEmpty) {
                      return UpcomingMoviesListView(
                          movies: state.upcomingMovies,
                          hasMoreData: state.hasMoreUpcomingMovies,
                          onScrollToEnd: () =>
                              bloc.add(const LoadMoreUpcomingMoviesEvent()));
                    }
                    return const SizedBox.shrink();
                  }
                  index -= 1;
                  if (index == state.popularMovies.length) {
                    if (state.hasMorePopularMovies) {
                      return const SizedBox(
                        height: 100.0,
                        width: 100.0,
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }
                    return const SizedBox.shrink();
                  }
                  return MovieListItem(
                    movieModel: state.popularMovies[index],
                    header: index == 0 ? "POPULAR" : "",
                  );
                },
                itemCount: bloc.listItemCount(),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  void _scrollToTop() {
    _scrollController.animateTo(0,
        duration: const Duration(milliseconds: 1), curve: Curves.linear);
  }
}
