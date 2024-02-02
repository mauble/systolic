import 'package:flutter/material.dart';

import 'package:systolic/components/drawer_tile.dart';
import 'package:systolic/pages/entries_page.dart';
import 'package:systolic/pages/options_page.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 10, bottom: 35),
            child: DrawerHeader(
              child: Icon(Icons.monitor_heart),
            ),
          ),
          DrawerTile(
            title: "Measurements",
            leading: const Icon(Icons.text_snippet),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const EntriesPage(),
                ),
              );
            },
          ),
          DrawerTile(
            title: "Settings",
            leading: const Icon(Icons.settings),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const OptionsPage(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
