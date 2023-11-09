import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:proyecto_pension2/data/services/habitacionServices.dart';
import 'package:proyecto_pension2/domain/controllers/habitacion_controller.dart';
import 'package:proyecto_pension2/domain/models/habitacion.dart';
import 'package:proyecto_pension2/ui/widgets/textinput.dart';

class Editaragregarhabiatcion extends StatelessWidget {
  const Editaragregarhabiatcion({super.key});

  @override
  Widget build(BuildContext context) {
    final Habitacion? servicio = Get.arguments as Habitacion?;
    return Scaffold(
      appBar: AppBar(
        title:
            Text(servicio != null ? 'Editar Habitación' : 'Agregar Habitación'),
        centerTitle: true,
      ),
      body: EditServicioForm(servicio: servicio),
    );
  }
}

class EditServicioForm extends StatefulWidget {
  final Habitacion? servicio;

  const EditServicioForm({super.key, this.servicio});

  @override
  State<EditServicioForm> createState() => _EditServicioFormState();
}

class _EditServicioFormState extends State<EditServicioForm> {
  final nombreController = TextEditingController();
  final direccionController = TextEditingController();
  final descripcionController = TextEditingController();
  final mensualidadController = TextEditingController();
  // bool isDisponible = false;
  String? image;

  bool savingServicio = false;

  @override
  void initState() {
    super.initState();

    if (widget.servicio != null) {
      nombreController.text = widget.servicio!.nombre;
      direccionController.text = widget.servicio!.direccion;
      descripcionController.text = widget.servicio!.descripcion;
      mensualidadController.text = widget.servicio!.mensualidad.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (savingServicio) {
      return const Center(child: CircularProgressIndicator());
    }
    return Scaffold(
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
                onPressed: () async {
                  try {
                    FilePickerResult? result =
                        await FilePicker.platform.pickFiles();
                    if (result != null) {
                      setState(() => image = result.files.single.path);
                    }
                  } catch (e) {
                    e.printError();
                  }
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
                    guardarHabitacion(context);
                    nombreController.clear();
                    direccionController.clear();
                    descripcionController.clear();
                    mensualidadController.clear();
                    Navigator.pop(context);
                  },
                  child: const Text("Guardar"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void guardarHabitacion(BuildContext context) async {
    var nombre = nombreController.text;
    var direccion = direccionController.text;
    var descripcion = descripcionController.text;
    var mensualidad = double.parse(mensualidadController.text);

    if (widget.servicio == null) {
      String newServicioId = await HabitacionServices()
          .guardarHabitacion(nombre, direccion, descripcion, mensualidad);
      if (image != null) {
        String? imageUrl = await HabitacionServices()
            .uploadHabitacionCover(image!, newServicioId);
        if (imageUrl != null) {
          await HabitacionServices()
              .updateCoverHabitacion(newServicioId, imageUrl);
          HabitacionController sc = Get.find();
          await sc.consultarHabitaciones();
        }
      }
    } else {
      await HabitacionServices.actualizarHabitacion(widget.servicio!.id, {
        "nombre": nombre,
        "descripcion": descripcion,
        "direccion": direccion,
        "mensualidad": mensualidad,
      });
      if (image != null) {
        String? imageUrl = await HabitacionServices()
            .uploadHabitacionCover(image!, widget.servicio!.id);
        if (imageUrl != null) {
          await HabitacionServices()
              .updateCoverHabitacion(widget.servicio!.id, imageUrl);
          HabitacionController sc = Get.find();
          await sc.consultarHabitaciones();
        }
      }
    }
    Get.offAllNamed('/listarhabitaciones');
  }
}