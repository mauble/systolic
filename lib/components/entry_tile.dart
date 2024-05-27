import 'package:flutter/material.dart';
import 'package:popover/popover.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:systolic/models/entry/entry.dart';
import 'package:systolic/components/popover_template.dart';

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
    return Padding(
      padding: const EdgeInsets.only(bottom: 20, left: 15, right: 15),
      child: Material(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(16),
        clipBehavior: Clip.antiAlias,
        child: ListTile(
          contentPadding: const EdgeInsets.only(left: 15, right: 9, bottom: 2),
          title: Text(
            '${entry.systole}・${entry.diastole}・${entry.pulse}',
            style: const TextStyle(
              fontSize: 21,
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
                context: context,
                height: 100,
                backgroundColor: Theme.of(context).colorScheme.surface,
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
      ),
    );
  }
}
