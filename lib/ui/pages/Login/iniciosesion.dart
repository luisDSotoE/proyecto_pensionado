import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:proyecto_pension2/domain/controllers/controluser.dart';
import 'package:proyecto_pension2/domain/controllers/habitacion_controller.dart';
import 'package:proyecto_pension2/ui/pages/Widgets/widgetCajaTexto.dart';

// ignore: must_be_immutable
class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  TextEditingController usuario = TextEditingController();

  TextEditingController clave = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ControlUserAuth cua = Get.find();

    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
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
                    cua.ingresarUser(usuario.text, clave.text).then((value) {
                      if (cua.userValido == null) {
                        MensajeError("¡ERROR!", "Usuario invalido");
                        /* Get.snackbar(
                          'Error',
                          'Usuario invalido',
                          snackPosition: SnackPosition.TOP,
                          backgroundColor: Colors.red,
                          colorText: Colors.white,
                          borderRadius: 10,
                          margin: const EdgeInsets.all(10),
                          duration: const Duration(seconds: 3),
                          isDismissible: true,
                          dismissDirection: DismissDirection.vertical,
                          forwardAnimationCurve: Curves.easeOutBack,
                          reverseAnimationCurve: Curves.easeInBack,
                        ); */
                      } else {
                        final ControlUserAuth cua = Get.find();
                        final HabitacionController hc = Get.find();

                        if (cua.rol == 'Admin') {
                          hc.consultarHabitaciones(cua.userValido?.user?.uid);
                        } else {
                          hc.consultarHabitacionesgenerales();
                        }
                        Get.offAllNamed('/home');
                      }
                    });
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
      ),
    );
  }
}

// ignore: non_constant_identifier_names
SnackbarController MensajeError(String titulo, String mensaje) {
  return Get.snackbar(
    titulo,
    mensaje,
    snackPosition: SnackPosition.TOP,
    backgroundColor: Colors.red,
    colorText: Colors.white,
    borderRadius: 10,
    margin: const EdgeInsets.all(10),
    duration: const Duration(seconds: 3),
    isDismissible: true,
    dismissDirection: DismissDirection.vertical,
    forwardAnimationCurve: Curves.easeOutBack,
    reverseAnimationCurve: Curves.easeInBack,
  );
}
