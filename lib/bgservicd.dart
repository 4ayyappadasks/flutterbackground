import 'dart:async';
import 'dart:developer';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:get/get.dart';
import 'package:background/bgservicecontroller.dart';

Future<void> initilizeservice() async {
  final service = FlutterBackgroundService();

  await service.configure(
    iosConfiguration: IosConfiguration(),
    androidConfiguration: AndroidConfiguration(
      onStart: onStart,
      isForegroundMode: true,
      autoStart: true,
      autoStartOnBoot: true,
    ),
  );
}

@pragma('vm:entry-point')
void onStart(ServiceInstance service) async {
  if (service is AndroidServiceInstance) {

    service.on('setAsForeground').listen((event) async {
      await service.setForegroundNotificationInfo(
        title: "Foreground Service",
        content: "Now running in foreground",
      );
      await service.setAsForegroundService();
      log("forground");
      Timer.periodic(Duration(seconds: 1),(timer) {
        var controller = Get.put(BGController());
        controller.apicall();
      },);
    });
  }

  service.on('stopService').listen((event) {
    service.stopSelf();
  });
}
