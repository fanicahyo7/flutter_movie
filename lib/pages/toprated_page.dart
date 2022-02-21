import 'package:flutter/material.dart';
import 'package:flutter_movie/widgets/navdrawer.dart';

class TopRatedPage extends StatelessWidget {
  const TopRatedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Top Rated')),
      drawer: const DrawerWidget(),
      body: const Center(
        child: Text('Top Rated'),
      ),
    );
  }
}
