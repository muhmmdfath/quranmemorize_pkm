import 'package:flutter/material.dart';
import 'routes/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quran App',
      theme: ThemeData(
        primaryColor: const Color(0xff6D9886),
        scaffoldBackgroundColor: const Color(0xffF7F7F7),
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.onboarding, // Tentukan rute awal
      routes: AppRoutes.routes, // Gunakan rute dari AppRoutes
    );
  }
}
