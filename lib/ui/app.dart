import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:proyecto_pension2/ui/pages/Home/Homepage.dart';
import 'package:proyecto_pension2/ui/pages/Login/iniciosesion.dart';
import 'package:proyecto_pension2/ui/pages/Login/reg_u_normal.dart';
import 'package:proyecto_pension2/ui/pages/Login/reg_u_propietario.dart';

class Myapp extends StatelessWidget {
  const Myapp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: const LoginPage(),
      routes: {
        "/registroUsuarioNormal": (context) => const RegistroUsuarioNormal(),
        "/registroUsuarioPropietario": (context) => const RegistroUsuarioPropietario(),
        "/home":(context) => const Home(),
      },
    );
  }
}