import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:isar/isar.dart';

import 'package:systolic/models/entry/entry.dart';

class EntryDatabase extends ChangeNotifier {
  static late Isar isar;
  final List<Entry> currentEntries = [];

  static Future<void> initialize() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open(
      [EntrySchema],
      directory: dir.path,
    );
  }

  Future<void> fetchEntries() async {
    List<Entry> fetchedEntries = await isar.entrys.where().findAll();
    currentEntries.clear();
    currentEntries.addAll(fetchedEntries);
    notifyListeners();
  }

  Future<void> addEntry(int systole, int diastole, int pulse) async {
    final newEntry = Entry()
      ..systole = systole
      ..diastole = diastole
      ..pulse = pulse
      ..time = DateTime.now().millisecondsSinceEpoch;
    await isar.writeTxn(() => isar.entrys.put(newEntry));

    fetchEntries();
  }

  Future<void> updateEntry(int id, int systole, int diastole, int pulse) async {
    final existingEntry = await isar.entrys.get(id);
    if (existingEntry != null) {
      existingEntry.systole = systole;
      existingEntry.diastole = diastole;
      existingEntry.pulse = pulse;
      await isar.writeTxn(() => isar.entrys.put(existingEntry));
      await fetchEntries();
    }
  }

  Future<void> deleteEntry(int id) async {
    await isar.writeTxn(() => isar.entrys.delete(id));
    await fetchEntries();
  }
}
