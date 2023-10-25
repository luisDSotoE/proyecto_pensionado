import 'package:flutter/material.dart';
import 'package:proyecto_pension2/ui/pages/Login/widgetCajaTexto.dart';

class RegistroUsuarioNormal extends StatelessWidget {
  const RegistroUsuarioNormal({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0, ),
        body: Registro(context),
      );
  }

  // ignore: non_constant_identifier_names
  Container Registro(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(image: DecorationImage(image: AssetImage("assets/image/Casa.jpg"), fit: BoxFit.cover)),
        child: SingleChildScrollView(
          child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 200.0,
                    height: 200.0,
                    child: Image.asset("assets/image/Logo.png", width: 100, height: 100,),
                  ),
                  //const SizedBox(height: 20),
                  const Text(
                    "Registro Usuario",
                    style: TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  const CajaTexto(titulo: "Nombre de usuario"),
                  const CajaTexto(titulo: "Cedula", tipo: TextInputType.number),
                  const CajaTexto(titulo: "Numero de telefono", tipo: TextInputType.number,),
                  const TipoUsuario(),
                  const CajaTexto(titulo: "Contraseña", oscuro: true),  
                  const SizedBox(height: 20),

                  SizedBox(
                    width: 200,
                    child: ElevatedButton(
                      onPressed: () {
                        //Logica
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.white)
                      ),
                      child: const Text("Registrarse", style: TextStyle(color: Colors.black),),
                    ),
                  ),
                  
                  const SizedBox(height: 20),
              ]),
            ),
          ),
        );
  }
}

class TipoUsuario extends StatefulWidget {
  const TipoUsuario({super.key,});

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
          icon: const Icon(Icons.arrow_drop_down,),
          dropdownColor: Colors.black,
          onChanged: (String? value) {
            setState(() {
              valor = value!;
            });
          },
          items: <String>["Estudiante","Propietario"].map<DropdownMenuItem<String>>((String value){
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value, style: const TextStyle(color: Color.fromARGB(255, 9, 255, 0)),)
              );
          }).toList(),
        ),
    );
    
  }
}
