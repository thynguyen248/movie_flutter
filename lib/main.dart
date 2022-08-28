import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_flutter/data_provider/api_client.dart';
import 'package:movie_flutter/repository/repository.dart';
import 'package:movie_flutter/screens/home/bloc/home_bloc.dart';
import 'package:movie_flutter/screens/home/widget/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc(Repository(ApiClient(Dio()))),
      child: const HomeScreen(),
    );
  }
}
