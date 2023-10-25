import 'package:flutter/material.dart';

class CajaTexto extends StatelessWidget {
  const CajaTexto({super.key, 
    Key? ke, // Agregar la palabra clave 'Key?'
    required this.correo,
    required this.contrasena,
    this.oscuro = false,
    this.tipo = TextInputType.text,
    required this.controller, // Agregar 'required' aquí
  });

  final String correo;
  final String contrasena;
  final bool oscuro;
  final TextInputType tipo;
  final TextEditingController controller; // Agregar la definición de 'TextEditingController'

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      padding: const EdgeInsets.all(10),
      child: TextFormField(
        controller: controller, // Asociar el controlador de texto
        keyboardType: tipo,
        obscureText: oscuro,
        decoration: const InputDecoration(
          fillColor: Colors.white60,
          filled: true,
          labelStyle: TextStyle(color: Colors.black, fontStyle: FontStyle.italic),
        ),
      ),
    );
  }
}

class CajaTexto2 extends StatelessWidget {
  const CajaTexto2({super.key, 
    Key? ke, 
    required this.correo2,
    required this.cedula2,
    required this.telefono2,
    required this.contrasena2,
    this.oscuro = false, required this.tipo, required Null Function(dynamic value) onChanged,
    
  });

  final String correo2;
  final String cedula2;
  final String telefono2;
  final String contrasena2;
  final bool oscuro;
  final TextInputType tipo;
  

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      padding: const EdgeInsets.all(10),
      child: TextFormField(
        keyboardType: tipo,
        obscureText: oscuro,
        decoration: const InputDecoration(
          fillColor: Colors.white60,
          filled: true,
          labelStyle: TextStyle(color: Colors.black, fontStyle: FontStyle.italic),
        ),
      ),
    );
  }
}
