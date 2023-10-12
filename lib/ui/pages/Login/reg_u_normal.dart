import 'package:flutter/material.dart';
import 'package:proyecto_pension2/ui/pages/Login/widgetCajaTexto.dart';

class RegistroUsuarioNormal extends StatelessWidget {
  const RegistroUsuarioNormal({super.key});

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.blue,),
      backgroundColor: Colors.blue,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Image.asset('assets/logo.png', width: 100, height: 100),
      
              Container(
                width: 200.0,
                height: 200.0,
                child: Image.asset("assets/Images/Logo.jpeg", width: 100, height: 100,),
      
              ),
              
              const SizedBox(height: 20),
      
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
              Container(
                width: 200,
                child: ElevatedButton(
                  onPressed: () {
                    // Aquí puedes agregar la lógica para el inicio de sesión
                    print("Se registro");
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.white)
                  ),
                  child: const Text("Registrarse", style: TextStyle(color: Colors.blue),),
                ),
              ),
      
              const SizedBox(height: 20),
          ]),
        ),
      ),
    );
  }
}

/* class Seleccion extends StatefulWidget {
  const Seleccion({super.key});

  @override
  State<Seleccion> createState() => _SeleccionState();
}

List<String> opciones = ["Estudiante", "Propietario"];

class _SeleccionState extends State<Seleccion> {
  String currentOption = opciones[0];
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        ListTile(
          title: const Text("Estudiante", style: TextStyle(color: Colors.white),),
          leading: Radio<String>(
          value: opciones[0], 
          groupValue: currentOption, 
          onChanged: (value){
            setState(() {
              currentOption = value.toString();
            });
          }
          ),
        ),
        const SizedBox(width: 20),
        ListTile(
          title: const Text("Propietario", style: TextStyle(color: Colors.white),),
          leading: Radio<String>(
          value: opciones[1], 
          groupValue: currentOption, 
          onChanged: (value){
            setState(() {
              currentOption = value.toString();
            });
          }
          ),
        )
      ],
    );
  }
} */