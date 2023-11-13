import 'package:get/get.dart';
import 'package:proyecto_pension2/data/services/habitacionServices.dart';
import 'package:proyecto_pension2/domain/controllers/controluser.dart';
import 'package:proyecto_pension2/domain/models/habitacion.dart';

class HabitacionController extends GetxController {
  final Rxn<List<Habitacion>> _habitacionFirestore = Rxn<List<Habitacion>>([]);
  final controlUserAuth = Get.find<ControlUserAuth>();

  void actualizarListaSegunRol() {
    if (controlUserAuth.rol == 'Admin') {
      consultarHabitaciones(controlUserAuth.userValido?.user?.uid);
    } else {
      consultarHabitacionesgenerales();
    }
  }

  Future<void> consultarHabitacionesgenerales() async {
    _habitacionFirestore.value = await HabitacionServices.listadogeneral();
  }

  Future<void> consultarHabitaciones(String? uid) async {
    String? uidUsuarioAutenticado = controlUserAuth.userValido?.user?.uid;

    if (uidUsuarioAutenticado != null) {
      _habitacionFirestore.value =
          await HabitacionServices.listaHabitacion(uidUsuarioAutenticado);
    } else {
      print("No hay usuario autenticado");
    }
  }

  Future<void> actualizarHabitacion(
      String id, Map<String, dynamic> datos) async {
    await HabitacionServices.updateHabitacion(id, datos);
  }

  Future<void> eliminarHabitacion(String id) async {
    await HabitacionServices.eliminarHabitacion(id);
    _habitacionFirestore.value
        ?.removeWhere((habitacion) => habitacion.id == id);
  }

  List<Habitacion>? get listahab => _habitacionFirestore.value;
  List<Habitacion>? get listado2 => _habitacionFirestore.value;
}
