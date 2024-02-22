import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OptionsTile extends StatefulWidget {
  final String id;
  final String title;

  const OptionsTile({super.key, required this.id, required this.title});

  @override
  State<OptionsTile> createState() => _OptionsTileState();
}

class _OptionsTileState extends State<OptionsTile> {
  late SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    prefs = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceVariant,
        borderRadius: BorderRadius.circular(16),
      ),
      margin: const EdgeInsets.only(bottom: 20, left: 15, right: 15),
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
    );
  }
}
