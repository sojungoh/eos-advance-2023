import 'package:flutter/material.dart';
import '../widget/clock_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFffffff),
      appBar: AppBar(
        title: Text('EOS 시계 앱'),
        leading: Icon(Icons.access_time_filled),
      ),
      body: SafeArea(
        child: Column(
          // Todo: crossAxisAlignment
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(flex: 2),
            Image.asset('assets/images/eos_logo.png', height: 280),
            const Spacer(),
            ClockWidget(),
            Spacer(flex: 2),
          ],
        )
      )
    );
  }
}
