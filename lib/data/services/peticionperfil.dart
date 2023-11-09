import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as fs;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:proyecto_pension2/domain/controllers/controluser.dart';

class Peticiones {
  static final ControlUserAuth controlua = Get.find();
  static final fs.FirebaseStorage storage = fs.FirebaseStorage.instance;
  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  static Future<void> crearcatalogo(Map<String, dynamic> catalogo, foto) async {
    print(catalogo['foto']);

    var url = '';
    if (foto != null) {
      url = await cargarfoto(foto, controlua.userValido!.user!.uid);
    }
    print(url);
    catalogo['foto'] = url.toString();

    await _db
        .collection('perfiles')
        .doc(controlua.userValido!.user!.uid)
        .set(catalogo)
        .catchError((e) {
      print(e);
    });
  }

  static Future<dynamic> cargarfoto(var foto, var idArt) async {
    final fs.Reference storageReference =
        fs.FirebaseStorage.instance.ref().child("fotos");

    fs.TaskSnapshot taskSnapshot =
        await storageReference.child(idArt).putFile(foto);

    var url = await taskSnapshot.ref.getDownloadURL();
    print('url:' + url.toString());
    return url.toString();
  }

  static Future<Map<String, dynamic>?> obtenerPerfil(String userId) async {
    final documentSnapshot = await _db.collection('perfiles').doc(userId).get();
    if (documentSnapshot.exists) {
      return documentSnapshot.data() as Map<String, dynamic>;
    }
    return null;
  }

  

  static Future<void> actualizarcatalogo(
      String id, Map<String, dynamic> catalogo) async {
    await _db.collection('perfiles').doc(id).update(catalogo).catchError((e) {
      print(e);
    });
  }

  static Future<void> eliminarcatalogo(String id) async {
    await _db.collection('perfiles').doc(id).delete().catchError((e) {
      print(e);
    });
  }

  static Future<String> subirImagen(File image, String userId) async {
    final fs.Reference storageReference = fs.FirebaseStorage.instance
        .ref()
        .child('fotos')
        .child('$userId${image.path.split('/').last}');

    fs.TaskSnapshot taskSnapshot = await storageReference.putFile(image);

    var imageUrl = await taskSnapshot.ref.getDownloadURL();
    return imageUrl.toString();
  }

   static Future<String?> uploadPerfilCover(
      String imagePath, String newPerfilFoto) async {
    try {
      File image = File(imagePath);
      final ext = image.path.split('.').last.toLowerCase();
      if (ext == 'png' || ext == 'jpg') {
        var uploadTask = await FirebaseStorage.instance
            .ref('perfiles/$newPerfilFoto.$ext')
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
}
