import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:proyecto_pension2/domain/controllers/controluser.dart';
import 'package:proyecto_pension2/domain/models/habitacion.dart';

class HabitacionServices {
  static final FirebaseFirestore _db = FirebaseFirestore.instance;
  ControlUserAuth controlUserAuth = Get.find();

  final servRef = FirebaseFirestore.instance
      .collection('habitaciones')
      .withConverter(
          fromFirestore: (snapshop, _) =>
              Habitacion.desdeDoc(snapshop.id, snapshop.data()!),
          toFirestore: (serv, _) => serv.toJson());

  Future<String> guardarHabitacion(String nombre, String direccion,
      String descripcion, double mensualidad, String celular) async {
    var reference = FirebaseFirestore.instance.collection("habitaciones");
    var result = await reference.add({
      'nombre': nombre,
      'descripcion': descripcion,
      'direccion': direccion,
      'mensualidad': mensualidad,
      'user': controlUserAuth.uidUsuarioAutenticado,
      'celular': celular
    });
    return Future.value(result.id);
  }

  static Future<List<Habitacion>> listadogeneral() async {
    QuerySnapshot querySnapshot = await _db.collection("habitaciones").get();
    List<Habitacion> lista = [];
    for (var doc in querySnapshot.docs) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      lista.add(Habitacion.desdeDoc(doc.id, data));
    }
    return lista;
  }

  static Future<List<Habitacion>> listaHabitacion(
      String uidUsuarioAutenticado) async {
    QuerySnapshot querySnapshot = await _db
        .collection("habitaciones")
        .where("user", isEqualTo: uidUsuarioAutenticado)
        .get();

    List<Habitacion> lista = [];

    for (var doc in querySnapshot.docs) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      lista.add(Habitacion.desdeDoc(doc.id, data));
    }

    return lista;
  }

  Future<String?> uploadHabitacionCover(
      String imagePath, String newHabitacionId) async {
    try {
      File image = File(imagePath);
      final ext = image.path.split('.').last.toLowerCase();
      if (ext == 'png' || ext == 'jpg') {
        var uploadTask = await FirebaseStorage.instance
            .ref('habitacion/$newHabitacionId.$ext')
            .putFile(image);
        debugPrint('Subida completada');
        var downloadUrl = await uploadTask.ref.getDownloadURL();
        return downloadUrl;
      } else {
        debugPrint(
            'Formato de imagen no válido. Solo se permiten archivos .png o .jpg.');
        return null;
      }
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  Future<void> updateCoverHabitacion(
      String newServicio, String imageUrl) async {
    var reference =
        FirebaseFirestore.instance.collection("habitaciones").doc(newServicio);
    return reference.update({
      'imagenes': imageUrl,
    });
  }

  static Future<void> updateHabitacion(
      String id, Map<String, dynamic> datos) async {
    await _db.collection('habitaciones').doc(id).update(datos).catchError((e) {
      print('Error');
    });
  }

  static Future<List<Habitacion>> listarServicios() async {
    QuerySnapshot querySnapshot = await _db.collection("servicios").get();
    List<Habitacion> lista = [];
    for (var doc in querySnapshot.docs) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      lista.add(Habitacion.desdeDoc(doc.id, data));
    }
    return lista;
  }

  static Future<void> actualizarHabitacion(
      String id, Map<String, dynamic> datos) async {
    await _db.collection('habitaciones').doc(id).update(datos).catchError((e) {
      print('Error al actualizar la habitación: $e');
    });
  }

  static Future<void> eliminarHabitacion(String id) async {
    await _db.collection('habitaciones').doc(id).delete().catchError((e) {});
  }

  Future<String> obtenerDireccionDesdeFirestore() async {
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('direcciones')
        .doc('mi_direccion')
        .get();
    String direccion = snapshot.get('direccion');
    return direccion;
  }
}
