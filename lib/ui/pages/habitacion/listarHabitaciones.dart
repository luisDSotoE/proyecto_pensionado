import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:proyecto_pension2/domain/controllers/controluser.dart';
import 'package:proyecto_pension2/domain/controllers/habitacion_controller.dart';
import 'package:proyecto_pension2/domain/models/habitacion.dart';
import 'package:proyecto_pension2/ui/pages/habitacion/detallehabitacion.dart';
import 'package:proyecto_pension2/ui/pages/Home/homeHabitacion.dart';

class ListarHabitaciones extends StatelessWidget {
  const ListarHabitaciones({super.key});

  @override
  Widget build(BuildContext context) {
    HabitacionController sc = Get.find();
    ControlUserAuth controlUserAuth = Get.find();
    String? uidUsuarioAutenticado = controlUserAuth.userValido?.user?.uid;
    if (uidUsuarioAutenticado != null) {
      sc.consultarHabitaciones(uidUsuarioAutenticado);
    } else {
      // Manejar el caso en el que no hay un usuario autenticado
      print("No hay usuario autenticado");
    }
    //sc.consultarHabitacionesgenerales();
    return Scaffold(
      //extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text("Lista de Habitaciones"),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Get.offAllNamed('/home');
          },
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            opacity: 0.6,
            image: const AssetImage("assets/image/EntradaHabitacion2jpg.jpg"),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(Colors.black.withOpacity(1), BlendMode.dstATop)
            ),
        ),
        child: Obx(() {
          final List<Habitacion>? _servicios = sc.listahab;
          if (sc.listahab?.isEmpty == true) {
            return const Center(
              child: Text("No existen Habitaciones registradas", style: TextStyle(color: Colors.white),),
            );
          } else {
            return ListView.builder(
              itemCount: sc.listahab!.length,
              itemBuilder: (context, posicion) {
                final servicio = _servicios![posicion];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical:5.0),
                  child: Card(
                    color: Colors.white70,
                    child: InkWell(
                      onTap: () {
                        _openHabitacionDetails(context, servicio);
                      },
                      child: Row(
                        children: [
                          SizedBox(
                            height: 120,
                            width: 120,
                            child: getImageWidget(sc.listahab![posicion].imagen),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(sc.listahab![posicion].nombre),
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(sc.listahab![posicion].direccion),
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(DescripcionRecortada(
                                      sc.listahab![posicion].descripcion)),
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(sc.listahab![posicion].mensualidad
                                      .toStringAsFixed(2)),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            children: [
                              IconButton(
                                icon: const Icon(
                                  Icons.edit_note_outlined,
                                  size: 30,
                                  color: Colors.indigo,
                                ),
                                onPressed: () {
                                  Get.toNamed('/editarhabitacion',
                                      arguments: sc.listahab![posicion]);
                                },
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.delete_outline_rounded,
                                  size: 30,
                                  color: Colors.red,
                                ),
                                onPressed: () {
                                  _showConfirmationDialog(context, sc, posicion);
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
        }),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white54,
        onPressed: () {
          Get.toNamed('/editarhabitacion');
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  getImageWidget(String imagen) {
    if (imagen.startsWith("http")) {
      return Image.network(imagen, height: 100, width: 100, fit: BoxFit.cover,);
    } else {
      return Image.asset(imagen, height: 150, width: 150);
    }
  }

  void _showConfirmationDialog(
      BuildContext context, HabitacionController sc, int posicion) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Confirmar eliminación"),
          content:
              const Text("¿Estás seguro de que deseas eliminar la Habitación?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cancelar"),
            ),
            TextButton(
              onPressed: () {
                sc.eliminarHabitacion(sc.listahab![posicion].id);
                Navigator.of(context).pop();
                ControlUserAuth controlUserAuth = Get.find();
                String? uidUsuarioAutenticado =
                    controlUserAuth.userValido?.user?.uid;
                sc.consultarHabitaciones(uidUsuarioAutenticado);
              },
              child: const Text("Eliminar"),
            ),
          ],
        );
      },
    );
  }

  void _openHabitacionDetails(BuildContext context, habitacion) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetalleHabitacionScreen(servicio: habitacion),
      ),
    );
  }
}
