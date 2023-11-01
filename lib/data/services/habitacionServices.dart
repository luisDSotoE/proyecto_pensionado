import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:proyecto_pension2/domain/models/habitacion.dart';

class HabitacionServices {
  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  final servRef = FirebaseFirestore.instance
      .collection('habitacion')
      .withConverter(
          fromFirestore: (snapshop, _) =>
              Habitacion.desdeDoc(snapshop.id, snapshop.data()!),
          toFirestore: (serv, _) => serv.toJson());

  static Future<List<Habitacion>> listaHabitacion() async {
    QuerySnapshot querySnapshot = await _db.collection("habitacion").get();
    List<Habitacion> lista = [];
    for (var doc in querySnapshot.docs) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      lista.add(Habitacion.desdeDoc(doc.id, data));
    }
    return lista;
  }

  static Future<void> updateHabitacion(
      String id, Map<String, dynamic> datos) async {
    await _db.collection('habitacion').doc(id).update(datos).catchError((e) {
      print('Error');
    });
  }

  Future<String> guardarHabitacion(String nombre, String direccion,
      String descripcion, double mensualidad) async {
    var reference = FirebaseFirestore.instance.collection("habitacion");
    var result = await reference.add({
      'nombre': nombre,
      'direccion': direccion,
      'descripcion': descripcion,
      'mensualidad': mensualidad,
    });
    return Future.value(result.id);
  }

  static Future<void> deleteHabitacion(String id) async {
    await _db.collection('habitacion').doc(id).delete().catchError((e) {
      e.printError();
    });
  }
}
