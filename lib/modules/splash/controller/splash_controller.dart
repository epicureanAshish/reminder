
import 'package:reminder/modules/home/presentation/home_view.dart';
import 'package:get/get.dart';

class SplashController extends GetxController{


  @override
  void onReady() {
    Future.delayed(const Duration(seconds: 2),(){
      Get.toNamed("/home");
    });
    super.onReady();
  }


}