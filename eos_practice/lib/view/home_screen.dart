import 'package:flutter/material.dart';
import '../widget/clock_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFffffff),
      appBar: AppBar(
        title: const Text(
          'EOS 시계 앱',
          style: TextStyle(fontSize: 25),
        ),
        leading: const Icon(Icons.access_time_filled),
      ),
      body: SafeArea(
        child: Column(
          // Todo: crossAxisAlignment
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 150),
            Image.asset('assets/images/eos_logo.png', height: 280),
            const Spacer(),
            const ClockWidget(),
            const Spacer(flex: 8),
          ],
        ),
      ),
    );
  }
}
