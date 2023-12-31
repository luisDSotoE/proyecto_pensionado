import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:proyecto_pension2/domain/controllers/controluser.dart';
import 'package:proyecto_pension2/domain/controllers/habitacion_controller.dart';
import 'package:proyecto_pension2/ui/pages/Widgets/VerFotosHabitaciones.dart';
import 'package:proyecto_pension2/ui/pages/habitacion/detallehabitacion.dart';
import 'package:proyecto_pension2/ui/pages/Home/homeBuscador.dart';

class Habitaciones extends StatefulWidget {
  const Habitaciones({super.key});

  @override
  State<Habitaciones> createState() => _HabitacionesState();
}

class _HabitacionesState extends State<Habitaciones> {
  @override
  Widget build(BuildContext context) {
    //final ControlUserAuth controlUserAuth = Get.find();
    final HabitacionController hc = Get.find();
    hc.consultarHabitacionesgenerales();
    return Column(
      children: [
        BarraDeBusqueda(hc: hc),
        Expanded(
            child: ListHabitaciones(
          hc: hc,
        ))
      ],
    );
  }
}

class BarraDeBusqueda extends StatelessWidget {
  const BarraDeBusqueda({
    super.key,
    required this.hc,
  });

  final HabitacionController hc;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.only(
          left: 8.0,
          right: 8.0,
        ),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(12.0)),
        child: TextField(
          onTap: () {
            showSearch(
                context: context, delegate: SearchHabitacionDelegate(hc));
          },
          decoration: const InputDecoration(
              prefixIcon: Icon(
                Icons.search,
                size: 30,
              ),
              border: InputBorder.none,
              hintStyle: TextStyle(color: Colors.black, fontSize: 15),
              hintText: "Buscar"),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class ListHabitaciones extends StatelessWidget {
  ListHabitaciones({super.key, required this.hc});

  HabitacionController hc;
  @override
  Widget build(BuildContext context) {
    return Cartas(hc: hc);
  }
}

class Cartas extends StatelessWidget {
  const Cartas({
    super.key,
    required this.hc,
  });

  final HabitacionController hc;

  @override
  Widget build(BuildContext context) {
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
                        color: Colors.white70,
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      return VerFoto(
                                        nombre: hc.listahab![index].nombre,
                                        imagen: hc.listahab![index].imagen,
                                      );
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
                                        DescripcionRecortada(hc.listahab![index].nombre),
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.55,
                                        child: Text(
                                          DescripcionRecortada(
                                              hc.listahab![index].descripcion),
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

// ignore: non_constant_identifier_names
String DescripcionRecortada(String desc) {
  int limite = 30;
  String descripcionRecortada =
      desc.length > limite ? "${desc.substring(0, limite)}..." : desc;
  return descripcionRecortada;
}
