import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


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

// ignore: camel_case_types
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
        backgroundColor: const Color.fromARGB(255, 122, 171, 212),
        
        title: const Text('Lista de habitaciones'),
      ),
      body: ListView.builder(
        itemCount: rooms.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Image.network(rooms[index].imagen, width: 50, height: 50,),
            title: Text(rooms[index].direccion),
            subtitle: Text('Mensualidad: \$${rooms[index].mensualidad.toStringAsFixed(2)}'),
            onTap: () {
             
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

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddRoomScreen(),
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
        backgroundColor: const Color.fromARGB(255, 122, 171, 212),
      ),
      body: Column(                    
        children: [
          Image.network(cuarto.imagen),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('DIRECCION: ${cuarto.direccion}',style: const TextStyle(fontSize: 15.0,fontWeight: FontWeight.bold,  ), ),
                Text('MENSUALIDAD: \$${cuarto.mensualidad.toStringAsFixed(2)}',style: const TextStyle(fontSize: 15.0,fontWeight: FontWeight.bold ),),
                Text('DESCRIPCION: ${cuarto.descripcion}',style: const TextStyle(fontSize: 15.0,fontWeight: FontWeight.bold ),),
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
        backgroundColor: const Color.fromARGB(255, 122, 171, 212),
      ),
      body: Container(
        decoration: const BoxDecoration(),
          child: Column(
            children: [
              IngresarDatos("Nombre:", TextInputType.name),
              IngresarDatos("Direccion:", TextInputType.name),
              IngresarDatos("Descripcion:", TextInputType.name),
              IngresarDatos("Mensualidad:", TextInputType.number),
              const SizedBox(height: 15,),
              ElevatedButton.icon(
                onPressed: (){
                  fotos();
                }, 
                icon: const Icon(Icons.cloud_upload, color: Colors.white,),
                label: const Text("Subir fotos", style: TextStyle(color: Colors.white),),
                style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.blue)),
                ),
                const SizedBox(height: 25,),
                SizedBox(
                    width: 200,
                    child: ElevatedButton(
                      onPressed: () {
                        //Logica
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.yellow)
                      ),
                      child: const Text("Registrarse", style: TextStyle(color: Colors.black),),
                    ),
                  ),
              

            ],
          ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Padding IngresarDatos(String text, TextInputType tipo) {
    return Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                keyboardType: tipo,
                decoration: InputDecoration(
                  labelText: text,
                ),
              ),
            );
  }
}

Future<void> fotos() async{
  final picker = ImagePicker();
  final pickedFile = await picker.pickImage(source: ImageSource.gallery);

  if (pickedFile != null) {
    
  }
}