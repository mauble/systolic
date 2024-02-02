import 'package:isar/isar.dart';

// dart run build_runner build
part 'entry.g.dart';

@Collection()
class Entry {
  Id id = Isar.autoIncrement;
  late int systole;
  late int diastole;
  late int pulse;
  late int time;
}
