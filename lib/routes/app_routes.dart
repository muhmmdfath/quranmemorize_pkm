import 'package:flutter/material.dart';
import '../screens/calendar_screen.dart';
import '../screens/home_screen.dart'; // Contoh: layar home
import '../screens/onboarding_screen.dart'; // Contoh: layar onboarding
import '../screens/quran_screen.dart'; // Contoh: layar onboarding
import '../screens/profile_screen.dart';

class AppRoutes {
  static const String home = '/home';
  static const String onboarding = '/onboarding';
  static const String calendar = '/calendar'; // Tambahkan rute untuk kalender
  static const String quran = '/quran'; // Rute untuk halaman Al-Qur'an
  static const String profile = '/profile';

  static Map<String, WidgetBuilder> get routes => {
        home: (context) => const HomeScreen(),
        onboarding: (context) => const OnboardingScreen(),
        calendar: (context) => const CalendarScreen(),
        quran: (context) => const QuranScreen(),
        profile: (context) => const ProfileScreen(),
      };
}


