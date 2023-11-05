import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:proyecto_pension2/domain/controllers/habitacion_controller.dart';
import 'package:proyecto_pension2/ui/pages/Widgets/VerFotosHabitaciones.dart';

class DetallesHabitaciones extends StatelessWidget {
  final String cuarto;

  const DetallesHabitaciones({super.key, required this.cuarto});
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalles de la habitacion'),
        backgroundColor: const Color.fromARGB(255, 122, 171, 212),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context){
            return VerFoto(product: habitacion(cuarto));
            }));
                                  },
            child: Image.asset(
              'assets/image/Home.jpg',
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.3,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Direccion: ${habitacion(cuarto)["Direccion"]}',
                  style: const TextStyle(
                      fontSize: 15.0, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Mensualidad: \$${habitacion(cuarto)["Mensualidad"].toString()}',
                  style: const TextStyle(
                      fontSize: 15.0, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Description: ${habitacion(cuarto)["Descripcion"]}',
                  style: const TextStyle(
                      fontSize: 15.0, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Map<String, dynamic> habitacion(String cuarto){
  Map<String, dynamic> h = {};
  HabitacionController hc = Get.find();
  hc.consultarHabitaciones();
  String direccion, descripcion;
  double mensualidad;
    for (int i = 0; i < hc.listahab!.length; i++) {
      if (hc.listahab![i].nombre == cuarto) {
        direccion = hc.listahab![i].direccion;
        mensualidad = hc.listahab![i].mensualidad;
        descripcion = hc.listahab![i].descripcion;
        h["Nombre"] = cuarto;
        h["Direccion"] = direccion;
        h["Descripcion"] = descripcion;
        h["Mensualidad"] = mensualidad;
      }
    }
    return h;
}