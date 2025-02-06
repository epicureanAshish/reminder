
import 'dart:io';
import 'dart:math';

import 'package:alarm/alarm.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:reminder/constants/app_assets.dart';
import 'package:reminder/models/reminder_model.dart';
import 'package:reminder/services/reminders_service.dart';

class HomeController extends GetxController with GetSingleTickerProviderStateMixin{

  late TextEditingController reminderTextEditingController;
  late AnimationController animationController;
  late Animation<double> animation;
  RxDouble timeSelected=RxDouble(0);
  RxBool editAlarm=RxBool(false);
  DateTime alarmTime =DateTime.now();
  DateTime tempTime =DateTime.now();

  RxList<ReminderModel> remindersList=RxList();
  late HiveDBService hiveDBService;

  
  @override
  void onInit() {
    hiveDBService= Get.find<HiveDBService>();
    getRemindersList();
    reminderTextEditingController =TextEditingController();
    animationController = AnimationController(
      duration: const Duration(seconds: 1), // Animation duration
      vsync: this,
    );
    // Tween animation
    animation = Tween<double>(begin: 0.0, end: 1.0).animate(animationController);
    animation.addListener((){
      // setState(() {});
      debugPrint("LISTENER ${animation.value.toPrecision(1)} ${timeSelected.value.toPrecision(1)} ${(animation.value.toPrecision(1)<0.7
          ?animation.value.toPrecision(1)+0.4:1.6-animation.value.toPrecision(1)).toPrecision(1)}");
      if (animation.value.toPrecision(1) == timeSelected.value.toPrecision(1)) {
        animationController.stop(); // Pause at the desired value
      }
    });
    animationController.forward(); // Start the animation

    _checkExactAlarmPermission();
    
    super.onInit();
  }

  @override
  void dispose() {
    reminderTextEditingController.dispose();
    animationController.dispose();
    super.dispose();
  }


  void _checkExactAlarmPermission() async {
    await Permission.notification.request();
    await Permission.scheduleExactAlarm.request();
  }

  void getRemindersList(){
    remindersList.value = hiveDBService.getReminders();
    remindersList.refresh();
  }

  Future<void> setReminder() async {
    Navigator.of(Get.overlayContext!).pop();

    alarmTime=tempTime;
    var alarmId= Random().nextInt(1000);

    final alarmSettings = AlarmSettings(
      id: alarmId,
      dateTime: alarmTime,
      assetAudioPath: AppAssets.alarmAudioPath,
      loopAudio: true,
      vibrate: true,
      volume: 1,
      volumeEnforced: true,
      warningNotificationOnKill: Platform.isIOS,
      androidFullScreenIntent: true,
      notificationSettings: NotificationSettings(
        title: 'Reminder',
        body: reminderTextEditingController.text.trim().isNotEmpty?reminderTextEditingController.text.trim():'This is a reminder',
        stopButton: 'Stop the alarm',
        icon: 'ic_launcher',
      ),
    );

    hiveDBService.addReminder(ReminderModel(
      id: alarmId,
        timeStamp: alarmTime.millisecondsSinceEpoch.toString(),
        reminderTitle: "Reminder",
        reminderMessage: reminderTextEditingController.text.trim().isNotEmpty?reminderTextEditingController.text.trim():'This is a reminder'
    ));

    await Alarm.set(alarmSettings: alarmSettings);


    getRemindersList();




  }

  Future<void> removeReminder(int alarmID) async {
    await Alarm.stop(alarmID);
    await hiveDBService.removeReminder(alarmID);

    getRemindersList();
  }




}