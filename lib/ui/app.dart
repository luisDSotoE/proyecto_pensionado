import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:proyecto_pension2/ui/pages/Home/Homepage.dart';

import 'package:proyecto_pension2/ui/pages/Login/iniciosesion.dart';
import 'package:proyecto_pension2/ui/pages/Login/reg_u_normal.dart';
import 'package:firebase_core/firebase_core.dart'; // Importa Firebase Core

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Inicializa Firebase

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true),
      home: LoginPage(),
      routes: {
        "/registroUsuarioNormal": (context) => const RegistroUsuarioNormal(),
        "/home": (context) => const Home(),
      },
    );
  }
}
