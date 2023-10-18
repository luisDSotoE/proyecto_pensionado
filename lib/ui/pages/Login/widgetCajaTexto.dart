

import 'package:flutter/material.dart';

class CajaTexto extends StatelessWidget {
  const CajaTexto({
    super.key, 
    required this.titulo, 
    
    this.oscuro = false,
    this.tipo = TextInputType.name
    });

  final String titulo;
 
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
        decoration: InputDecoration(
          labelText: titulo,
          fillColor: Colors.white60,
          filled: true,
          labelStyle: const TextStyle(color: Colors.black, fontStyle: FontStyle.italic)
        ),
    ),
    );
  }
}