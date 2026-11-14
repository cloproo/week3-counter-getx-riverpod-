import 'package:flutter/material.dart';

class CounterDashboard extends StatelessWidget {
  const CounterDashboard({
    super.key,
    required this.frameworkName,
    required this.count,
    required this.elapsedSeconds,
    required this.isRunning,
    required this.lifecycleState,
    required this.onIncrement,
    required this.onDecrement,
    required this.onStart,
    required this.onPause,
    required this.onReset,
  });

  final String frameworkName;
  final int count;
  final int elapsedSeconds;
  final bool isRunning;
  final String lifecycleState;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;
  final VoidCallback onStart;
  final VoidCallback onPause;
  final VoidCallback onReset;

  String get formattedTime {
    final hours = elapsedSeconds ~/ 3600;
    final minutes = (elapsedSeconds % 3600) ~/ 60;
    final seconds = elapsedSeconds % 60;
    return '${hours.toString().padLeft(2, '0')}:'
        '${minutes.toString().padLeft(2, '0')}:'
        '${seconds.toString().padLeft(2, '0')}';
  }

  String get lifecycleDescription {
    switch (lifecycleState) {
      case 'resumed':
        return 'التطبيق نشط ويعمل في المقدمة';
      case 'inactive':
        return 'التطبيق غير نشط مؤقتًا';
      case 'paused':
        return 'التطبيق في الخلفية';
      case 'hidden':
        return 'واجهة التطبيق مخفية';
      case 'detached':
        return 'التطبيق غير مرتبط بواجهة النظام';
      default:
        return 'حالة التطبيق: $lifecycleState';
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 620),
          child: ListView(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
            children: [
              Card(
                elevation: 0,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      Text(
                        frameworkName,
                        style: TextStyle(
                          color: colorScheme.primary,
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 18),
                      const Text(
                        'قيمة العداد',
                        style: TextStyle(
                          color: Color(0xFF687386),
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 8),
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 180),
                        child: Text(
                          '$count',
                          key: ValueKey<int>(count),
                          style: TextStyle(
                            color: colorScheme.primary,
                            fontSize: 64,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 22),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _CounterButton(
                            label: 'زيادة',
                            icon: Icons.add,
                            onPressed: onIncrement,
                            backgroundColor: colorScheme.primary,
                          ),
                          const SizedBox(width: 14),
                          _CounterButton(
                            label: 'إنقاص',
                            icon: Icons.remove,
                            onPressed: onDecrement,
                            backgroundColor: const Color(0xFF687386),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Card(
                elevation: 0,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(22),
                  child: Column(
                    children: [
                      const Text(
                        'المؤقت',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        formattedTime,
                        textDirection: TextDirection.ltr,
                        style: const TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 2,
                          color: Color(0xFF253653),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        isRunning ? 'المؤقت يعمل' : 'المؤقت متوقف',
                        style: TextStyle(
                          color: isRunning
                              ? const Color(0xFF23865A)
                              : const Color(0xFF687386),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 18),
                      SizedBox(
                        width: double.infinity,
                        child: FilledButton.icon(
                          onPressed: isRunning ? onPause : onStart,
                          icon: Icon(
                            isRunning ? Icons.pause : Icons.play_arrow,
                          ),
                          label: Text(isRunning ? 'إيقاف مؤقت' : 'تشغيل المؤقت'),
                          style: FilledButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 14),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton.icon(
                          onPressed: onReset,
                          icon: const Icon(Icons.refresh),
                          label: const Text('إعادة ضبط العداد والمؤقت'),
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 13),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Card(
                elevation: 0,
                color: const Color(0xFFEAF0FA),
                child: Padding(
                  padding: const EdgeInsets.all(18),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.phone_android, color: colorScheme.primary),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'تحليل دورة حياة التطبيق',
                              style: TextStyle(fontWeight: FontWeight.w700),
                            ),
                            const SizedBox(height: 6),
                            Text(lifecycleDescription),
                            const SizedBox(height: 6),
                            const Text(
                              'عند انتقال التطبيق إلى الخلفية أو خروجه من الحالة النشطة، يتوقف المؤقت تلقائيًا. يمكن تشغيله مجددًا عند العودة إلى التطبيق.',
                              style: TextStyle(
                                color: Color(0xFF58657A),
                                height: 1.5,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CounterButton extends StatelessWidget {
  const _CounterButton({
    required this.label,
    required this.icon,
    required this.onPressed,
    required this.backgroundColor,
  });

  final String label;
  final IconData icon;
  final VoidCallback onPressed;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return FilledButton.icon(
      onPressed: onPressed,
      icon: Icon(icon),
      label: Text(label),
      style: FilledButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 13),
      ),
    );
  }
}
