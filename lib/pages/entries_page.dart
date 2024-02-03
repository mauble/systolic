import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'package:systolic/models/entry_database.dart';
import 'package:systolic/models/entry.dart';
import 'package:systolic/components/entry_tile.dart';
import 'package:systolic/components/app_drawer.dart';

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
    Navigator.pop(context);
    systoleController.clear();
    diastoleController.clear();
    pulseController.clear();
  }

  void updateDialog(int id) {
    int systole = int.tryParse(systoleController.text) ?? 0;
    int diastole = int.tryParse(diastoleController.text) ?? 0;
    int pulse = int.tryParse(pulseController.text) ?? 0;

    if (systole != 0 && diastole != 0 && pulse != 0) {
      context.read<EntryDatabase>().updateEntry(id, systole, diastole, pulse);
      cancelDialog();
    }
  }

  void saveDialog() {
    int systole = int.tryParse(systoleController.text) ?? 0;
    int diastole = int.tryParse(diastoleController.text) ?? 0;
    int pulse = int.tryParse(pulseController.text) ?? 0;

    if (systole != 0 && diastole != 0 && pulse != 0) {
      context.read<EntryDatabase>().addEntry(systole, diastole, pulse);
      cancelDialog();
    }
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

  List<Entry> sortEntriesByTime(List<Entry> entries) {
    entries.sort((a, b) => b.time.compareTo(a.time));
    return entries;
  }

  Map<String, List<Entry>> groupEntriesByDay(List<Entry> entries) {
    Map<String, List<Entry>> groupedEntries = {};

    entries.sort((a, b) => b.time.compareTo(a.time));

    for (var entry in entries) {
      String dayKey = DateFormat('dd.MM.yyyy')
          .format(DateTime.fromMillisecondsSinceEpoch(entry.time));

      if (groupedEntries.containsKey(dayKey)) {
        groupedEntries[dayKey]!.add(entry);
      } else {
        groupedEntries[dayKey] = [entry];
      }
    }

    return groupedEntries;
  }

  @override
  Widget build(BuildContext context) {
    final entryDatabase = context.watch<EntryDatabase>();

    List<Entry> currentEntries = entryDatabase.currentEntries;

    Map<String, List<Entry>> groupedEntries = groupEntriesByDay(currentEntries);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: createEntry,
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(),
      drawer: const AppDrawer(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 20, left: 18),
            child: Text(
              "Measurements",
              style: GoogleFonts.dmSerifText(
                fontSize: 36,
              ),
            ),
          ),
          currentEntries.isEmpty
              ? SizedBox(
                  height: MediaQuery.of(context).size.height * 0.7,
                  child: const Center(
                    child: Text(
                      'Welcome to Systolic.\n\nTo start, just measure your blood pressure and\nenter your results by clicking the button below.',
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ),
                )
              : Expanded(
                  child: ListView.builder(
                    itemCount: groupedEntries.length,
                    itemBuilder: (context, index) {
                      final List<String> keys = groupedEntries.keys.toList();
                      final String dayKey = keys[index];
                      final List<Entry> entries =
                          sortEntriesByTime(groupedEntries[dayKey]!);

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(bottom: 20, left: 18),
                            child: Text(
                              dayKey,
                              style: const TextStyle(
                                fontSize: 22,
                              ),
                            ),
                          ),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: entries.length,
                            itemBuilder: (context, index) {
                              final entry = entries[index];
                              return EntryTile(
                                entry: entry,
                                onEditTap: () => updateEntry(entry),
                                onDeleteTap: () => deleteEntry(entry.id),
                              );
                            },
                          ),
                        ],
                      );
                    },
                  ),
                ),
        ],
      ),
    );
  }
}
