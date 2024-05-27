import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OptionsTile extends StatefulWidget {
  final String id;
  final String title;

  const OptionsTile({
    super.key,
    required this.id,
    required this.title,
  });

  @override
  State<OptionsTile> createState() => _OptionsTileState();
}

class _OptionsTileState extends State<OptionsTile> {
  late Future<SharedPreferences> prefsFuture;

  @override
  void initState() {
    super.initState();
    prefsFuture = _loadPreferences();
  }

  Future<SharedPreferences> _loadPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: prefsFuture,
      builder:
          (BuildContext context, AsyncSnapshot<SharedPreferences> snapshot) {
        if (snapshot.connectionState != ConnectionState.waiting) {
          final SharedPreferences prefs = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.only(bottom: 20, left: 15, right: 15),
            child: Material(
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(16),
              clipBehavior: Clip.antiAlias,
              child: SwitchListTile(
                contentPadding: const EdgeInsets.only(left: 15, right: 10),
                title: Text(widget.title),
                value: prefs.getBool(widget.id) ?? false,
                onChanged: (bool value) {
                  setState(() {
                    prefs.setBool(widget.id, value);
                  });
                },
              ),
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
