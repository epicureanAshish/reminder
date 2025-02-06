
import 'package:reminder/modules/splash/controller/splash_controller.dart';
import 'package:get/get.dart';
import 'package:reminder/services/reminders_service.dart';

class SplashBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(()=>SplashController());
  }
}