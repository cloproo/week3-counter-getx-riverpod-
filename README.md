# Week 3 Assignment – Counter App (GetX vs Riverpod)

A Flutter application that implements the same interactive counter and timer twice, using two state-management approaches:

- **GetX:** `GetxController` with reactive variables and `Obx`.
- **Riverpod 2.x:** `StateNotifier`, `StateNotifierProvider`, and `ConsumerWidget`.

Both tabs provide the same features so the two approaches can be compared fairly.

## Features

- Increase and decrease the counter.
- Start and pause the elapsed-time timer.
- Reset the counter and timer.
- Observe Flutter application lifecycle changes through `WidgetsBindingObserver`.
- Automatically pause the timer when the application is no longer resumed (for example, when it moves to the background).
- Display the current lifecycle state in the interface.

## Project structure

```text
lib/
├── main.dart
├── getx/
│   ├── getx_counter_controller.dart
│   └── getx_counter_page.dart
├── riverpod/
│   ├── riverpod_counter_controller.dart
│   └── riverpod_counter_page.dart
├── screens/
│   └── home_page.dart
└── widgets/
    └── counter_dashboard.dart
```

## Requirements

- Flutter SDK (Dart 3.5 or newer)
- GetX 4.7.2
- Flutter Riverpod 2.6.1

## Run the project

1. Open this folder in VS Code or Android Studio.
2. If you received only the source files and the platform folders are missing, generate them once with `flutter create --platforms=android,ios,web .`.
3. Open a terminal in the project folder and run:

```bash
flutter pub get
flutter run
```

Use the **GetX** and **Riverpod** tabs at the top to switch between the two implementations.

## State-management notes

### GetX implementation

`GetxCounterController` stores the counter, elapsed seconds, timer status, and lifecycle state in observable values (`RxInt`, `RxBool`, and `RxString`). The page uses `Obx` to rebuild the dashboard when an observed value changes.

### Riverpod implementation

`RiverpodCounterState` is an immutable state object. `RiverpodCounterController` extends `StateNotifier` and updates state with `copyWith`. The page is a `ConsumerWidget`; it watches the provider to rebuild when the state changes and reads the notifier to call actions.

### Application lifecycle

Both controllers implement `WidgetsBindingObserver`. When the lifecycle state changes to anything other than `resumed`, the timer is cancelled and its running state becomes false. The elapsed time is preserved, so the user can resume the timer after returning to the app.

## Before submission

Run `flutter pub get`, `flutter analyze`, and (optionally) `flutter test` on your machine. The Arabic implementation report and lifecycle analysis are available in [REPORT_AR.md](REPORT_AR.md).
