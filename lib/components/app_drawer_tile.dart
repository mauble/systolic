import 'package:flutter/material.dart';

class AppDrawerTile extends StatelessWidget {
  final String title;
  final Widget leading;
  final void Function()? onTap;

  const AppDrawerTile({
    super.key,
    required this.title,
    required this.leading,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      leading: leading,
      onTap: onTap,
    );
  }
}
