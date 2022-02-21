import 'package:flutter/material.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  Widget _drawerHeader() {
    return const UserAccountsDrawerHeader(
      currentAccountPicture: ClipOval(
        child: Image(
            image: AssetImage('assets/user_photo.png'), fit: BoxFit.cover),
      ),
      accountName: Text('Fani Dwi Cahyo'),
      accountEmail: Text('fanidc7@gmail.com'),
    );
  }

  Widget _drawerItem(
      {IconData? icon, String? text, GestureTapCallback? onTap}) {
    return ListTile(
      title: Row(
        children: <Widget>[
          Icon(icon),
          Padding(
            padding: const EdgeInsets.only(left: 25.0),
            child: Text(
              text.toString(),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          _drawerHeader(),
          _drawerItem(
              icon: Icons.home,
              text: 'Home',
              onTap: () => Navigator.pushNamedAndRemoveUntil(
                  context, '/', (Route<dynamic> route) => false)),
          _drawerItem(
              icon: Icons.play_circle,
              text: 'Now Playing',
              onTap: () => Navigator.pushNamedAndRemoveUntil(
                  context, '/nowplaying', (Route<dynamic> route) => false)),
          _drawerItem(
              icon: Icons.grade,
              text: 'Top Rated',
              onTap: () => Navigator.pushNamedAndRemoveUntil(
                  context, '/toprated', (Route<dynamic> route) => false)),
          _drawerItem(
              icon: Icons.play_arrow_sharp,
              text: 'Upcoming',
              onTap: () => Navigator.pushNamedAndRemoveUntil(
                  context, '/upcoming', (Route<dynamic> route) => false)),
          const Divider(height: 25, thickness: 1),
          _drawerItem(
              icon: Icons.account_box,
              text: 'About',
              onTap: () => print('Tap Family menu')),
        ],
      ),
    );
  }
}
