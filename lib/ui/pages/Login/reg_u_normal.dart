import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:proyecto_pension2/data/services/authenticacionServices.dart';

class RegistroUsuarioNormal extends StatefulWidget {
  const RegistroUsuarioNormal({super.key});

  @override
  State<RegistroUsuarioNormal> createState() => _RegistroUsuarioNormalState();
}

class _RegistroUsuarioNormalState extends State<RegistroUsuarioNormal> {
  final TextEditingController nombreUserController = TextEditingController();
  final TextEditingController cedulaController = TextEditingController();
  final TextEditingController telefonoController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  var usuarior;
  void registro() {
    Peticioneslogin.crearRegistroEmail(
            emailController.text, passwordController.text)
        .then((user) {
      setState(() {
        print(user);
        if (user == '1' || user == '2') {
          usuarior = 'Correo Ya Existe o Contraseña Debil';
        } else {
          usuarior = user.user.email;
        }
      });
    }); // print(resul);
    // print('OBTENER');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Registro(context),
    );
  }

  // ignore: non_constant_identifier_names
  Container Registro(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage("assets/image/Casa.jpg"), fit: BoxFit.cover),
      ),
      child: SingleChildScrollView(
        child: Container(
          width: 300,
          padding: const EdgeInsets.all(10),
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
                TextFormField(
                  controller: nombreUserController,
                  decoration: const InputDecoration(
                      labelText: "Nombre de usuario",
                      fillColor: Colors.white60,
                      filled: true,
                      labelStyle: TextStyle(
                          color: Colors.black, fontStyle: FontStyle.italic)),
                ),
                TextFormField(
                  controller: cedulaController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      labelText: "Cedula",
                      fillColor: Colors.white60,
                      filled: true,
                      labelStyle: TextStyle(
                          color: Colors.black, fontStyle: FontStyle.italic)),
                ),
                TextFormField(
                  controller: telefonoController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      labelText: "Numero de telefono",
                      fillColor: Colors.white60,
                      filled: true,
                      labelStyle: TextStyle(
                        color: Colors.black,
                        fontStyle: FontStyle.italic,
                      )),
                ),
                const TipoUsuario(),
                TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(
                      labelText: "Correo Electrónico",
                      fillColor: Colors.white60,
                      filled: true,
                      labelStyle: TextStyle(
                          color: Colors.black, fontStyle: FontStyle.italic)),
                ),
                TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: "Contraseña",
                    fillColor: Colors.white60,
                    filled: true,
                    labelStyle: TextStyle(
                        color: Colors.black, fontStyle: FontStyle.italic),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: 200,
                  child: ElevatedButton(
                    onPressed: () async {
                      registro();
                      nombreUserController.clear();
                      cedulaController.clear();
                      telefonoController.clear();
                      emailController.clear();
                      passwordController.clear();
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.white),
                    ),
                    child: const Text("Registrarse",
                        style: TextStyle(color: Colors.black)),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        Get.toNamed("/login");
                      },
                      style: ButtonStyle(
                        foregroundColor:
                            MaterialStateProperty.all(Colors.white),
                      ),
                      child: const Text("Registrarse"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
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
      padding: const EdgeInsets.all(10),
      child: DropdownButton<String>(
        value: valor,
        icon: const Icon(
          Icons.arrow_drop_down,
        ),
        dropdownColor: Colors.black,
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
                style: const TextStyle(color: Color.fromARGB(255, 9, 255, 0)),
              ));
        }).toList(),
      ),
    );
  }
}
