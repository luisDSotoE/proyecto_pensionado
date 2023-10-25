import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:proyecto_pension2/ui/pages/Login/widgetCajaTexto.dart';
import 'package:firebase_core/firebase_core.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> _signInWithEmailAndPassword() async {
    final String email = emailController.text.trim();
    final String password = passwordController.text;

    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);

      Get.toNamed("/home");
    } catch (e) {
      ("Error al iniciar sesión: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    // Initialize Firebase
    Firebase.initializeApp();

    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/image/Habitacion.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/image/Logo.png",
                width: 200,
                height: 200,
              ),
              const Text(
                "Iniciar Sesión",
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              CajaTexto(
                correo: "Nombre de usuario",
                oscuro: false,
                contrasena: '',
                controller: emailController,
              ),
              CajaTexto(
                contrasena: "Contraseña",
                oscuro: true,
                correo: '',
                controller: passwordController,
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: 200,
                child: ElevatedButton(
                  onPressed: _signInWithEmailAndPassword,
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.white),
                  ),
                  child: const Text(
                    "Iniciar Sesión",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      Get.toNamed("/registroUsuarioNormal");
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