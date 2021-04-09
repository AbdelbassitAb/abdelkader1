import 'package:abdelkader1/ui/ui.dart';
import 'package:get/get.dart';

class AppRoutes {
  AppRoutes._(); //this is to prevent anyone from instantiating this object
  static final routes = [
    GetPage(name: '/home', page: () => Home()),

  ];
}
