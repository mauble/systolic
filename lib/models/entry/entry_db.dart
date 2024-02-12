import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:isar/isar.dart';

import 'package:systolic/models/entry/entry.dart';

class EntryDB extends ChangeNotifier {
  static late Isar isar;
  final List<Entry> content = [];

  static Future<void> initialize() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open(
      [EntrySchema],
      directory: dir.path,
    );
  }

  Future<void> fetch() async {
    List<Entry> fetched = await isar.entrys.where().findAll();
    content.clear();
    content.addAll(fetched);
    notifyListeners();
  }

  Future<void> add(int systole, int diastole, int pulse) async {
    final newEntry = Entry()
      ..systole = systole
      ..diastole = diastole
      ..pulse = pulse
      ..time = DateTime.now().millisecondsSinceEpoch;
    await isar.writeTxn(() => isar.entrys.put(newEntry));

    fetch();
  }

  Future<void> update(int id, int systole, int diastole, int pulse) async {
    final existingEntry = await isar.entrys.get(id);
    if (existingEntry != null) {
      existingEntry.systole = systole;
      existingEntry.diastole = diastole;
      existingEntry.pulse = pulse;
      await isar.writeTxn(() => isar.entrys.put(existingEntry));
      await fetch();
    }
  }

  Future<void> delete(int id) async {
    await isar.writeTxn(() => isar.entrys.delete(id));
    await fetch();
  }
}
