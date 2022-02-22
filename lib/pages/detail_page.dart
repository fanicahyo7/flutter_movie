import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_movie/cubit/detail_cubit.dart';
import 'package:flutter_movie/cubit/video_cubit.dart';
import 'package:flutter_movie/shared.dart';
import 'package:shimmer/shimmer.dart';
import 'package:intl/intl.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class DetailPage extends StatefulWidget {
  final String id;
  final String title;

  const DetailPage({Key? key, required this.id, required this.title})
      : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  void initState() {
    context.read<DetailCubit>().getDetail(widget.id);
    context.read<VideoCubit>().getVideo(widget.id);
    super.initState();
  }

  Widget imageMovie() {
    return BlocBuilder<DetailCubit, DetailState>(
      builder: (context, state) {
        if (state is DetailSuccess) {
          return SafeArea(
            child: Container(
              width: double.infinity,
              height: 300,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(
                        (state.detail.posterPath != null)
                            ? imageBaseURL + state.detail.posterPath.toString()
                            : "https://png.pngtree.com/png-clipart/20210129/ourmid/pngtree-black-default-avatar-png-image_2813164.jpg",
                      ),
                      fit: BoxFit.cover)),
            ),
          );
        } else {
          return SafeArea(
              child: Shimmer.fromColors(
                  child: Container(
                    width: double.infinity,
                    height: 300,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/default-image.png'),
                            fit: BoxFit.fill)),
                  ),
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100));
        }
      },
    );
  }

  Widget detail() {
    return SafeArea(
      child: ListView(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 220),
            padding:
                EdgeInsets.symmetric(horizontal: defaultMargin, vertical: 26),
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(38.2),
                    topRight: Radius.circular(38.2)),
                color: Colors.white),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title,
                  style:
                      blackTextStyle.copyWith(fontWeight: bold, fontSize: 20),
                ),
                const SizedBox(
                  height: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Trailers',
                      style: blackTextStyle.copyWith(
                          fontWeight: semibold, fontSize: 18),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    BlocBuilder<VideoCubit, VideoState>(
                      builder: (context, state) {
                        if (state is VideoSuccess) {
                          List tipe = ["Trailer"];
                          List keyVideo = state.video.results!.map((e) {
                            if (tipe.contains(e.type)) return e.key;
                          }).toList();
                          if (keyVideo.first != null) {
                            return YoutubePlayer(
                              controller: YoutubePlayerController(
                                  initialVideoId: keyVideo.first,
                                  flags: const YoutubePlayerFlags(
                                      hideControls: false,
                                      controlsVisibleAtStart: true,
                                      autoPlay: true,
                                      mute: false)),
                              showVideoProgressIndicator: true,
                              progressIndicatorColor: Colors.blue,
                            );
                          } else {
                            return const Text('Tidak ada Video');
                          }
                        } else if (state is VideoFailed) {
                          return Center(child: Text(state.error.toString()));
                        } else {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                BlocBuilder<DetailCubit, DetailState>(
                    builder: (context, state) {
                  if (state is DetailSuccess) {
                    String numberFormatPrice = NumberFormat.currency(
                            locale: 'en_US', symbol: '\$ ', decimalDigits: 2)
                        .format(state.detail.budget);
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Description',
                          style: blackTextStyle.copyWith(
                              fontWeight: semibold, fontSize: 18),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          state.detail.overview.toString(),
                          style: blackTextStyle.copyWith(fontWeight: medium),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Released Date',
                          style: blackTextStyle.copyWith(
                              fontWeight: semibold, fontSize: 18),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          state.detail.releaseDate.toString(),
                          style: blackTextStyle.copyWith(fontWeight: medium),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Budget',
                          style: blackTextStyle.copyWith(
                              fontWeight: semibold, fontSize: 18),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          numberFormatPrice,
                          style: blackTextStyle.copyWith(fontWeight: medium),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Genres',
                          style: blackTextStyle.copyWith(
                              fontWeight: semibold, fontSize: 18),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: state.detail.genres!
                              .map((e) => Text(e.name.toString()))
                              .toList(),
                        ),
                      ],
                    );
                  } else if (state is DetailFailed) {
                    return Center(child: Text(state.error.toString()));
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                })
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [imageMovie(), detail()]),
    );
  }
}
