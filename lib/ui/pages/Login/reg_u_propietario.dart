import 'package:flutter/material.dart';
import 'package:proyecto_pension2/ui/pages/Login/widgetCajaTexto.dart';

class RegistroUsuarioPropietario extends StatelessWidget {
  const RegistroUsuarioPropietario({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          image: DecorationImage(image: AssetImage("assets/Images/Casa.jpg"), fit: BoxFit.cover),
        ),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 200.0,
                  height: 200.0,
                  child: Image.asset("assets/Images/Logo.png", width: 100, height: 100),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Registro Propietario",
                  style: TextStyle(fontSize: 24, color: Colors.white),
                ),
                const SizedBox(height: 20),
                CajaTexto(titulo: "Nombre de usuario"),
                CajaTexto(titulo: "Cedula", tipo: TextInputType.number),
                CajaTexto(titulo: "Numero de telefono", tipo: TextInputType.number),
                CajaTexto(titulo: "Contraseña", oscuro: true),
                const SizedBox(height: 20),
                SizedBox(
                  width: 200,
                  child: ElevatedButton(
                    onPressed: () {
                      // Aquí puedes agregar la lógica para el inicio de sesión
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.white),
                    ),
                    child: const Text(
                      "Registrarse",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
