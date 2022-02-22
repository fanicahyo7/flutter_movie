import 'package:flutter/material.dart';
import 'package:flutter_movie/shared.dart';

class MovieList extends StatelessWidget {
  final String title;
  final String imageurl;
  final String tangal;
  const MovieList(
      {Key? key,
      required this.title,
      required this.imageurl,
      required this.tangal})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      width: 150,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(0.0, 1.0),
            blurRadius: 6.0,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 150,
            width: 150,
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8)
                ),
                image: DecorationImage(
                    image: NetworkImage(imageurl),
                    fit: BoxFit.cover)),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: Text(
                title,
                style: blackTextStyle.copyWith(fontWeight: semibold),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: Text(
                tangal,
                style: greyTextStyle.copyWith(fontWeight: semibold),
              ),
            ),
          )
        ],
      ),
    );
  }
}
