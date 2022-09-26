import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_flutter/repository/repository.dart';
import 'package:movie_flutter/screens/movie_list/bloc/movie_list_bloc.dart';
import 'package:movie_flutter/screens/movie_list/widget/movie_list_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MovieListBloc(RepositoryImpl()),
      child: const HomeScreen(),
    );
  }
}
