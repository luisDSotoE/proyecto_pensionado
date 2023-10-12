
import 'package:flutter/material.dart';

class Habitacion {
  String? fotoUrl;
  String? direccion;
  double? mensualidad;
  String? descripcion;

  Habitacion({this.fotoUrl, this.direccion, this.mensualidad, this.descripcion});
}


class HomeHabitacion extends StatefulWidget {
  const HomeHabitacion({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeHabitacionState createState() => _HomeHabitacionState();
}

class _HomeHabitacionState extends State<HomeHabitacion> {
  List<Habitacion> habitaciones = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gestión de Habitaciones'),
      ),
      body: ListView.builder(
        itemCount: habitaciones.length,
        itemBuilder: (context, index) {
          return ListTile(
            // leading: CircleAvatar(
            //   backgroundImage: habitaciones[index].fotoUrl != null
            //       ? NetworkImage(habitaciones[index].fotoUrl!)
            //       : const AssetImage('assets/default_image.png'), // Puedes reemplazar con tu imagen predeterminada
            // ),
            title: Text('Dirección: ${habitaciones[index].direccion ?? 'N/A'}'),
            subtitle: Text('Mensualidad: \$${habitaciones[index].mensualidad?.toStringAsFixed(2) ?? 'N/A'}'),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                // Acción para eliminar la habitación
                setState(() {
                  habitaciones.removeAt(index);
                });
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Acción para agregar una nueva habitación
          _agregarHabitacion(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _agregarHabitacion(BuildContext context) async {
    Habitacion nuevaHabitacion = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AgregarHabitacionScreen()),
    );

    setState(() {
      habitaciones.add(nuevaHabitacion);
    });
    }
}

class AgregarHabitacionScreen extends StatefulWidget {
  const AgregarHabitacionScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AgregarHabitacionScreenState createState() => _AgregarHabitacionScreenState();
}

class _AgregarHabitacionScreenState extends State<AgregarHabitacionScreen> {
  TextEditingController direccionController = TextEditingController();
  TextEditingController mensualidadController = TextEditingController();
  TextEditingController descripcionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agregar Habitación'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: direccionController,
              decoration: const InputDecoration(labelText: 'Dirección'),
            ),
            TextField(
              controller: mensualidadController,
              decoration: const InputDecoration(labelText: 'Mensualidad'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: descripcionController,
              decoration: const InputDecoration(labelText: 'Descripción'),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                // Acción para guardar la habitación
                String direccion = direccionController.text;
                double? mensualidad = double.tryParse(mensualidadController.text);
                String descripcion = descripcionController.text;

                Habitacion habitacion = Habitacion(
                  direccion: direccion,
                  mensualidad: mensualidad,
                  descripcion: descripcion,
                );

                Navigator.pop(context, habitacion);
              },
              child: const Text('Guardar'),
            ),
          ],
        ),
      ),
    );
  }
}
