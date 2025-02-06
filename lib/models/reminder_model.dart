
import 'package:hive/hive.dart';

part 'reminder_model.g.dart';

@HiveType(typeId: 0)
class ReminderModel{
  @HiveField(0)
  int? id;
  @HiveField(1)
  String? timeStamp;
  @HiveField(2)
  String? reminderTitle;
  @HiveField(3)
  String? reminderMessage;

  ReminderModel({this.id, this.timeStamp, this.reminderTitle, this.reminderMessage});
}