import 'package:flutter/material.dart';
import 'package:flutter_movie/cubit/popular_cubit.dart';
import 'package:flutter_movie/pages/detail_page.dart';
import 'package:flutter_movie/shared.dart';
import 'package:flutter_movie/widgets/moviecard.dart';
import 'package:flutter_movie/widgets/navdrawer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PopularPage extends StatefulWidget {
  const PopularPage({Key? key}) : super(key: key);

  @override
  State<PopularPage> createState() => _PopularPageState();
}

class _PopularPageState extends State<PopularPage> {
  @override
  void initState() {
    context.read<PopularCubit>().getPopular();
    super.initState();
  }
 @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Popular')),
      drawer: const DrawerWidget(),
      body: ListView(
        children: [
          BlocBuilder<PopularCubit, PopularState>(
            builder: (context, state) {
              if (state is PopularSuccess) {
                return Column(
                  children: state.popular.results!
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
                                  (e == state.popular.results!.first) ? 20 : 0,
                              bottom: 20,
                            ),
                            child: MovieCard(
                                title: e.title.toString(),
                                urlImage: (e.posterPath != null) ? imageBaseURL + e.posterPath.toString() : "https://png.pngtree.com/png-clipart/20210129/ourmid/pngtree-black-default-avatar-png-image_2813164.jpg",)),
                      ))
                      .toList(),
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
        ],
      ),
    );
  }
}
