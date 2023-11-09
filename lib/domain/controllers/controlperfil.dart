import 'package:get/get.dart';
import 'package:proyecto_pension2/data/services/peticionperfil.dart';

class ControlUserPerfil extends GetxController {
  Future<void> crearcatalogo(Map<String, dynamic> catalogo, foto) async {
    await Peticiones.crearcatalogo(catalogo, foto);
  }
}
