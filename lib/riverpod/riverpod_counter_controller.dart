import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final riverpodCounterProvider = StateNotifierProvider<
    RiverpodCounterController, RiverpodCounterState>(
  (ref) => RiverpodCounterController(),
);

class RiverpodCounterState {
  const RiverpodCounterState({
    this.count = 0,
    this.elapsedSeconds = 0,
    this.isRunning = false,
    this.lifecycleState = AppLifecycleState.resumed,
  });

  final int count;
  final int elapsedSeconds;
  final bool isRunning;
  final AppLifecycleState lifecycleState;

  RiverpodCounterState copyWith({
    int? count,
    int? elapsedSeconds,
    bool? isRunning,
    AppLifecycleState? lifecycleState,
  }) {
    return RiverpodCounterState(
      count: count ?? this.count,
      elapsedSeconds: elapsedSeconds ?? this.elapsedSeconds,
      isRunning: isRunning ?? this.isRunning,
      lifecycleState: lifecycleState ?? this.lifecycleState,
    );
  }
}

class RiverpodCounterController extends StateNotifier<RiverpodCounterState>
    with WidgetsBindingObserver {
  RiverpodCounterController() : super(const RiverpodCounterState()) {
    WidgetsBinding.instance.addObserver(this);
  }

  Timer? _timer;

  void increment() {
    state = state.copyWith(count: state.count + 1);
  }

  void decrement() {
    state = state.copyWith(count: state.count - 1);
  }

  void startTimer() {
    if (state.isRunning) return;

    state = state.copyWith(isRunning: true);
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      state = state.copyWith(elapsedSeconds: state.elapsedSeconds + 1);
    });
  }

  void pauseTimer() {
    _timer?.cancel();
    _timer = null;
    if (state.isRunning) {
      state = state.copyWith(isRunning: false);
    }
  }

  void resetAll() {
    pauseTimer();
    state = state.copyWith(count: 0, elapsedSeconds: 0, isRunning: false);
  }

 @override
void didChangeAppLifecycleState(AppLifecycleState state) {
  this.state = this.state.copyWith(lifecycleState: state);

  if (state != AppLifecycleState.resumed) {
    pauseTimer();
  }
}

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _timer?.cancel();
    super.dispose();
  }
}
