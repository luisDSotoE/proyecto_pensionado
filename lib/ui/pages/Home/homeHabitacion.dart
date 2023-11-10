import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:proyecto_pension2/domain/controllers/habitacion_controller.dart';
import 'package:proyecto_pension2/domain/models/habitacion.dart';
import 'package:proyecto_pension2/ui/pages/Widgets/VerFotosHabitaciones.dart';
import 'package:proyecto_pension2/ui/pages/habitacion/detallehabitacion.dart';

class Habitaciones extends StatelessWidget {
  const Habitaciones({super.key});

  @override
  Widget build(BuildContext context) {
    return const ListHabitaciones();
  }
}

class ListHabitaciones extends StatelessWidget {
  const ListHabitaciones({super.key});

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
              return SizedBox(
                width: MediaQuery.of(context).size.width,
                child: ListView.builder(
                    itemCount: hc.listahab!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context){
                                       return VerFoto(nombre: hc.listahab![index].nombre, imagen: hc.listahab![index].imagen,);
                                    }));
                                  },
                                  child: Image.network(
                                    hc.listahab![index].imagen,
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return DetalleHabitacionScreen(
                                      servicio: hc.listahab![index],
                                    );
                                  }));
                                },
                                child: Wrap(children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        ' ${hc.listahab![index].nombre}',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.62,
                                        child: Text(
                                          DescripcionRecortada(hc.listahab![index].descripcion),
                                          style: const TextStyle(),
                                        ),
                                      ),
                                      Text(
                                        '\$${hc.listahab![index].mensualidad}',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.green),
                                      ),
                                    ],
                                  ),
                                ]),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
              );
            }
          }),
        ));
  }
}

String DescripcionRecortada(String desc){
  int limite = 30;
  String descripcionRecortada = desc.length > limite
  ? "${desc.substring(0, limite)}..."
  : desc;
  return descripcionRecortada;
}

/* Map<String, dynamic> habitacion(String cuarto){
   Map<String, dynamic> h = {};
   HabitacionController hc = Get.find();
   hc.consultarHabitaciones();
   String direccion, descripcion, imagen;
   double mensualidad;
     for (int i = 0; i < hc.listahab!.length; i++) {
       if (hc.listahab![i].id == cuarto) {
         direccion = hc.listahab![i].direccion;
         mensualidad = hc.listahab![i].mensualidad;
         descripcion = hc.listahab![i].descripcion;
         imagen = hc.listahab![i].imagen;
         h["Nombre"] =  hc.listahab![i].nombre;
         h["Direccion"] = direccion;
         h["Descripcion"] = descripcion;
         h["Mensualidad"] = mensualidad;
         h["Imagen"] = imagen;
       }
     }
     return h;
} */