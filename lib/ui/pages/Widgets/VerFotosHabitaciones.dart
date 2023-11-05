import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class VerFoto extends StatelessWidget {
  const VerFoto({super.key, required this.product});

  final Map<String, dynamic> product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        title: Text(product["Nombre"],
            style: const TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      //CUANDO SE HABILITE LO DE SUBIR FOTOS, SE ARREGLA 
      body: PhotoView(imageProvider: const AssetImage('assets/image/Home.jpg')),
    );
  }
}