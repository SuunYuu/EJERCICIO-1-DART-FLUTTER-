import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:proyecto_instructor_diego/ui/views/splash/splash_view.dart';
import 'package:proyecto_instructor_diego/ui/views/login/Login.dart';
import 'package:proyecto_instructor_diego/ui/views/Home/Home.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SplashView(),
      getPages: [
        GetPage(name: '/login', page: () => const LoginView()),
        GetPage(name: '/home', page: () => const HomeView()),
      ],
    );
  }
}