import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:isar/isar.dart';

import 'package:systolic/models/medicine/medicine.dart';

class MedicineDB extends ChangeNotifier {
  static late Isar isar;
  final List<Medicine> content = [];

  static Future<void> initialize() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open(
      [MedicineSchema],
      directory: dir.path,
    );
  }

  Future<void> fetch() async {
    List<Medicine> fetched = await isar.medicines.where().findAll();
    content.clear();
    content.addAll(fetched);
    notifyListeners();
  }

  Future<void> add(String name, int dosage) async {
    final newMedicine = Medicine()
      ..name = name
      ..dosage = dosage
      ..time = DateTime.now().millisecondsSinceEpoch;
    await isar.writeTxn(() => isar.medicines.put(newMedicine));
    fetch();
  }

  Future<void> update(int id, String name, int dosage) async {
    final existingMedicine = await isar.medicines.get(id);
    if (existingMedicine != null) {
      existingMedicine.name = name;
      existingMedicine.dosage = dosage;
      await isar.writeTxn(() => isar.medicines.put(existingMedicine));
      await fetch();
    }
  }

  Future<void> deleteMedicine(int id) async {
    await isar.writeTxn(() => isar.medicines.delete(id));
    await fetch();
  }
}
