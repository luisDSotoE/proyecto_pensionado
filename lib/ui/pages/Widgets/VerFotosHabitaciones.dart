import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class VerFoto extends StatelessWidget {
  const VerFoto({super.key, required this.nombre, required this.imagen});

  final String nombre;
  final String imagen;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        title: Text(nombre,
            style: const TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
      ), 
      body: PhotoView(imageProvider: NetworkImage(imagen)),
    );
  }
}