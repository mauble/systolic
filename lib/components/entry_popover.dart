import 'package:flutter/material.dart';

class EntryPopover extends StatelessWidget {
  final void Function()? onEditTap;
  final void Function()? onDeleteTap;

  const EntryPopover({
    super.key,
    required this.onEditTap,
    required this.onDeleteTap,
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
          child: const SizedBox(
            height: 45,
            child: Center(child: Text("Edit")),
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
            onDeleteTap!();
          },
          child: const SizedBox(
            height: 45,
            child: Center(child: Text("Delete")),
          ),
        ),
      ],
    );
  }
}
