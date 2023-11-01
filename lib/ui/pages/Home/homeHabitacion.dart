import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
import 'package:proyecto_pension2/domain/controllers/habitacion_controller.dart';

class Habitaciones extends StatelessWidget {
  const Habitaciones({super.key});

  @override
  Widget build(BuildContext context) {
    return ListHabitaciones();
  }
}

class ListHabitaciones extends StatelessWidget {
  final List<Map<String, dynamic>> products = [
    {
      'Titulo': "Habitacion 1",
      'Descripcion':
          "Habitacion con mirada hacia la ciudad, con mira hacia la universidad X",
      'Mensualidad': 800.000,
      'Direccion': 'Kr 21',
      'Imagen': "assets/image/Habitacion.jpg"
    },
    {
      'Titulo': "Habitacion 2",
      'Descripcion': "Pension con bonita estructura",
      'Mensualidad': 950.000,
      'Direccion': 'Kr 20',
      'Imagen': "assets/image/Casa.jpg"
    },
    {
      'Titulo': "Habitacion 3",
      'Descripcion': "Habitacion con mirada hacia la ciudad en el barrio x",
      'Mensualidad': 1200.000,
      'Direccion': 'Kr 10',
      'Imagen': "assets/image/Habitacion.jpg"
    },
  ];

  ListHabitaciones({super.key});

  @override
  Widget build(BuildContext context) {
    HabitacionController hc = Get.find();
    hc.consultarHabitaciones();

    return SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Obx(() {
            if (hc.listahab?.isEmpty == true) {
              return const Center(
                child: Text("No existen habitaciones"),
              );
            } else {
              return ListView.builder(
                  itemCount: hc.listahab!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      child: Row(
                        children: [
                          SizedBox(
                            height: 150,
                            width: 150,
                            child: Image.asset('assets/image/Home.jpg'),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  ' ${hc.listahab![index].nombre}',
                                  style: const TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  hc.listahab![index].descripcion,
                                  style: const TextStyle(fontSize: 15.0),
                                ),
                                Text(
                                  '${hc.listahab![index].mensualidad}',
                                  style: const TextStyle(
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  });
            }
          }),
        ));
  }
}

class Photo extends StatelessWidget {
  const Photo({super.key, required this.product});

  final Map<String, dynamic> product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        title: Text(product['Titulo'],
            style: const TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: PhotoView(imageProvider: AssetImage(product['Imagen'])),
    );
  }
}

class DetallesHabitacion extends StatelessWidget {
  final Map<String, dynamic> cuarto;

  const DetallesHabitacion({super.key, required this.cuarto});

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
          Image.asset(
            cuarto['Imagen'],
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.3,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Direccion: ${cuarto['Direccion']}',
                  style: const TextStyle(
                      fontSize: 15.0, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Mensualidad: \$${cuarto['Mensualidad']}',
                  style: const TextStyle(
                      fontSize: 15.0, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Description: ${cuarto['Descripcion']}',
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
