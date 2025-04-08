import 'dart:developer';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_background_service/flutter_background_service.dart';

class BGController extends GetxController {
  final service = FlutterBackgroundService();
  var isRunning = false.obs;

  // DO NOT CALL checkServiceStatus() here anymore
  @override
  void onInit() {
    super.onInit();
  }

  Future<void> checkServiceStatus() async {
    isRunning.value = await service.isRunning();
  }

  Future<void> startService() async {
    await service.startService();
    service.invoke("setAsForeground");
    await checkServiceStatus();
  }

  Future<void> stopService() async {
    if (isRunning.value) {
      service.invoke("stopService");
      isRunning.value = false;
    }
  }

  Future<void> apicall() async {
    var response = await http.get(Uri.parse("https://dummyjson.com/products/1"));
    log("response = ${response.body}");
  }
}
