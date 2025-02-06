
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:reminder/models/reminder_model.dart';

class HiveDBService extends GetxService {

  final Box<ReminderModel> reminderBox = Hive.box<ReminderModel>('remindersBox');

  List<ReminderModel> getReminders(){
    return reminderBox.values.toList();
  }
  
  Future<void> addReminder(ReminderModel reminder) async {
      await reminderBox.put(reminder.id, reminder);
   }
  Future<void> removeReminder(int alarmId) async {
    await reminderBox.delete(alarmId);
  }

  bool checkIfCartContainsItemEvent(ReminderModel reminder){
    return reminderBox.containsKey(reminder.id);
  }
}