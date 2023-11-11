import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:proyecto_pension2/data/services/habitacionServices.dart';
import 'package:proyecto_pension2/domain/models/habitacion.dart';

class HabitacionController extends GetxController {
  final Rxn<List<Habitacion>> _habitacionFirestore =
      Rxn<List<Habitacion>>([]);

  Future<void> consultarHabitaciones() async {
    _habitacionFirestore.value = await HabitacionServices.listaHabitacion();
  }

  Future<void> actualizarHabitacion(String id, Map<String, dynamic> datos) async {
    await HabitacionServices.updateHabitacion(id, datos);
  }
    Future<void> eliminarHabitacion(String id) async {
    await HabitacionServices.eliminarHabitacion(id);
    _habitacionFirestore.value?.removeWhere((habitacion) => habitacion.id == id);
  }
  

  List<Habitacion>? get listahab =>
      _habitacionFirestore.value;


}