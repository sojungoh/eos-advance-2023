import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../widget/clock_widget.dart';
import 'package:flutter_practice/view/login_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var auth = FirebaseAuth.instance;
    print(auth.currentUser?.email);
    return Scaffold(
      backgroundColor: const Color(0xFFffffff),
      appBar: AppBar(
        title: const Text(
          'EOS 시계 앱',
          style: TextStyle(fontSize: 25),
        ),
        actions: [
          IconButton(
            onPressed: () {
              auth.signOut();
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                  (route) => false);
            },
            icon: const Icon(Icons.exit_to_app_rounded, color: Colors.white),
          ),
        ],
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
