import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:proyecto_pension2/domain/models/habitacion.dart';
import 'package:proyecto_pension2/domain/controllers/habitacion_controller.dart';
import 'package:proyecto_pension2/ui/pages/Home/homeHabitacion.dart';
import 'package:proyecto_pension2/ui/pages/Widgets/VerFotosHabitaciones.dart';
import 'package:proyecto_pension2/ui/pages/habitacion/detallehabitacion.dart';

//INTENTO FALLIDO DE HACER FUNCIONAR EL BUSCADOR :'(
// UPDATE: AHORA SI FUNCIONA (DE UNA MANERA MALA, PERO FUNCIONA :) ) 
class SearchHabitacionDelegate extends SearchDelegate<dynamic> {
  final HabitacionController hc;
  List<Habitacion> _filter = [];
  SearchHabitacionDelegate(this.hc);
  @override
  List<Widget>? buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [
      IconButton(
        onPressed: () {
          query = "";
        },
        icon: const Icon(Icons.close),
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
      onPressed: () {
        close(context, const Text(""));
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return CartasBusqueda(filter: _filter,);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    _filter = hc.listahab!.where((element) {
      return element.descripcion
          .toLowerCase()
          .contains(query.trim().toLowerCase());
    }).toList();
    return CartasBusqueda(filter: _filter);
  }
}

class CartasBusqueda extends StatelessWidget {
  const CartasBusqueda({
    super.key,
    required List<Habitacion> filter,
  }) : _filter = filter;

  final List<Habitacion> _filter;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
          itemCount: _filter.length,
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
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return VerFoto(
                              nombre: _filter[index].nombre,
                              imagen: _filter[index].imagen,
                            );
                          }));
                        },
                        child: Image.network(
                          _filter[index].imagen,
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
                            servicio: _filter[index],
                          );
                        }));
                      },
                      child: Wrap(children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              ' ${_filter[index].nombre}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.62,
                              child: Text(
                                DescripcionRecortada(
                                    _filter[index].descripcion),
                                style: const TextStyle(),
                              ),
                            ),
                            Text(
                              '\$${_filter[index].mensualidad}',
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
}
