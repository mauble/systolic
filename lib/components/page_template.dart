import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
            padding: const EdgeInsets.only(bottom: 20, left: 18),
            child: Text(
              pageTitle,
              style: GoogleFonts.dmSerifText(
                fontSize: 36,
              ),
            ),
          ),
          pageContent,
        ],
      ),
    );
  }
}
