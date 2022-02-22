import 'package:flutter/material.dart';
import 'package:flutter_movie/cubit/nowplaying_cubit.dart';
import 'package:flutter_movie/cubit/popular_cubit.dart';
import 'package:flutter_movie/cubit/toprated_cubit.dart';
import 'package:flutter_movie/cubit/upcoming_cubit.dart';
import 'package:flutter_movie/pages/detail_page.dart';
import 'package:flutter_movie/pages/search_page.dart';
import 'package:flutter_movie/shared.dart';
import 'package:flutter_movie/widgets/movielist.dart';
import 'package:flutter_movie/widgets/navdrawer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    context.read<NowplayingCubit>().getNowPlaying();
    context.read<TopratedCubit>().getTopRated();
    context.read<PopularCubit>().getPopular();
    context.read<UpcomingCubit>().getUpComing();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
TextEditingController searchController = TextEditingController();
    Widget search() {
      return Container(
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(21))),
        margin: EdgeInsets.fromLTRB(defaultMargin, 0, defaultMargin, 20),
        child: TextField(
            controller: searchController,
            onEditingComplete: () {
              if (searchController.text != '') {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SearchPage(
                              stringkey: searchController.text,
                            )), (Route<dynamic> route) => false);
                FocusManager.instance.primaryFocus!.unfocus();
              }
            },
            style: blackTextStyle.copyWith(fontSize: 10),
            decoration: InputDecoration(
                hintText: 'Search Movie',
                hintStyle: greyTextStyle.copyWith(fontSize: 10),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(21)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(21),
                    borderSide: const BorderSide(color: Colors.white)))),
      );
    }

    return Scaffold(
        appBar: AppBar(title: const Text('Home')),
        drawer: const DrawerWidget(),
        body: ListView(
          children: [
            Column(
              children: [const SizedBox(height: 10,), search(),
                Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: defaultMargin, vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Now Playing',
                        style: blackTextStyle.copyWith(
                            fontSize: 16, fontWeight: semibold),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/nowplaying');
                        },
                        child: Text(
                          'MORE',
                          style: blackTextStyle.copyWith(fontWeight: bold),
                        ),
                      )
                    ],
                  ),
                ),
                BlocBuilder<NowplayingCubit, NowplayingState>(
                  builder: (context, state) {
                    if (state is NowplayingSuccess) {
                      return SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: state.nowplaying.results!
                              .take(6)
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
                                          right: (e ==
                                                  state.nowplaying.results!
                                                      .take(6)
                                                      .last)
                                              ? defaultMargin
                                              : 10,
                                          left: (e ==
                                                  state.nowplaying.results!
                                                      .take(6)
                                                      .first)
                                              ? 24
                                              : 0),
                                      child: MovieList(
                                          title: e.title.toString(),
                                          imageurl: (e.posterPath != null) ? imageBaseURL + e.posterPath.toString() : "https://png.pngtree.com/png-clipart/20210129/ourmid/pngtree-black-default-avatar-png-image_2813164.jpg",
                                          tangal: e.releaseDate.toString()),
                                    ),
                              ))
                              .toList(),
                        ),
                      );
                    } else if (state is NowplayingFailed) {
                      return Center(child: Text(state.error.toString()));
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: defaultMargin, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Top Rated',
                        style: blackTextStyle.copyWith(
                            fontSize: 16, fontWeight: semibold),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/toprated');
                        },
                        child: Text(
                          'MORE',
                          style: blackTextStyle.copyWith(fontWeight: bold),
                        ),
                      )
                    ],
                  ),
                ),
                BlocBuilder<TopratedCubit, TopratedState>(
                  builder: (context, state) {
                    if (state is TopratedSuccess) {
                      return SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: state.toprated.results!
                              .take(6)
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
                                          right: (e ==
                                                  state.toprated.results!
                                                      .take(6)
                                                      .last)
                                              ? defaultMargin
                                              : 10,
                                          left: (e ==
                                                  state.toprated.results!
                                                      .take(6)
                                                      .first)
                                              ? 24
                                              : 0),
                                      child: MovieList(
                                          title: e.title.toString(),
                                          imageurl: (e.posterPath != null) ? imageBaseURL + e.posterPath.toString() : "https://png.pngtree.com/png-clipart/20210129/ourmid/pngtree-black-default-avatar-png-image_2813164.jpg",
                                          tangal: e.releaseDate.toString()),
                                    ),
                              ))
                              .toList(),
                        ),
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
                const SizedBox(
                  height: 10,
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: defaultMargin, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Popular',
                        style: blackTextStyle.copyWith(
                            fontSize: 16, fontWeight: semibold),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/popular');
                        },
                        child: Text(
                          'MORE',
                          style: blackTextStyle.copyWith(fontWeight: bold),
                        ),
                      )
                    ],
                  ),
                ),
                BlocBuilder<PopularCubit, PopularState>(
                  builder: (context, state) {
                    if (state is PopularSuccess) {
                      return SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: state.popular.results!
                              .take(6)
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
                                          right: (e ==
                                                  state.popular.results!
                                                      .take(6)
                                                      .last)
                                              ? defaultMargin
                                              : 10,
                                          left: (e ==
                                                  state.popular.results!
                                                      .take(6)
                                                      .first)
                                              ? 24
                                              : 0),
                                      child: MovieList(
                                          title: e.title.toString(),
                                          imageurl: (e.posterPath != null) ? imageBaseURL + e.posterPath.toString() : "https://png.pngtree.com/png-clipart/20210129/ourmid/pngtree-black-default-avatar-png-image_2813164.jpg",
                                          tangal: e.releaseDate.toString()),
                                    ),
                                  ))
                              .toList(),
                        ),
                      );
                    } else if (state is PopularFailed) {
                      return Center(child: Text(state.error.toString()));
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: defaultMargin, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Upcoming',
                        style: blackTextStyle.copyWith(
                            fontSize: 16, fontWeight: semibold),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/upcoming');
                        },
                        child: Text(
                          'MORE',
                          style: blackTextStyle.copyWith(fontWeight: bold),
                        ),
                      )
                    ],
                  ),
                ),
                BlocBuilder<UpcomingCubit, UpcomingState>(
                  builder: (context, state) {
                    if (state is UpcomingSuccess) {
                      return SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: state.upcoming.results!
                              .take(6)
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
                                          right: (e ==
                                                  state.upcoming.results!
                                                      .take(6)
                                                      .last)
                                              ? defaultMargin
                                              : 10,
                                          left: (e ==
                                                  state.upcoming.results!
                                                      .take(6)
                                                      .first)
                                              ? 24
                                              : 0),
                                      child: MovieList(
                                          title: e.title.toString(),
                                          imageurl: (e.posterPath != null) ? imageBaseURL + e.posterPath.toString() : "https://png.pngtree.com/png-clipart/20210129/ourmid/pngtree-black-default-avatar-png-image_2813164.jpg",
                                          tangal: e.releaseDate.toString()),
                                    ),
                              ))
                              .toList(),
                        ),
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
                const SizedBox(
                  height: 20,
                )
              ],
            ),
          ],
        ));
  }
}
