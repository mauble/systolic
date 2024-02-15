import 'package:flutter/material.dart';
import 'package:popover/popover.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:systolic/models/entry/entry.dart';
import 'package:systolic/components/tile_popover.dart';

class EntryTile extends StatelessWidget {
  final Entry entry;
  final void Function()? onEditTap;
  final void Function()? onDeleteTap;

  const EntryTile(
      {super.key,
      required this.entry,
      required this.onEditTap,
      required this.onDeleteTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceVariant,
        borderRadius: BorderRadius.circular(15),
      ),
      margin: const EdgeInsets.only(bottom: 20, left: 15, right: 15),
      child: ListTile(
        contentPadding: const EdgeInsets.only(left: 21, right: 19, bottom: 2),
        title: Text(
          '${entry.systole}・${entry.diastole}・${entry.pulse}',
          style: const TextStyle(
            fontSize: 21,
            fontFamily: 'ChivoMono',
          ),
        ),
        subtitle: Text(
          DateFormat(AppLocalizations.of(context)!.timeFormat)
              .format(DateTime.fromMillisecondsSinceEpoch(entry.time)),
          style: const TextStyle(
            fontSize: 17,
          ),
        ),
        trailing: Builder(
          builder: (context) => GestureDetector(
            onTap: () => showPopover(
              width: 90,
              height: 100,
              context: context,
              backgroundColor: Theme.of(context).colorScheme.background,
              bodyBuilder: (context) => EntryPopover(
                onEditTap: onEditTap,
                onDeleteTap: onDeleteTap,
                buttonHeight: 50,
              ),
            ),
            child: const Icon(Icons.more_vert),
          ),
        ),
      ),
    );
  }
}
