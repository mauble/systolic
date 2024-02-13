import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:isar/isar.dart';

import 'package:systolic/models/medication/medication.dart';

class MedicationDB extends ChangeNotifier {
  static late Isar isar;
  final List<Medication> content = [];

  static Future<void> initialize() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open(
      [MedicationSchema],
      name: 'MedicationSchema',
      directory: dir.path,
    );
  }

  Future<void> fetch() async {
    List<Medication> fetched = await isar.medications.where().findAll();
    content.clear();
    content.addAll(fetched);
    notifyListeners();
  }

  Future<void> add(String name, int dosage, String unit) async {
    final newMedication = Medication()
      ..time = DateTime.now().millisecondsSinceEpoch
      ..name = name
      ..dosage = dosage
      ..unit = unit;
    await isar.writeTxn(() => isar.medications.put(newMedication));
    await fetch();
  }

  Future<void> update(int id, String name, int dosage, String unit) async {
    final existingMedication = await isar.medications.get(id);
    if (existingMedication != null) {
      existingMedication.name = name;
      existingMedication.dosage = dosage;
      existingMedication.unit = unit;
      await isar.writeTxn(() => isar.medications.put(existingMedication));
      await fetch();
    }
  }

  Future<void> delete(int id) async {
    await isar.writeTxn(() => isar.medications.delete(id));
    await fetch();
  }
}
