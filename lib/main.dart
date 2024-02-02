import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:system_theme/system_theme.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:systolic/models/entry_database.dart';
import 'package:systolic/pages/entries_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EntryDatabase.initialize();
  SystemTheme.fallbackColor = Colors.grey;
  await SystemTheme.accentColor.load();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => EntryDatabase()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    var statusBarText =
        brightness == Brightness.dark ? Brightness.light : Brightness.dark;

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.transparent,
      ),
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const EntriesPage(),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: SystemTheme.accentColor.accent,
          brightness: brightness,
        ),
        fontFamily: GoogleFonts.figtree().fontFamily,
        appBarTheme: AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarBrightness: statusBarText,
            statusBarIconBrightness: statusBarText,
          ),
          elevation: 0,
          scrolledUnderElevation: 0,
          backgroundColor: Colors.transparent,
        ),
      ),
    );
  }
}
