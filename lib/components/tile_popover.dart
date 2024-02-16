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
        buildButton(context, AppLocalizations.of(context)!.edit, onEditTap),
        buildButton(context, AppLocalizations.of(context)!.delete, onDeleteTap),
      ],
    );
  }

  Widget buildButton(
      BuildContext context, String buttonText, void Function()? onTap) {
    double maxWidth = calculateMaxButtonWidth(context);
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
        onTap!();
      },
      child: SizedBox(
        width: maxWidth,
        height: buttonHeight,
        child: Center(
          child: Text(
            buttonText,
            style: const TextStyle(
              fontSize: 15,
            ),
          ),
        ),
      ),
    );
  }

  double calculateMaxButtonWidth(BuildContext context) {
    final editButtonWidth =
        calculateTextWidth(AppLocalizations.of(context)!.edit);
    final deleteButtonWidth =
        calculateTextWidth(AppLocalizations.of(context)!.delete);

    return editButtonWidth > deleteButtonWidth
        ? editButtonWidth
        : deleteButtonWidth;
  }

  double calculateTextWidth(String text) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(text: text),
      textDirection: TextDirection.ltr,
    )..layout();
    return textPainter.width + 40;
  }
}
