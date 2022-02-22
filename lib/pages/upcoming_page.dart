import 'package:flutter/material.dart';
import 'package:flutter_movie/cubit/upcoming_cubit.dart';
import 'package:flutter_movie/pages/detail_page.dart';
import 'package:flutter_movie/shared.dart';
import 'package:flutter_movie/widgets/moviecard.dart';
import 'package:flutter_movie/widgets/navdrawer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpComingPage extends StatefulWidget {
  const UpComingPage({Key? key}) : super(key: key);

  @override
  State<UpComingPage> createState() => _UpComingPageState();
}

class _UpComingPageState extends State<UpComingPage> {
  @override
  void initState() {
    context.read<UpcomingCubit>().getUpComing();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Upcoming')),
      drawer: const DrawerWidget(),
      body: ListView(
        children: [
          BlocBuilder<UpcomingCubit, UpcomingState>(
            builder: (context, state) {
              if (state is UpcomingSuccess) {
                return Column(
                  children: state.upcoming.results!
                      .map((e) => GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DetailPage(
                                            id: e.id.toString(),
                                            title: e.title.toString(),
                                          )));
                            },
                            child: Container(
                                margin: EdgeInsets.only(
                                  left: defaultMargin,
                                  right: defaultMargin,
                                  top: (e == state.upcoming.results!.first)
                                      ? 20
                                      : 0,
                                  bottom: 20,
                                ),
                                child: MovieCard(
                                  title: e.title.toString(),
                                  urlImage: (e.posterPath != null)
                                      ? imageBaseURL + e.posterPath.toString()
                                      : "https://png.pngtree.com/png-clipart/20210129/ourmid/pngtree-black-default-avatar-png-image_2813164.jpg",
                                )),
                          ))
                      .toList(),
                );
              } else if (state is UpcomingFailed) {
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
