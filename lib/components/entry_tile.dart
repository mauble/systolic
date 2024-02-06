import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:popover/popover.dart';
import 'package:intl/intl.dart';

import 'package:systolic/models/entry/entry.dart';
import 'package:systolic/components/entry_popover.dart';

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
        contentPadding: const EdgeInsets.only(left: 18, right: 14, bottom: 2),
        title: Text(
          '${entry.systole}・${entry.diastole}・${entry.pulse}',
          style: TextStyle(
            fontSize: 21,
            fontFamily: GoogleFonts.chivoMono().fontFamily,
          ),
        ),
        subtitle: Text(
          DateFormat('HH:mm').format(
            DateTime.fromMillisecondsSinceEpoch(
              entry.time,
            ),
          ),
          style: const TextStyle(
            fontSize: 17,
          ),
        ),
        trailing: Builder(
          builder: (context) => GestureDetector(
            onTap: () => showPopover(
              width: 70,
              height: 90,
              context: context,
              backgroundColor: Theme.of(context).colorScheme.background,
              bodyBuilder: (context) => EntryPopover(
                onEditTap: onEditTap,
                onDeleteTap: onDeleteTap,
              ),
            ),
            child: const Icon(Icons.more_vert),
          ),
        ),
      ),
    );
  }
}
