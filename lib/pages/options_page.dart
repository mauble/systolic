import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:systolic/components/app_drawer.dart';

class OptionsPage extends StatelessWidget {
  const OptionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: const AppDrawer(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 20, left: 18),
            child: Text(
              "Options",
              style: GoogleFonts.dmSerifText(
                fontSize: 36,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
