import 'package:flutter/material.dart';

import 'package:systolic/main.dart';
import 'package:systolic/components/app_drawer.dart';

class PageTemplate extends StatelessWidget {
  final Widget? floatingActionButton;
  final String pageTitle;
  final Widget pageContent;

  const PageTemplate({
    super.key,
    this.floatingActionButton,
    required this.pageTitle,
    required this.pageContent,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: floatingActionButton,
      appBar: AppBar(),
      drawer: const AppDrawer(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 20, left: 16),
            child: Text(
              pageTitle,
              style: TextStyle(
                fontFamily: getFont(true),
                fontSize: 34,
              ),
            ),
          ),
          pageContent,
        ],
      ),
    );
  }
}
