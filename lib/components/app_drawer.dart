import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:systolic/components/app_drawer_tile.dart';
import 'package:systolic/pages/entries_page.dart';
import 'package:systolic/pages/overview_page.dart';
import 'package:systolic/pages/medication_page.dart';
import 'package:systolic/pages/options_page.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Column(
        children: [
          const DrawerHeader(
            child: Icon(Icons.monitor_heart),
          ),
          const Spacer(),
          DrawerTile(
            title: AppLocalizations.of(context)!.measurements,
            leading: const Icon(Icons.bar_chart),
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
            title: AppLocalizations.of(context)!.overview,
            leading: const Icon(Icons.text_snippet),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const OverviewPage(),
                ),
              );
            },
          ),
          DrawerTile(
            title: AppLocalizations.of(context)!.medication,
            leading: const Icon(Icons.medication_rounded),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const MedicationPage(),
                ),
              );
            },
          ),
          DrawerTile(
            title: AppLocalizations.of(context)!.options,
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
          const Spacer(),
          const Visibility(
            maintainSize: true,
            maintainAnimation: true,
            maintainState: true,
            visible: false,
            child: DrawerHeader(
              child: null,
            ),
          ),
        ],
      ),
    );
  }
}
