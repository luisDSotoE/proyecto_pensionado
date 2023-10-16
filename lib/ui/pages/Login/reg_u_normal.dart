import 'package:flutter/material.dart';
import 'package:proyecto_pension2/ui/pages/Login/widgetCajaTexto.dart';

class RegistroUsuarioNormal extends StatelessWidget {
  const RegistroUsuarioNormal({super.key});

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0, ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(image: DecorationImage(image: AssetImage("assets/Images/Casa.jpg"), fit: BoxFit.cover)),
          child: SingleChildScrollView(
            child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Image.asset('assets/logo.png', width: 100, height: 100),
                    
                    SizedBox(
                      width: 200.0,
                      height: 200.0,
                      child: Image.asset("assets/Images/Logo.png", width: 100, height: 100,),
                    
                    ),
                    
                    //const SizedBox(height: 20),
                    
                    const Text(
                      "Registro Usuario",
                      style: TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20),
                    
                    // Campos de texto para el nombre de usuario y la contraseña
                    const CajaTexto(titulo: "Nombre de usuario"),
                    const CajaTexto(titulo: "Cedula", tipo: TextInputType.number),
                    const CajaTexto(titulo: "Numero de telefono", tipo: TextInputType.number,),
                    const CajaTexto(titulo: "Contraseña", oscuro: true),
                      
                    const SizedBox(height: 20),
                    
                    // Botón de inicio de sesión
                    SizedBox(
                      width: 200,
                      child: ElevatedButton(
                        onPressed: () {
                          // Aquí puedes agregar la lógica para el inicio de sesión
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
          ),

      );
  }
}

