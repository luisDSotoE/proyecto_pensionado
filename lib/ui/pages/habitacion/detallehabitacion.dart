import 'package:flutter/material.dart';
import 'package:proyecto_pension2/domain/models/habitacion.dart';
import 'package:proyecto_pension2/ui/pages/Widgets/VerFotosHabitaciones.dart';

class DetalleHabitacionScreen extends StatelessWidget {
  final Habitacion servicio;

  const DetalleHabitacionScreen({super.key, required this.servicio});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalle Habitación'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context){
                  return VerFoto(nombre: servicio.nombre, imagen: servicio.imagen,);
                }));
              },
              child: ServicioCoverWidget(coverUrl: servicio.imagen)
              ),
            ServicioInfoWidget(
                nombre: "Nombre: ${servicio.nombre}",
                descripcion: "Descripción: ${servicio.descripcion.toString()}",
                direccion: "Dirección: ${servicio.direccion}",
                mensualidad: "Mensualidad: \$${servicio.mensualidad}",
               ),
          ],
        ),
      ),
    );
  }
}

class ServicioCoverWidget extends StatelessWidget {
  final String coverUrl;
  const ServicioCoverWidget({super.key, required this.coverUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20, bottom: 20),
      width: 400,
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 5,
            blurRadius: 10)
      ]),
      child: getImageWidget(coverUrl),
    );
  }

  getImageWidget(String imagenes) {
    if (imagenes.startsWith("http")) {
      return Image.network(imagenes, height: 150, width: 150);
    } else {
      return Image.asset(imagenes, height: 150, width: 150);
    }
  }
}

class ServicioInfoWidget extends StatelessWidget {
  final String nombre;
  final String descripcion;
  final String direccion;
  final String mensualidad;

  const ServicioInfoWidget({
    Key? key,
    required this.nombre,
    required this.descripcion,
    required this.direccion,
    required this.mensualidad,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        children: [
          Text(
            nombre,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            descripcion,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
          Text(
            mensualidad,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}

class ImageWidget extends StatelessWidget {
  final String imagen;

  const ImageWidget({
    Key? key,
    required this.imagen,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (imagen.startsWith("http")) {
      return Image.network(imagen, height: 150, width: 150);
    } else {
      return Image.asset(imagen, height: 150, width: 150);
    }
  }
}
