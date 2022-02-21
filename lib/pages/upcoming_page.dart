import 'package:flutter/material.dart';
import 'package:flutter_movie/widgets/navdrawer.dart';

class UpComingPage extends StatelessWidget {
  const UpComingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Up Coming')),
      drawer: const DrawerWidget(),
      body: const Center(
        child: Text('Up Coming'),
      ),
    );
  }
}
