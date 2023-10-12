import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
            image: DecorationImage(image: AssetImage("assets/image/Habitacion.jpg"), fit: BoxFit.cover)
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Image.asset('assets/logo.png', width: 100, height: 100),
              Image.asset("assets/image/Logo.png", width: 200, height: 200,),
              
              //const SizedBox(height: 10),
              const Text(
                "Iniciar Sesión",
                style: TextStyle(fontSize: 24, color: Color.fromARGB(255, 0, 0, 0), fontWeight: FontWeight.bold),
              ),
        
              const SizedBox(height: 20),
        
              // Campos de texto para el nombre de usuario y la contraseña
              const CajaTexto(titulo: "Nombre de usuario", oscuro: false),
              const CajaTexto(titulo: "Contraseña", oscuro: true),
        
              const SizedBox(height: 20),
        
              // Botón de inicio de sesión
              SizedBox(
                width: 200,
                child: ElevatedButton(
                  onPressed: () {
                    // Aquí puedes agregar la lógica para el inicio de sesión
                    Get.toNamed("/home");
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.white)
                  ),
                  child: const Text("Iniciar Sesión", style: TextStyle(color: Colors.black),),
                ),
              ),
        
              const SizedBox(height: 20),
        
              // Opciones de registro
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                verticalDirection: VerticalDirection.down,
                children: [
                  TextButton(
                    onPressed: () {
                      // Navegar a la pantalla de registro de usuario normal
                      Get.toNamed("/registroUsuarioNormal");
                    },
                    style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all(const Color.fromARGB(255, 255, 255, 255))
                  ),
                    child: const Text("Registrarse")
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