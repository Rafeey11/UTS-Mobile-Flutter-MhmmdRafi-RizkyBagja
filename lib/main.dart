import 'package:flutter/material.dart';
import 'pages/login_page.dart';
import 'pages/home_page.dart';
import 'pages/profile_page.dart';

void main() {
  runApp(const RideRosterApp());
}

class RideRosterApp extends StatelessWidget {
  const RideRosterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RideRoster',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.orange,
        scaffoldBackgroundColor: const Color(0xFF121212),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF1F1F1F),
          elevation: 0,
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginPage(),
        '/home': (context) => const HomePage(),
        '/profile': (context) => const ProfilePage(),
        
        // 📌 [AREA TAMBAHAN KODE NANTI: RUTE BARU]
      },
    );
  }
}