import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_movie/cubit/search_cubit.dart';
import 'package:flutter_movie/pages/detail_page.dart';
import 'package:flutter_movie/shared.dart';
import 'package:flutter_movie/widgets/moviecard.dart';

class SearchPage extends StatefulWidget {
  final String stringkey;
  const SearchPage({Key? key, required this.stringkey}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController searchController = TextEditingController();
  @override
  void initState() {
    searchController.text = widget.stringkey;
    context.read<SearchCubit>().search(searchController.text);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Container(
        width: double.infinity,
        height: 40,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(5)),
        child: Center(
          child: TextField(
            controller: searchController,
            onEditingComplete: () {
              if (searchController.text != '') {
                setState(() {
                  context.read<SearchCubit>().search(searchController.text);
                  FocusManager.instance.primaryFocus!.unfocus();
                });
              }
            },
          ),
        ),
      )),
      body: ListView(
        children: [
          Column(
            children: [
              BlocBuilder<SearchCubit, SearchState>(
                builder: (context, state) {
                  if (state is SearchSuccess) {
                    if (state.search.results!.isNotEmpty) {
                      return Column(
                        children: state.search.results!
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
                                        top: (e == state.search.results!.first)
                                            ? 20
                                            : 0,
                                        bottom: 20,
                                      ),
                                      child: MovieCard(
                                          title: e.title.toString(),
                                          urlImage: (e.posterPath != null) ? imageBaseURL + e.posterPath.toString() : "https://png.pngtree.com/png-clipart/20210129/ourmid/pngtree-black-default-avatar-png-image_2813164.jpg",)),
                                ))
                            .toList(),
                      );
                    } else {
                      return const Center(
                        child: Text('Tidak Ada Data'),
                      );
                    }
                  } else if (state is SearchFailed) {
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
        ],
      ),
    );
  }
}
