import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:proyecto_pension2/domain/controllers/controluser.dart';
import 'package:proyecto_pension2/data/services/peticionperfil.dart';

class Perfil extends StatefulWidget {
  const Perfil({super.key});

  @override
  _PerfilState createState() => _PerfilState();
}

class _PerfilState extends State<Perfil> {
  final controlNombre = TextEditingController();
  final controlApellido = TextEditingController();
  final controlProfesion = TextEditingController();
  final controlCorreo = TextEditingController();
  final controlUser = TextEditingController();
  final controlCiudad = TextEditingController();
  final controlDireccion = TextEditingController();
  final controlCelular = TextEditingController();

  final picker = ImagePicker();
  File? _image;
  String? image;

  // Define una variable para almacenar los datos del perfil
  Map<String, dynamic>? perfil;

  _galeria() async {
    final image =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 50);

    setState(() {
      _image = (image != null) ? File(image.path) : null;
    });
  }

  _camara() async {
    final image =
        await picker.pickImage(source: ImageSource.camera, imageQuality: 50);

    setState(() {
      _image = (image != null) ? File(image.path) : null;
    });
  }

  @override
  void initState() {
    super.initState();
    cargarInformacionPerfil();
  }

  Future<void> cargarInformacionPerfil() async {
    final cua = Get.find<ControlUserAuth>();
    perfil = await Peticiones.obtenerPerfil(cua.userValido!.user!.uid);
    if (perfil != null) {
      controlNombre.text = perfil!['nombre'] ?? '';
      controlApellido.text = perfil!['apellido'] ?? '';
      controlProfesion.text = perfil!['profesion'] ?? '';
      controlCorreo.text = perfil!['correo'] ?? '';
      controlUser.text = perfil!['user'] ?? '';
      controlCiudad.text = perfil!['ciudad'] ?? '';
      controlDireccion.text = perfil!['direccion'] ?? '';
      controlCelular.text = perfil!['telefono'] ?? '';

      final imageUrl = perfil!['foto'];

      if (imageUrl != null) {
        setState(() {
          image = imageUrl;
        });
      }
    }
  }

  Future<void> _subirImagen() async {
    final cua = Get.find<ControlUserAuth>();

    if (_image != null) {
      var imageUrl = await Peticiones.uploadPerfilCover(
          _image!.path, cua.userValido!.user!.uid);

      var nuevoPerfil = <String, dynamic>{
        'nombre': controlNombre.text,
        'apellido': controlApellido.text,
        'profesion': controlProfesion.text,
        'correo': controlCorreo.text,
        'user': controlUser.text,
        'ciudad': controlCiudad.text,
        'direccion': controlDireccion.text,
        'telefono': controlCelular.text,
        'foto': imageUrl,
      };

      await Peticiones.actualizarcatalogo(
          cua.userValido!.user!.uid, nuevoPerfil);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Completar Perfil"),
      ),
      body: Container(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: ListView(
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  _opcioncamara(context);
                },
                child: Container(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                  height: 220,
                  width: double.maxFinite,
                  child: const Card(
                    elevation: 5,
                    child: Icon(
                      Icons.camera_alt,
                      color: Colors.grey,
                      size: 70,
                    ),
                  ),
                ),
              ),
              TextField(
                controller: controlNombre,
                decoration: const InputDecoration(labelText: "Nombre"),
              ),
              TextField(
                controller: controlApellido,
                decoration: const InputDecoration(labelText: "Apellido"),
              ),
              TextField(
                controller: controlProfesion,
                decoration: const InputDecoration(labelText: "Profesion"),
              ),
              TextField(
                controller: controlCorreo,
                decoration: const InputDecoration(
                  labelText: "Correo",
                ),
                enabled: false,
                style: const TextStyle(color: Colors.black),
              ),
              TextField(
                controller: controlUser,
                decoration: const InputDecoration(labelText: "User"),
                enabled: false,
                style: const TextStyle(color: Colors.black),
              ),
              TextField(
                controller: controlCiudad,
                decoration: const InputDecoration(labelText: "Ciudad"),
              ),
              TextField(
                controller: controlDireccion,
                decoration: const InputDecoration(labelText: "Direccion"),
              ),
              TextField(
                controller: controlCelular,
                decoration: const InputDecoration(labelText: "Celular"),
              ),
              const SizedBox(height: 30,),
              ElevatedButton.icon(
                style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll<Color>(Colors.blue),),
                icon: const Icon(Icons.perm_identity_sharp, color: Colors.white,),
                label: const Text("Actualizar Perfil",style: TextStyle(color: Colors.white),),
                onPressed: () async {
                  await _subirImagen();
                  ControlUserAuth aut = Get.find();
                  aut.cargarNombreYFoto();
                  Get.offAllNamed('/home');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _opcioncamara(context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: Container(
            child: Wrap(
              children: <Widget>[
                ListTile(
                  leading: const Icon(Icons.photo_library),
                  title: const Text('Imagen de Galeria'),
                  onTap: () {
                    _galeria();
                    Navigator.of(context).pop();
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.photo_camera),
                  title: const Text('Capturar Imagen'),
                  onTap: () {
                    _camara();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
