import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:proyecto_pension2/domain/controllers/controlperfil.dart';
import 'package:proyecto_pension2/domain/controllers/controluser.dart';
import 'package:proyecto_pension2/ui/pages/Widgets/widgetCajaTexto.dart';

class RegistroUsuarioNormal extends StatefulWidget {
  RegistroUsuarioNormal({super.key});

  @override
  State<RegistroUsuarioNormal> createState() => _RegistroUsuarioNormalState();
}

class _RegistroUsuarioNormalState extends State<RegistroUsuarioNormal> {
  final TextEditingController nombreUserController = TextEditingController();
  final TextEditingController cedulaController = TextEditingController();
  final TextEditingController telefonoController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  List<String> tiporoles = ['Estudiante', 'Admin'];
  String? selectedRol;

  @override
  Widget build(BuildContext context) {
    ControlUserPerfil cup = Get.find();
    ControlUserAuth cua = Get.find();

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/image/Casa.jpg"), fit: BoxFit.cover),
        ),
        child: SingleChildScrollView(
          child: Container(
            width: 300,
            padding: const EdgeInsets.all(30),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 200.0,
                    height: 200.0,
                    child: Image.asset(
                      "assets/image/Logo.png",
                      width: 100,
                      height: 100,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Registro Usuario",
                    style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  CajaTexto(
                      titulo: "Nombre de Usuario",
                      controller: nombreUserController),
                  CajaTexto(
                      titulo: "Cedula",
                      controller: cedulaController,
                      tipo: TextInputType.number),
                  CajaTexto(
                      titulo: "Numero de Telefono",
                      controller: telefonoController,
                      tipo: TextInputType.phone),
                  DropdownButtonFormField<String>(
                    value: selectedRol,
                    onChanged: (newValue) {
                      setState(() {
                        selectedRol = newValue;
                      });
                    },
                    items: tiporoles.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: 'Tipo de Usuario',
                      filled: true,
                      fillColor: Colors.white60,
                    ),
                  ),
                  CajaTexto(
                    titulo: "Correo Electronico",
                    controller: emailController,
                    tipo: TextInputType.emailAddress,
                  ),
                  CajaTexto(
                      titulo: "Contraseña",
                      controller: passwordController,
                      tipo: TextInputType.visiblePassword,
                      oscuro: true),
                  ElevatedButton(
                    onPressed: () {
                      cua
                          .crearUser(
                        emailController.text,
                        passwordController.text,
                      )
                          .then((value) {
                        if (cua.userValido == null) {
                          Get.snackbar(
                            'Error',
                            'Error al registrarse',
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
                        } else {
                          var tiporol = selectedRol ?? 'Estudiante';
                          var datos = {
                            'nombre': nombreUserController.text,
                            'cedula': cedulaController.text,
                            'telefono': telefonoController.text,
                            'user': tiporol.toString(),
                            'correo': emailController.text
                          };

                          guardarDatosAdicionalesEnFirestore(
                            cua.userValido!.user!,
                            datos,
                          );

                          cup
                              .crearcatalogo(datos, null)
                              .then((value) => Get.offAllNamed('/home'));
                        }
                      });
                    },
                    child: const Text('Registrarse'),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                      onPressed: () {
                        Get.offAndToNamed('/login');
                      },
                      child: const Text('Iniciar Sesion'))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Future<void> guardarDatosAdicionalesEnFirestore(
    User user, Map<String, dynamic> datos) async {
  CollectionReference usuariosCollection =
      FirebaseFirestore.instance.collection('perfiles');
  await usuariosCollection.doc(user.uid).set(datos);
}
