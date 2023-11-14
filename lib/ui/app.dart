import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:proyecto_pension2/ui/pages/Home/Homepage.dart';
import 'package:proyecto_pension2/ui/pages/Home/perfil.dart';
import 'package:proyecto_pension2/ui/pages/Login/iniciosesion.dart';
import 'package:proyecto_pension2/ui/pages/Login/reg_u_normal.dart';
import 'package:proyecto_pension2/ui/pages/habitacion/agregarhabitacion.dart';
import 'package:proyecto_pension2/ui/pages/habitacion/listarHabitaciones.dart';

class Myapp extends StatelessWidget {
  const Myapp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true),
      home: LoginPage(),
      routes: {
        "/registroUsuarioNormal": (context) => RegistroUsuarioNormal(),
        "/home": (context) => const Home(),
        "/login": (context) => LoginPage(),
        '/editarhabitacion': (context) => const Editaragregarhabiatcion(),
        '/listarhabitaciones': (context) => const ListarHabitaciones(),
        // '/detallehabitacion': (context) => DetalleHabitacionScreen(servicio: hc.los),
        '/perfil': (context) => const Perfil(),
      },
    );
  }
}
