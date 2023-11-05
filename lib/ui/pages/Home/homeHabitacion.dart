import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:proyecto_pension2/domain/controllers/habitacion_controller.dart';
import 'package:proyecto_pension2/ui/pages/Widgets/DetallesHabitaciones.dart';
import 'package:proyecto_pension2/ui/pages/Widgets/VerFotosHabitaciones.dart';


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
                    int limite = 30;
                    String desc = hc.listahab![index].descripcion;
                    String descripcionRecortada = desc.length > limite? "${desc.substring(0, limite)}..." : desc;
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
                                      return VerFoto(product: habitacion(hc.listahab![index].nombre));
                                    }));
                                  },
                                  child: Image.asset('assets/image/Home.jpg', 
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context){
                                    return DetallesHabitaciones(cuarto: hc.listahab![index].nombre);
                                  }));
                                },
                                child: Wrap(
                                  children: [
                                    Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        ' ${hc.listahab![index].nombre}',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Container(
                                        width: MediaQuery.of(context).size.width*0.62,
                                        child: Text(
                                          descripcionRecortada,
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
                                  ]
                                ),
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

