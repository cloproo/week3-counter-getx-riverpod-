import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../widgets/counter_dashboard.dart';
import 'riverpod_counter_controller.dart';

class RiverpodCounterPage extends ConsumerWidget {
  const RiverpodCounterPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(riverpodCounterProvider);
    final controller = ref.read(riverpodCounterProvider.notifier);

    return CounterDashboard(
      frameworkName: 'إدارة الحالة باستخدام Riverpod 2.x',
      count: state.count,
      elapsedSeconds: state.elapsedSeconds,
      isRunning: state.isRunning,
      lifecycleState: state.lifecycleState.name,
      onIncrement: controller.increment,
      onDecrement: controller.decrement,
      onStart: controller.startTimer,
      onPause: controller.pauseTimer,
      onReset: controller.resetAll,
    );
  }
}
