import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_yaber/firebase_options.dart';
import 'package:flutter_yaber/src/controller/init_binding.dart';
import 'package:flutter_yaber/src/screens/feed_screen.dart';
import 'package:flutter_yaber/src/screens/login_screen.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final Brightness brightness = MediaQuery.platformBrightnessOf(context);
    bool isDarkMode = brightness == Brightness.dark;
    return GetMaterialApp(
      title: 'Travel Yaber App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(0, 229, 111, 33),
            brightness: isDarkMode ? Brightness.dark : Brightness.light),
      ),
      initialBinding: InitBinding(),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.hasData) {
              // 1. auth 정상
              return FeedScreen();
              // 2. auth 에러
            } else if (snapshot.hasError) {
              return Scaffold(
                body: Center(
                  child: Text(
                    '${snapshot.error}',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: Colors.red),
                  ),
                ),
              );
            }
            // 3. 연결 대기중
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          // 4 auth 정보 없을때

          return LoginScreen();
        },
      ),
    );
  }
}
