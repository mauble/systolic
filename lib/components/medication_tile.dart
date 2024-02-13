import 'package:flutter/material.dart';
import 'package:popover/popover.dart';
import 'package:systolic/main.dart';

import 'package:systolic/models/medication/medication.dart';
import 'package:systolic/components/tile_popover.dart';

class MedicationTile extends StatelessWidget {
  final Medication entry;
  final void Function()? onEditTap;
  final void Function()? onDeleteTap;

  const MedicationTile(
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
          entry.name,
          style: TextStyle(
            fontSize: 21,
            fontFamily: getFont(false),
          ),
        ),
        subtitle: Text(
          '${entry.dosage} ${entry.unit}',
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
