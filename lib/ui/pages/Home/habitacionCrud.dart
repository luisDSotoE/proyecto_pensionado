import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:proyecto_pension2/data/services/habitacionServices.dart';
import 'package:proyecto_pension2/domain/controllers/habitacion_controller.dart';
import 'package:proyecto_pension2/ui/pages/Home/homeHabitacion.dart';
import 'package:proyecto_pension2/ui/pages/Widgets/DetallesHabitaciones.dart';


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
  @override
  Widget build(BuildContext context) {
    HabitacionController hc = Get.find();
    hc.consultarHabitaciones();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 122, 171, 212),
        title: const Text('Lista de habitaciones'),
      ),
      body: Obx(() {
        if (hc.listahab?.isEmpty == true) {
          return const Center(
            child: Text("No existen habitaciones"),
          );
        } else {
          return ListView.builder(
            itemCount: hc.listahab!.length,
            itemBuilder: (BuildContext context, int index) {
              int limite = 30;
              String desc = hc.listahab![index].descripcion;
              String descripcionRecortada = desc.length > limite? "${desc.substring(0, limite)}..." : desc;
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          DetallesHabitaciones(cuarto: hc.listahab![index].nombre),
                    ),
                  );
                },
                child: Card(
                  child: Row(
                    children: [
                      SizedBox(
                        height: 100,
                        width: 100,
                        child: Image.asset('assets/image/Home.jpg'),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              hc.listahab![index].nombre,
                              style: const TextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'DIRECCION: ${hc.listahab![index].direccion}',
                              style: const TextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'MENSUALIDAD: \$${hc.listahab![index].mensualidad}',
                              style: const TextStyle(
                                  fontSize: 15.0, fontWeight: FontWeight.bold),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width*0.65,
                              child: Text(
                                'DESCRIPCION: $descripcionRecortada',
                                style: const TextStyle(
                                    fontSize: 15.0, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
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

class AddRoomScreen extends StatefulWidget {
  const AddRoomScreen({super.key});

  @override
  State<AddRoomScreen> createState() => _AddRoomScreenState();
}

class _AddRoomScreenState extends State<AddRoomScreen> {
  TextEditingController nombreController = TextEditingController();
  TextEditingController direccionController = TextEditingController();
  TextEditingController descripcionController = TextEditingController();
  TextEditingController mensualidadController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agregar habitacion'),
        backgroundColor: const Color.fromARGB(255, 122, 171, 212),
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(),
          child: Column(
            children: [
              IngresarDatos(
                  controller: nombreController,
                  tipo: TextInputType.text,
                  texto: 'Nombre'),
              IngresarDatos(
                  controller: direccionController,
                  tipo: TextInputType.text,
                  texto: 'Direccion'),
              IngresarDatos(
                  controller: descripcionController,
                  tipo: TextInputType.text,
                  texto: 'Descripción'),
              IngresarDatos(
                  controller: mensualidadController,
                  tipo: const TextInputType.numberWithOptions(decimal: true),
                  texto: 'Mensualidad'),
              const SizedBox(
                height: 15,
              ),
              ElevatedButton.icon(
                onPressed: () {
                  fotos();
                },
                icon: const Icon(
                  Icons.cloud_upload,
                  color: Colors.white,
                ),
                label: const Text(
                  "Subir fotos",
                  style: TextStyle(color: Colors.white),
                ),
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.blue)),
              ),
              const SizedBox(
                height: 25,
              ),
              SizedBox(
                width: 200,
                child: ElevatedButton(
                  onPressed: () {
                    guardarHabitacion();
                    nombreController.clear();
                    direccionController.clear();
                    descripcionController.clear();
                    mensualidadController.clear();
                    Navigator.pop(context);
                  },
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.yellow)),
                  child: const Text(
                    "Registrarse",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  guardarHabitacion() async {
    var nombre = nombreController.text;
    var direccion = direccionController.text;
    var descripcion = descripcionController.text;
    var mensualidad = double.parse(mensualidadController.text);
    HabitacionServices()
        .guardarHabitacion(nombre, direccion, descripcion, mensualidad);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => ListHabitaciones()));
  }
}

// ignore: must_be_immutable
class IngresarDatos extends StatelessWidget {
  TextEditingController controller;
  IngresarDatos(
      {super.key,
      required this.controller,
      required this.tipo,
      required this.texto});
  TextInputType tipo;
  String texto;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        controller: controller,
        keyboardType: tipo,
        decoration: InputDecoration(
          labelText: texto,
        ),
      ),
    );
  }
}

Future<void> fotos() async {
  final picker = ImagePicker();
  final pickedFile = await picker.pickImage(source: ImageSource.gallery);

  if (pickedFile != null) {}
}
