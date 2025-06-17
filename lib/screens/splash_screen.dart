import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Splash Screen"),
            SizedBox(height: 24),
            ElevatedButton(onPressed: () {
              Navigator.of(context).pushNamed('/login');
            }, child: const Text("Login")),
          ],
        ),
      ),
    );
  }
}
