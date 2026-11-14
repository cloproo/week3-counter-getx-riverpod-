import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

import 'getx/getx_counter_controller.dart';
import 'screens/home_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(GetxCounterController(), permanent: true);
  runApp(const ProviderScope(child: CounterComparisonApp()));
}

class CounterComparisonApp extends StatelessWidget {
  const CounterComparisonApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'تطبيق العداد',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF3157A4),
        ),
        scaffoldBackgroundColor: const Color(0xFFF4F6FA),
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          backgroundColor: Color(0xFFF4F6FA),
          foregroundColor: Color(0xFF1D2B45),
          elevation: 0,
        ),
      ),
      home: const HomePage(),
    );
  }
}
