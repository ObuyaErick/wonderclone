import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;
import 'package:firebase_ui_auth/firebase_ui_auth.dart';

import 'package:wonderclone/screens/home_screen.dart';
import 'package:wonderclone/screens/loading_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wonder Clone',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.cyanAccent),
        useMaterial3: true,
      ),
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, authSnapshot) {
          if (authSnapshot.connectionState == ConnectionState.waiting) {
            return LoadingScreen();
          } else if (authSnapshot.hasData) {
            return HomeScreen();
          } else if (authSnapshot.hasError) {
            return Scaffold(
              body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('${authSnapshot.error}'),
                  SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () {
                      // Navigator.of(context).pushNamed('/login');
                    },
                    child: const Text("Login"),
                  ),
                ],
              ),
            );
          } else {
            return SignInScreen(providers: [EmailAuthProvider()]);
          }
        },
      ),
    );
  }
}
