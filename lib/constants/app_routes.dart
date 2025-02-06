
import 'package:reminder/modules/home/binding/home_binding.dart';
import 'package:reminder/modules/home/presentation/home_view.dart';
import 'package:reminder/modules/splash/binding/splash_binding.dart';
import 'package:reminder/modules/splash/presentation/splash_view.dart';
import 'package:get/get.dart';

class AppRoutes{


  static List<GetPage<dynamic>> appRoutes =[
    GetPage(name: "/splash", page: ()=> const SplashView(), binding: SplashBinding()),
    GetPage(name: "/home", page: ()=> HomeView(), binding: HomeBinding()),
  ];


}