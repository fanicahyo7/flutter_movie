import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_movie/cubit/detail_cubit.dart';
import 'package:flutter_movie/cubit/nowplaying_cubit.dart';
import 'package:flutter_movie/cubit/popular_cubit.dart';
import 'package:flutter_movie/cubit/search_cubit.dart';
import 'package:flutter_movie/cubit/toprated_cubit.dart';
import 'package:flutter_movie/cubit/upcoming_cubit.dart';
import 'package:flutter_movie/cubit/video_cubit.dart';
import 'package:flutter_movie/pages/home_page.dart';
import 'package:flutter_movie/pages/nowplaying_page.dart';
import 'package:flutter_movie/pages/popular_page.dart';
import 'package:flutter_movie/pages/toprated_page.dart';
import 'package:flutter_movie/pages/upcoming_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => NowplayingCubit()),
        BlocProvider(
          create: (context) => TopratedCubit(),
        ),
        BlocProvider(create: (context) => PopularCubit()),
        BlocProvider(create: (context) => UpcomingCubit()),
        BlocProvider(create: (context) => DetailCubit()),
        BlocProvider(create: (context) => VideoCubit()),
        BlocProvider(create: (context) => SearchCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Movie',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const HomePage(),
          '/nowplaying': (context) => const NowPlayingPage(),
          '/popular': (context) => const PopularPage(),
          '/toprated': (context) => const TopRatedPage(),
          '/upcoming': (context) => const UpComingPage(),
        },
      ),
    );
  }
}
