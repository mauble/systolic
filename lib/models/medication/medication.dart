import 'package:isar/isar.dart';

// dart run build_runner build
part 'medication.g.dart';

@Collection()
class Medication {
  Id id = Isar.autoIncrement;
  late int time;
  late String name;
  late int dosage;
  late String unit;
}
