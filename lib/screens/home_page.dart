import 'package:flutter/material.dart';

import '../getx/getx_counter_page.dart';
import '../riverpod/riverpod_counter_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'تطبيق العداد وإدارة الحالة',
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
          ),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'GetX', icon: Icon(Icons.bolt)),
              Tab(text: 'Riverpod', icon: Icon(Icons.account_tree_outlined)),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            GetxCounterPage(),
            RiverpodCounterPage(),
          ],
        ),
      ),
    );
  }
}
