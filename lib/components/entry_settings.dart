import 'package:flutter/material.dart';

class EntrySettings extends StatelessWidget {
  final void Function()? onEditTap;
  final void Function()? onDeleteTap;
  const EntrySettings({
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
            height: 50,
            child: Center(child: Text("Edit")),
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
            onDeleteTap!();
          },
          child: const SizedBox(
            height: 50,
            child: Center(child: Text("Delete")),
          ),
        ),
      ],
    );
  }
}
