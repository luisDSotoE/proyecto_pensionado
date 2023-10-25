import 'package:flutter/material.dart';
import 'package:proyecto_pension2/ui/pages/Login/widgetCajaTexto.dart';

class RegistroUsuarioNormal extends StatelessWidget {
  const RegistroUsuarioNormal({super.key, Key? ke});

  @override
  Widget build(BuildContext context) {
    String cedula = '';
    String telefono = '';
    String contrasena = '';

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          image: DecorationImage(image: AssetImage("assets/image/Casa.jpg"), fit: BoxFit.cover),
        ),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 200.0,
                  height: 200.0,
                  child: Image.asset("assets/image/Logo.png", width: 100, height: 100),
                ),
                const Text(
                  "Registro Usuario",
                  style: TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                CajaTexto2(
                  correo2: "Nombre de usuario",
                  cedula2: cedula,
                  telefono2: telefono,
                  contrasena2: contrasena,
                  tipo: TextInputType.text,
                  onChanged: (value) {
                  },
                ),
                CajaTexto2(
                  correo2: "Cedula",
                  cedula2: cedula,
                  telefono2: telefono,
                  contrasena2: contrasena,
                  tipo: TextInputType.number,
                  onChanged: (value) {
                    cedula = value;
                  },
                ),
                CajaTexto2(
                  correo2: "Numero de telefono",
                  cedula2: cedula,
                  telefono2: telefono,
                  contrasena2: contrasena,
                  tipo: TextInputType.number,
                  onChanged: (value) {
                    telefono = value;
                  },
                ),
                CajaTexto2(
                  correo2: "Contraseña",
                  cedula2: cedula,
                  telefono2: telefono,
                  contrasena2: contrasena,
                  oscuro: true,
                  tipo: TextInputType.text,
                  onChanged: (value) {
                    contrasena = value;
                  },
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: 200,
                  child: ElevatedButton(
                    onPressed: () {
                     
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.white),
                    ),
                    child: const Text("Registrarse", style: TextStyle(color: Colors.black)),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
