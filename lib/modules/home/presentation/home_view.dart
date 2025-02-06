
import 'package:alarm/alarm.dart';
import 'package:reminder/constants/app_assets.dart';
import 'package:reminder/models/reminder_model.dart';
import 'package:reminder/modules/home/controller/home_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:reminder/services/reminders_service.dart';

class HomeView extends GetView<HomeController> {
  HomeView({super.key});

  var serviceController= Get.find<HiveDBService>();
   
  
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: controller.animationController,
        builder: (BuildContext context, Widget? child) {
        return Scaffold(
          backgroundColor: Colors.lightBlueAccent,
          body:AnimatedContainer(
            width: Get.width,
                height: Get.height,
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    Color.alphaBlend(Colors.blue.withOpacity(
                        (controller.animation.value.toPrecision(1)<0.7
                            ?controller.animation.value.toPrecision(1)+0.4:1.6-controller.animation.value.toPrecision(1)).toPrecision(1)
                    ), Colors.black),
                    Color.alphaBlend(Colors.deepOrange.withOpacity(
                        (controller.animation.value.toPrecision(1)<0.7
                            ?controller.animation.value.toPrecision(1)+0.4:1.6-controller.animation.value.toPrecision(1)).toPrecision(1)
                    ), Colors.black)
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  ),
                ),
                duration: const Duration(milliseconds: 500),
                child: Stack(
                  children: [
                    _sun(controller.animation.value),
                    _morningMoon(controller.animation.value),
                    _nightMoon(controller.animation.value),
                    _cloud1(controller.animation.value),
                    _cloud2(controller.animation.value),
                    _cloud3(controller.animation.value),
                    _sceneryMountain1(controller.animation.value),
                    _sceneryMountain2(controller.animation.value),
                    // _remindersList()
                    // _setReminderBox()


                  ],
                ),
              ),
          bottomSheet: BottomSheet(
            constraints: const BoxConstraints(
              minHeight:300
            ),
              enableDrag: true,
              onClosing: (){}, builder: (context)=>_remindersList()),
        );
      }
    );
  }

  Positioned _sun(animationValue){
    return Positioned(
      left: animationValue*1.5*(Get.width-(Get.width*0.6)),
      bottom:animationValue *(Get.height-(Get.height*0.05))+150,
      child: Image.asset(
        AppAssets.sunIcon,
        height: 200,
        width: 200,
      ),
    );
  }

  Positioned _morningMoon(double animationValue){
    return Positioned(
      left: animationValue*2*Get.width,
      bottom:300+ animationValue*2 *Get.height,
      child: Image.asset(
        AppAssets.moonIcon,
        height: 200,
        width: 200,
      ),
    );
  }

  Positioned _nightMoon(double animationValue){
    return Positioned(
      left:animationValue<0.6?-200:
      (animationValue*1.1*Get.width)-Get.width,
      bottom: Get.height*0.3+(animationValue*200),
       child: Image.asset(
        AppAssets.moonIcon,
        height: 200,
        width: 200,
      ),
    );
  }

  Positioned _sceneryMountain1(animationValue){
    return Positioned(
        right: -250,
        bottom: -50,
        child: Image.asset(AppAssets.mountainsIcon, height: 600,width: 600, fit: BoxFit.cover,));
  }

  Positioned _sceneryMountain2(animationValue){
    return  Positioned(
        left: -180,
        bottom: -100,
        child: Image.asset(AppAssets.mountainsIcon, height: 600,width: 600, fit: BoxFit.cover,));
  }

  Positioned _cloud1(double animationValue){
    return Positioned(top: 100 , left: 10-(animationValue*500), child: Image.asset(AppAssets.cloudsIcon, height: 100,));
  }

  Positioned _cloud2(double animationValue){
    return Positioned(left: 200-(animationValue*500),child: Image.asset(AppAssets.cloudsIcon, height: 100,));
  }

  Positioned _cloud3(animationValue){
    return Positioned(top: 100 , left: Get.width*1.3-(animationValue*500), child: Image.asset(AppAssets.cloudsIcon, height: 100,));
  }

  Widget _setReminderBox(){
    return AlertDialog(

      backgroundColor: Colors.transparent,
      content: Obx(
          ()=> Center(
          child: Container(
            padding: const EdgeInsets.all(20),
            alignment: Alignment.center,
            width: Get.width*0.8,
            height: 250,
            decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    spreadRadius: 5
                  )
                ],
                borderRadius: BorderRadius.circular(20)
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Expanded(child: Text("Set Reminder", style: TextStyle(fontWeight: FontWeight.w900, fontSize: 22),)),
              IconButton(
                  style: IconButton.styleFrom(
                      fixedSize: const Size(40, 40),
                      shadowColor: Colors.black,elevation: 10,
                      side: BorderSide(color: Colors.blue.shade300),
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
                  ),
                  onPressed: () async {
                    // if(controller.editAlarm.value){
                      controller.setReminder();
                    // }
                    // controller.editAlarm.value =!controller.editAlarm.value;


                  }, icon: Icon(controller.editAlarm.value?Icons.done:Icons.edit, color: Colors.white,)),

                  ],
                ),
                const Divider(color: Colors.black26,).marginOnly(bottom: 10),
                TextField(
                  controller: controller.reminderTextEditingController,
                  decoration: InputDecoration(
                    hintText: "Add reminder text here",
                    hintStyle: TextStyle(color: Colors.grey.shade600),
                    fillColor: Colors.grey.shade100,
                    filled: true,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Colors.transparent)),
                    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Colors.transparent)),
                    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Colors.transparent)),
                  ),
                ).marginOnly(bottom: 20),

                Expanded(
                  child: CupertinoDatePicker(
                    initialDateTime: controller.alarmTime,
                    minimumDate: controller.alarmTime,
                      mode: CupertinoDatePickerMode.time,
                      backgroundColor: Colors.white,
                      onDateTimeChanged: (value){
                        controller.tempTime=value;
                        if(controller.timeSelected.value != value.hour / 24) {
                            controller.timeSelected.value = value.hour / 24;
                            if (controller.timeSelected > controller.animation.value) {
                              controller.animationController.forward();
                            } else {
                              controller.animationController.reverse();
                            }
                        }
                      }
                      ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _remindersList(){
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Obx(
            ()=> Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Expanded(child: Text("Reminders", style: TextStyle(fontWeight: FontWeight.w900, fontSize: 22),)),
                    IconButton(
                        style: IconButton.styleFrom(
                            fixedSize: const Size(40, 40),
                            shadowColor: Colors.black,elevation: 10,
                            side: BorderSide(color: Colors.blue.shade300),
                            backgroundColor: Colors.blue,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
                        ),
                        onPressed: () async {
                          Get.dialog(_setReminderBox());

                        }, icon: const Icon(Icons.edit, color: Colors.white,)),

                  ],
                ),
                const Divider(),
                controller.remindersList.toList().isEmpty
                    ? const SizedBox(
                    height: 200,
                    child: Center(child: Text("No reminders added")))
                    : ListView.separated(
                  itemCount: controller.remindersList.toList().length,
                    shrinkWrap: true,
                    separatorBuilder: (context, index)=> const SizedBox(height: 10,),
                    itemBuilder: (context, index){
                    ReminderModel item = controller.remindersList.toList()[index];
                      return ListTile(
                        tileColor: Colors.grey.shade300,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        title: Text(
                          DateFormat("hh:mm a").format(
                              (DateTime.fromMillisecondsSinceEpoch(int.parse(item.timeStamp??"")))),
                          style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 18
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(item.reminderTitle??"", style: const TextStyle(fontWeight: FontWeight.w500),),
                            Text(item.reminderMessage??""),
                          ],
                        ),
                        trailing: PopupMenuButton(itemBuilder: (context){
                          return [
                            // const PopupMenuItem(value: 1,child: Text("Edit"),),
                            const PopupMenuItem(value: 2,child: Text("Delete"),),
                          ];
                        },
                          onSelected: (value){
                          switch(value){
                            case 1:

                              break;
                            case 2:
                              controller.removeReminder(item.id!);
                              break;
                          }
                          },
                        child: const Icon(Icons.more_vert),
                        ),
                      );
                    })
              ],
            ),
      ),
    );  }


}






