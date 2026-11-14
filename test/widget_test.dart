import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:week3_counter_flutter/getx/getx_counter_controller.dart';
import 'package:week3_counter_flutter/main.dart';

void main() {
  testWidgets('shows both state-management tabs', (tester) async {
    Get.put(GetxCounterController());
    await tester.pumpWidget(const ProviderScope(child: CounterComparisonApp()));

    expect(find.text('GetX'), findsOneWidget);
    expect(find.text('Riverpod'), findsOneWidget);
    expect(find.text('قيمة العداد'), findsOneWidget);
  });
}
