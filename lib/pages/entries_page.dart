import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:systolic/components/entry_tile.dart';
import 'package:systolic/models/entry_database.dart';
import 'package:systolic/models/entry.dart';

class EntriesPage extends StatefulWidget {
  const EntriesPage({super.key});

  @override
  State<EntriesPage> createState() => _EntriesPageState();
}

class _EntriesPageState extends State<EntriesPage> {
  final systoleController = TextEditingController();
  final diastoleController = TextEditingController();
  final pulseController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<EntryDatabase>().fetchEntries();
  }

  void cancelDialog() {
    systoleController.clear();
    diastoleController.clear();
    pulseController.clear();
    Navigator.pop(context);
  }

  void updateDialog(int id) {
    context.read<EntryDatabase>().updateEntry(
        id,
        int.tryParse(systoleController.text) ?? 0,
        int.tryParse(diastoleController.text) ?? 0,
        int.tryParse(pulseController.text) ?? 0);
    cancelDialog();
  }

  void saveDialog() {
    context.read<EntryDatabase>().addEntry(
        int.tryParse(systoleController.text) ?? 0,
        int.tryParse(diastoleController.text) ?? 0,
        int.tryParse(pulseController.text) ?? 0);
    cancelDialog();
  }

  void entryDialog(String title, MaterialButton operation) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: systoleController,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(3),
              ],
              decoration: const InputDecoration(hintText: 'Systole'),
            ),
            TextField(
              controller: diastoleController,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(3),
              ],
              decoration: const InputDecoration(hintText: 'Diastole'),
            ),
            TextField(
              controller: pulseController,
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(3),
              ],
              decoration: const InputDecoration(hintText: 'Pulse'),
            ),
          ],
        ),
        actions: [
          MaterialButton(
            onPressed: cancelDialog,
            child: const Text('Cancel'),
          ),
          operation,
        ],
      ),
    );
  }

  void updateEntry(Entry entry) {
    systoleController.text = entry.systole.toString();
    diastoleController.text = entry.diastole.toString();
    pulseController.text = entry.pulse.toString();

    entryDialog(
        "Edit entry",
        MaterialButton(
          onPressed: () => updateDialog(entry.id),
          child: const Text("Edit"),
        ));
  }

  void createEntry() {
    entryDialog(
        "Add new entry",
        MaterialButton(
          onPressed: saveDialog,
          child: const Text("Save"),
        ));
  }

  void deleteEntry(int id) {
    context.read<EntryDatabase>().deleteEntry(id);
  }

  @override
  Widget build(BuildContext context) {
    final entryDatabase = context.watch<EntryDatabase>();

    List<Entry> currentEntries = entryDatabase.currentEntries;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createEntry,
        child: const Icon(Icons.add),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 20, left: 22),
            child: Text(
              "Overview",
              style: GoogleFonts.dmSerifText(
                fontSize: 36,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: currentEntries.length,
              itemBuilder: (context, index) {
                final entry = currentEntries[index];
                return EntryTile(
                  entry: entry,
                  onEditTap: () => updateEntry(entry),
                  onDeleteTap: () => deleteEntry(entry.id),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
