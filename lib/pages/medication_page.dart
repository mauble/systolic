import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:systolic/models/medication/medication.dart';
import 'package:systolic/models/medication/medication_db.dart';
import 'package:systolic/components/medication_tile.dart';
import 'package:systolic/components/page_template.dart';

class MedicationPage extends StatefulWidget {
  const MedicationPage({super.key});

  @override
  State<MedicationPage> createState() => _MedicationPageState();
}

class _MedicationPageState extends State<MedicationPage> {
  final nameController = TextEditingController();
  final dosageController = TextEditingController();
  final unitController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<MedicationDB>().fetch();
  }

  void cancelDialog() {
    Navigator.pop(context);
    nameController.clear();
    dosageController.clear();
    unitController.clear();
  }

  void updateDialog(int id) {
    String name = nameController.text;
    int dosage = int.tryParse(dosageController.text) ?? 0;
    String unit = unitController.text;

    if (name != '' && dosage != 0 && unit != '') {
      context.read<MedicationDB>().update(id, name, dosage, unit);
      cancelDialog();
    }
  }

  void saveDialog() {
    String name = nameController.text;
    int dosage = int.tryParse(dosageController.text) ?? 0;
    String unit = unitController.text;

    if (name != '' && dosage != 0 && unit != '') {
      context.read<MedicationDB>().add(name, dosage, unit);
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
              controller: nameController,
              textInputAction: TextInputAction.next,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.singleLineFormatter,
                LengthLimitingTextInputFormatter(20),
              ],
              decoration:
                  InputDecoration(hintText: AppLocalizations.of(context)!.name),
            ),
            TextField(
              controller: dosageController,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(5),
              ],
              decoration: InputDecoration(
                  hintText: AppLocalizations.of(context)!.dosage),
            ),
            TextField(
              controller: unitController,
              textInputAction: TextInputAction.next,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.singleLineFormatter,
                LengthLimitingTextInputFormatter(10),
              ],
              decoration:
                  InputDecoration(hintText: AppLocalizations.of(context)!.unit),
            ),
          ],
        ),
        actions: [
          MaterialButton(
            onPressed: cancelDialog,
            child: Text(AppLocalizations.of(context)!.cancel),
          ),
          operation,
        ],
      ),
    );
  }

  void updateEntry(Medication medication) {
    nameController.text = medication.name;
    dosageController.text = medication.dosage.toString();
    unitController.text = medication.unit;

    entryDialog(
        AppLocalizations.of(context)!.editMedication,
        MaterialButton(
          onPressed: () => updateDialog(medication.id),
          child: Text(AppLocalizations.of(context)!.edit),
        ));
  }

  void createEntry() {
    entryDialog(
        AppLocalizations.of(context)!.addMedication,
        MaterialButton(
          onPressed: saveDialog,
          child: Text(AppLocalizations.of(context)!.save),
        ));
  }

  void deleteEntry(int id) {
    context.read<MedicationDB>().delete(id);
  }

  List<Medication> sortEntriesByTime(List<Medication> entries) {
    entries.sort((a, b) => b.time.compareTo(a.time));
    return entries;
  }

  @override
  Widget build(BuildContext context) {
    final entryDatabase = context.watch<MedicationDB>();
    List<Medication> currentEntries = entryDatabase.content;

    return PageTemplate(
      floatingActionButton: FloatingActionButton(
        onPressed: createEntry,
        child: const Icon(Icons.add),
      ),
      pageTitle: AppLocalizations.of(context)!.medication,
      pageContent: currentEntries.isEmpty
          ? SizedBox(
              height: MediaQuery.of(context).size.height * 0.6,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 25,
                    right: 25,
                  ),
                  child: Text(
                    AppLocalizations.of(context)!.noMedication,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
            )
          : Expanded(
              child: ListView.builder(
                itemCount: currentEntries.length,
                itemBuilder: (context, index) {
                  final entry = currentEntries[index];
                  return MedicationTile(
                    entry: entry,
                    onEditTap: () => updateEntry(entry),
                    onDeleteTap: () => deleteEntry(entry.id),
                  );
                },
              ),
            ),
    );
  }
}
