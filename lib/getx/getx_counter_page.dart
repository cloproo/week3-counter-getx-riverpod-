import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/counter_dashboard.dart';
import 'getx_counter_controller.dart';

class GetxCounterPage extends StatelessWidget {
  const GetxCounterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<GetxCounterController>();

    return Obx(
      () => CounterDashboard(
        frameworkName: 'إدارة الحالة باستخدام GetX',
        count: controller.count.value,
        elapsedSeconds: controller.elapsedSeconds.value,
        isRunning: controller.isRunning.value,
        lifecycleState: controller.lifecycleState.value,
        onIncrement: controller.increment,
        onDecrement: controller.decrement,
        onStart: controller.startTimer,
        onPause: controller.pauseTimer,
        onReset: controller.resetAll,
      ),
    );
  }
}
