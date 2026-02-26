import 'package:flutter/material.dart';
import 'package:test/components/drawe_tile.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Column(
        children: [
          // header
          DrawerHeader(child: Icon(Icons.note)),

          //note title
          DrawerTile(title: "Notes", leading: Icon(Icons.home), onTap: () {}),

          // settings tile
          DrawerTile(
            title: "Settings",
            leading: Icon(Icons.settings),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
