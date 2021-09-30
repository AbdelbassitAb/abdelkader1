import 'package:abdelkader1/controllers/controllers.dart';
import 'package:abdelkader1/ui/ui.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();
  Get.put<AuthController>(AuthController());
  Get.put<DataBaseController>(DataBaseController());
  runApp(TestApp());

}


class TestApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: Scaffold(
        drawer: MainDrawer(

        ),
        body: Home(),
      ),
    );
  }
}

