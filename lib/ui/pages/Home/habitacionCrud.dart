import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class Cuarto {
  String imagen;
  String direccion;
  double mensualidad;
  String descripcion;

  Cuarto({
    required this.imagen,
    required this.direccion,
    required this.mensualidad,
    required this.descripcion,
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Habitacion(),
    );
  }
}

class Habitacion extends StatefulWidget {
  const Habitacion({super.key});

  @override
  habitacionCrud createState() => habitacionCrud();
}

class habitacionCrud extends State<Habitacion> {
  List<Cuarto> rooms = [
    Cuarto(
      imagen: 'https://hips.hearstapps.com/hmg-prod/images/gettyimages-1299952593-64c12c1141c24.jpg?crop=1xw:0.8453434844192634xh;center,top&resize=1200:*',
      direccion: 'trav 18b 6-23',
      mensualidad: 700.000,
      descripcion: 'casa con parqueadero y de 2 pisos',
    ),
    Cuarto(
      imagen: 'https://colineal.com/cdn/shop/articles/decorar_habitacion_principal-_Colineal.jpg?v=1611599691',
      direccion: 'calle 16#8-37',
      mensualidad: 600.000,
      descripcion: 'Casa amplia con 3 habitaciones y con baño interno',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('lista de habitaciones'),
      ),
      body: ListView.builder(
        itemCount: rooms.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Image.network(rooms[index].imagen),
            title: Text(rooms[index].direccion),
            subtitle: Text('Mensualidad: \$${rooms[index].mensualidad.toStringAsFixed(2)}'),
            onTap: () {
              // Navigate to a detail screen to view more information about the room
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RoomDetailScreen(cuarto: rooms[index]),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to a screen to add a new room
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddRoomScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class RoomDetailScreen extends StatelessWidget {
  final Cuarto cuarto;

  const RoomDetailScreen({super.key, required this.cuarto});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalles de la habitacion'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(cuarto.imagen),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Direccion: ${cuarto.direccion}'),
                Text('Mensualidad: \$${cuarto.mensualidad.toStringAsFixed(2)}'),
                Text('Description: ${cuarto.descripcion}'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AddRoomScreen extends StatelessWidget {
  const AddRoomScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agregar habitacion'),
      ),
      body: const Center(
        child: Text('pantalla de habitacion'),
      ),
    );
  }
}
