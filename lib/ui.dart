import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:background/bgservicecontroller.dart';
import 'bgservicd.dart';

class MYwidget extends StatelessWidget {
  const MYwidget({super.key});

  @override
  Widget build(BuildContext context) {
    final BGController controller = Get.put(BGController());

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                await initilizeservice();
                await controller.startService();
              },
              child: const Text("Foreground"),
            ),
            ElevatedButton(
              onPressed: () async {
                await controller.stopService();
              },
              child: const Text("Stop Service"),
            ),
            const SizedBox(height: 20),
            Obx(() => Text("Service is ${controller.isRunning.value ? "Running" : "Stopped"}")),
          ],
        ),
      ),
    );
  }
}
