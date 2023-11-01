import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:proyecto_pension2/ui/pages/Home/Homepage.dart';
import 'package:proyecto_pension2/ui/pages/Login/iniciosesion.dart';
import 'package:proyecto_pension2/ui/pages/Login/reg_u_normal.dart';


class Myapp extends StatelessWidget {
  const Myapp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true),
      home: const LoginPage(),
      routes: {
        "/registroUsuarioNormal": (context) => const RegistroUsuarioNormal(),
        "/home":(context) => const Home(),
        "/login":(context) => const LoginPage(),
      },
    );
  }
}