import 'package:flutter/material.dart';
import 'package:flutter_movie/cubit/nowplaying_cubit.dart';
import 'package:flutter_movie/widgets/navdrawer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NowPlayingPage extends StatefulWidget {
  const NowPlayingPage({Key? key}) : super(key: key);

  @override
  State<NowPlayingPage> createState() => _NowPlayingPageState();
}

class _NowPlayingPageState extends State<NowPlayingPage> {
  @override
  void initState() {
    context.read<NowplayingCubit>().getNowPlaying();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Now Playing')),
      drawer: const DrawerWidget(),
      body: Center(
        child: BlocBuilder<NowplayingCubit, NowplayingState>(
          builder: (context, state) {
            if (state is NowplayingSuccess) {
              return Column(
                children: state.nowplaying.results!
                    .map((e) => Text(e.title.toString()))
                    .toList(),
              );
            } else if (state is NowplayingFailed) {
              return Text(state.error.toString());
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
