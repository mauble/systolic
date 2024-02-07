import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EntryPopover extends StatelessWidget {
  final void Function()? onEditTap;
  final void Function()? onDeleteTap;
  final double? buttonHeight;

  const EntryPopover({
    super.key,
    required this.onEditTap,
    required this.onDeleteTap,
    required this.buttonHeight,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
            onEditTap!();
          },
          child: SizedBox(
            height: buttonHeight,
            child: Center(child: Text(AppLocalizations.of(context)!.edit)),
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
            onDeleteTap!();
          },
          child: SizedBox(
            height: buttonHeight,
            child: Center(child: Text(AppLocalizations.of(context)!.delete)),
          ),
        ),
      ],
    );
  }
}
