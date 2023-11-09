import 'package:flutter/material.dart';

// ignore: must_be_immutable
class IngresarDatos extends StatelessWidget {
  TextEditingController controller;
  IngresarDatos(
      {super.key,
      required this.controller,
      required this.tipo,
      required this.texto});
  TextInputType tipo;
  String texto;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        controller: controller,
        keyboardType: tipo,
        decoration: InputDecoration(
          labelText: texto,
        ),
      ),
    );
  }
}