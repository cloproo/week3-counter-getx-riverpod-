import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class GetxCounterController extends GetxController with WidgetsBindingObserver {
  final RxInt count = 0.obs;
  final RxInt elapsedSeconds = 0.obs;
  final RxBool isRunning = false.obs;
  final RxString lifecycleState = 'resumed'.obs;

  Timer? _timer;

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addObserver(this);
  }

  void increment() => count.value++;

  void decrement() => count.value--;

  void startTimer() {
    if (isRunning.value) return;

    isRunning.value = true;
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      elapsedSeconds.value++;
    });
  }

  void pauseTimer() {
    _timer?.cancel();
    _timer = null;
    isRunning.value = false;
  }

  void resetAll() {
    pauseTimer();
    count.value = 0;
    elapsedSeconds.value = 0;
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    lifecycleState.value = state.name;

    // Pause the timer whenever the app is no longer in the foreground.
    if (state != AppLifecycleState.resumed) {
      pauseTimer();
    }
  }

  @override
  void onClose() {
    WidgetsBinding.instance.removeObserver(this);
    _timer?.cancel();
    super.onClose();
  }
}
