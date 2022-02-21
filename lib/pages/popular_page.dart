import 'package:flutter/material.dart';
import 'package:flutter_movie/widgets/navdrawer.dart';

class PopularPage extends StatelessWidget {
  const PopularPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Popular')),
      drawer: const DrawerWidget(),
      body: const Center(
        child: Text('Popular'),
      ),
    );
  }
}
