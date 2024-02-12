import 'package:isar/isar.dart';

// dart run build_runner build
part 'medicine.g.dart';

@Collection()
class Medicine {
  Id id = Isar.autoIncrement;
  late String name;
  late int dosage;
  late int time;
}
