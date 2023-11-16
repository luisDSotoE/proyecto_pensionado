import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:proyecto_pension2/data/services/habitacionServices.dart';
import 'package:proyecto_pension2/data/services/peticionperfil.dart';
import 'package:proyecto_pension2/domain/controllers/controluser.dart';
import 'package:proyecto_pension2/domain/controllers/habitacion_controller.dart';
import 'package:proyecto_pension2/domain/models/habitacion.dart';
import 'package:proyecto_pension2/ui/pages/Login/iniciosesion.dart';
import 'package:proyecto_pension2/ui/pages/Widgets/textinput.dart';
import 'package:proyecto_pension2/ui/pages/Widgets/widgetCajaTexto.dart';

class Editaragregarhabiatcion extends StatelessWidget {
  const Editaragregarhabiatcion({super.key});

  @override
  Widget build(BuildContext context) {
    final Habitacion? servicio = Get.arguments as Habitacion?;
    return Scaffold(
      //extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title:
            Text(servicio != null ? 'Editar Habitación' : 'Agregar Habitación'),
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/image/HabitacionRegistrar.jpg"),
                fit: BoxFit.cover)),
        child: Column(
          children: [
            EditServicioForm(
              servicio: servicio,
            )
          ],
        ),
      ),
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
  final celularController = TextEditingController();

  // bool isDisponible = false;
  String? image;
  String textoBoton = "Subir foto";
  bool estado = false;

  bool savingServicio = false;

  Future<void> cargarTelefono() async {
    final cua = Get.find<ControlUserAuth>();
    var perfil = await Peticiones.obtenerPerfil(cua.userValido!.user!.uid);
    celularController.text = perfil!["celular"];
  }

  @override
  void initState() {
    super.initState();

    cargarTelefono();
    if (widget.servicio != null) {
      nombreController.text = widget.servicio!.nombre;
      direccionController.text = widget.servicio!.direccion;
      descripcionController.text = widget.servicio!.descripcion;
      mensualidadController.text = widget.servicio!.mensualidad.toString();
      celularController.text = widget.servicio!.celular;
      if (widget.servicio!.imagen.contains('http')) {
        estado = true;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (savingServicio) {
      return const Center(child: CircularProgressIndicator());
    }
    return Expanded(
      child: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.22),
            child: Column(
              children: [
                CajaTexto(
                    controller: nombreController,
                    tipo: TextInputType.text,
                    titulo: 'Nombre'),
                CajaTexto(
                    controller: direccionController,
                    tipo: TextInputType.text,
                    titulo: 'Direccion'),
                CajaTexto(
                    controller: descripcionController,
                    tipo: TextInputType.text,
                    titulo: 'Descripción'),
                CajaTexto(
                    controller: mensualidadController,
                    tipo: const TextInputType.numberWithOptions(decimal: true),
                    titulo: 'Mensualidad'),
                CajaTexto(
                    controller: celularController,
                    tipo: TextInputType.number,
                    titulo: '# Contacto'),
                const SizedBox(
                  height: 15,
                ),
                ElevatedButton.icon(
                  onPressed: () async {
                    try {
                      FilePickerResult? result =
                          await FilePicker.platform.pickFiles();
                      if (result != null) {
                        setState(() {
                          image = result.files.single.path;
                          estado = true;
                          print("url : $image");
                          if ((image?.contains("jpg") == false)&&(image?.contains("png") == false))
                          {
                            MensajeError("¡ERROR!", "Formato de imagen incorrecto");
                            estado = false;
                          }
                        });
                      }
                    } catch (e) {
                      e.printError();
                    }
                  },
                  icon: Icon(
                    estado ? Icons.check : Icons.cloud_upload,
                    color: Colors.white,
                  ),
                  label: Text(
                    estado ? "Foto Subida" : "Subir Foto",
                    style: const TextStyle(color: Colors.white),
                  ),
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.blue)),
                ),
                const SizedBox(
                  height: 35,
                ),
                SizedBox(
                  width: 200,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      if ((nombreController.text == "") ||
                          (direccionController.text == "") ||
                          (descripcionController.text == "") ||
                          (mensualidadController.text == "") ||
                          (celularController.text == "") ||
                          (estado == false)) {
                        MensajeError(
                            "¡ADVERTENCIA!", "No se aceptan campos vacios");
                      } else {
                        guardarHabitacion(context);
                        nombreController.clear();
                        direccionController.clear();
                        descripcionController.clear();
                        mensualidadController.clear();
                        Navigator.pop(context);
                      }
                    },
                    icon: const Icon(
                      Icons.save,
                      color: Colors.white,
                    ),
                    label: const Text(
                      "Guardar",
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.yellow)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void guardarHabitacion(BuildContext context) async {
    ControlUserAuth controlUserAuth = Get.find();

    var nombre = nombreController.text;
    var direccion = direccionController.text;
    var descripcion = descripcionController.text;
    var mensualidad = double.parse(mensualidadController.text);
    var celular = celularController.text;

    if (widget.servicio == null) {
      String newServicioId = await HabitacionServices().guardarHabitacion(
          nombre, direccion, descripcion, mensualidad, celular);
      if (image != null) {
        String? imageUrl = await HabitacionServices()
            .uploadHabitacionCover(image!, newServicioId);
        if (imageUrl != null) {
          await HabitacionServices()
              .updateCoverHabitacion(newServicioId, imageUrl);
          HabitacionController sc = Get.find();
          await sc.consultarHabitaciones(controlUserAuth.uidUsuarioAutenticado);
        }
      }
    } else {
      ControlUserAuth controlUserAuth = Get.find();
      await HabitacionServices.actualizarHabitacion(widget.servicio!.id, {
        "nombre": nombre,
        "descripcion": descripcion,
        "direccion": direccion,
        "mensualidad": mensualidad,
        "celular": celular,
        'user': controlUserAuth.uidUsuarioAutenticado
      });
      if (image != null) {
        String? imageUrl = await HabitacionServices()
            .uploadHabitacionCover(image!, widget.servicio!.id);
        if (imageUrl != null) {
          await HabitacionServices()
              .updateCoverHabitacion(widget.servicio!.id, imageUrl);
          HabitacionController sc = Get.find();
          ControlUserAuth controlUserAuth = Get.find();

          await sc.consultarHabitaciones(controlUserAuth.uidUsuarioAutenticado);
        }
      }
    }
    Get.offAllNamed('/listarhabitaciones');
  }
}
