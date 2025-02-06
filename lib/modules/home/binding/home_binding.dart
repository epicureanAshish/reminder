import 'package:reminder/modules/home/controller/home_controller.dart';
import 'package:get/get.dart';
import 'package:reminder/services/reminders_service.dart';

class HomeBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(()=>HomeController());
    Get.put(HiveDBService(), permanent: true);

  }

}