import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:proyecto_pension2/ui/pages/Login/opcionUsuario.dart';
import 'package:proyecto_pension2/ui/pages/Login/widgetCajaTexto.dart';


class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(image: AssetImage("assets/image/Habitacion.jpg"), fit: BoxFit.cover),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/image/Logo.png", width: 200, height: 200,),
              const Text(
                "Iniciar Sesión",
                style: TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              const CajaTexto(titulo: "Nombre de usuario", oscuro: false),
              const CajaTexto(titulo: "Contraseña", oscuro: true),
              const SizedBox(height: 20),
              SizedBox(
                width: 200,
                child: ElevatedButton(
                  onPressed: () {
                    // Aquí puedes agregar la lógica para el inicio de sesión
                    Get.toNamed("/home");
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.white),
                  ),
                  child: const Text("Iniciar Sesión", style: TextStyle(color: Colors.black),),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      // Navegar a la pantalla de menú de opciones de registro
                      Get.toNamed(const MenuOpcionesRegistro() as String); // Reemplaza por la ruta correcta
                    },
                    style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all(Colors.white),
                    ),
                    child: const Text("Registrarse"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
