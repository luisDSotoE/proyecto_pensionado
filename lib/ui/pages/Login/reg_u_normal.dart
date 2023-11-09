import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:proyecto_pension2/domain/controllers/controlperfil.dart';
import 'package:proyecto_pension2/domain/controllers/controluser.dart';
import 'package:proyecto_pension2/ui/pages/Widgets/widgetCajaTexto.dart';

class RegistroUsuarioNormal extends StatelessWidget {
  RegistroUsuarioNormal({super.key});

  final TextEditingController nombreUserController = TextEditingController();
  final TextEditingController cedulaController = TextEditingController();
  final TextEditingController telefonoController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
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
                  const TipoUsuario(),
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
                          var datos = {
                            'nombre': nombreUserController.text,
                            'cedula': cedulaController.text,
                            'telefono': telefonoController.text,
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

class TipoUsuario extends StatefulWidget {
  const TipoUsuario({
    super.key,
  });

  @override
  State<TipoUsuario> createState() => _TipoUsuarioState();
}

class _TipoUsuarioState extends State<TipoUsuario> {
  String valor = "Estudiante";
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white60,
        borderRadius: BorderRadius.circular(50),
      ),
      child: DropdownButton<String>(
        value: valor,
        icon: const Icon(
          Icons.arrow_drop_down,
        ),
        dropdownColor: Colors.white60,
        onChanged: (String? value) {
          setState(() {
            valor = value!;
          });
        },
        items: <String>["Estudiante", "Propietario"]
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
                style: const TextStyle(
                    color: Colors.black87, fontStyle: FontStyle.italic),
              ));
        }).toList(),
      ),
    );
  }
}
