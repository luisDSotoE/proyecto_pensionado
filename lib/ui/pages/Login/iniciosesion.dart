import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:proyecto_pension2/data/services/authenticacionServices.dart';
import 'package:proyecto_pension2/ui/pages/Widgets/widgetCajaTexto.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController usuario = TextEditingController();
  TextEditingController clave = TextEditingController();
  var usuarios;
  void ingreso() {
    Peticioneslogin.ingresarEmail(usuario.text, clave.text).then((user) {
      setState(() {
        print(user);
        if (user == '1' || user == '2') {
          usuarios = 'Correo No Existe o Contraseña Invalida';
        } else {
          try {
            usuarios = user.user.email;
            print("has iniado correctamente");
            Get.offAndToNamed("/home");
          } catch (e) {
            e.printError();
          }
        }
      });
    }); // print(resul);
    // print('OBTENER');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Body(),
    );
  }

  // ignore: non_constant_identifier_names
  Center Body() {
    return Center(
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/image/Habitacion.jpg"),
              fit: BoxFit.cover),
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
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            CajaTexto(
              titulo: "Nombre de usuario",
              oscuro: false,
              controller: usuario,
            ),
            CajaTexto(
              titulo: "Contraseña",
              oscuro: true,
              controller: clave,
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: 200,
              child: ElevatedButton(
                onPressed: () {
                  ingreso();
                  usuario.clear();
                  clave.clear();
                },
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
    );
  }
}
