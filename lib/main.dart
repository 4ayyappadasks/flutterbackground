import 'package:background/ui.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

import 'bgservicd.dart';
import 'bgservicecontroller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initilizeservice(); // ⬅️ must happen BEFORE any controller

  Get.put(BGController()); // ⬅️ now it's safe
  if (await Permission.notification.isDenied) {
    await Permission.notification.request();
  }
  runApp(const MyApp());
}




class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MYwidget(),
    );
  }
}
