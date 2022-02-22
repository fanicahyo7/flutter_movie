import 'package:flutter/material.dart';
import 'package:flutter_movie/cubit/toprated_cubit.dart';
import 'package:flutter_movie/pages/detail_page.dart';
import 'package:flutter_movie/shared.dart';
import 'package:flutter_movie/widgets/moviecard.dart';
import 'package:flutter_movie/widgets/navdrawer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TopRatedPage extends StatefulWidget {
  const TopRatedPage({Key? key}) : super(key: key);

  @override
  State<TopRatedPage> createState() => _TopRatedPageState();
}

class _TopRatedPageState extends State<TopRatedPage> {
  @override
  void initState() {
    context.read<TopratedCubit>().getTopRated();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Top Rated')),
      drawer: const DrawerWidget(),
      body: ListView(
        children: [
          BlocBuilder<TopratedCubit, TopratedState>(
            builder: (context, state) {
              if (state is TopratedSuccess) {
                return Column(
                  children: state.toprated.results!
                      .map((e) => GestureDetector(
                        onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  DetailPage(id: e.id.toString(),title: e.title.toString(),)));
                                    },
                        child: Container(
                            margin: EdgeInsets.only(
                              left: defaultMargin,
                              right: defaultMargin,
                              top:
                                  (e == state.toprated.results!.first) ? 20 : 0,
                              bottom: 20,
                            ),
                            child: MovieCard(
                                title: e.title.toString(),
                                urlImage: (e.posterPath != null) ? imageBaseURL + e.posterPath.toString() : "https://png.pngtree.com/png-clipart/20210129/ourmid/pngtree-black-default-avatar-png-image_2813164.jpg",)),
                      ))
                      .toList(),
                );
              } else if (state is TopratedFailed) {
                return Center(child: Text(state.error.toString()));
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
