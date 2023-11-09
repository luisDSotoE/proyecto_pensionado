import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:proyecto_pension2/domain/controllers/controlperfil.dart';
import 'package:proyecto_pension2/domain/controllers/controluser.dart';
import 'package:proyecto_pension2/domain/controllers/habitacion_controller.dart';
import 'package:proyecto_pension2/ui/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Get.put(HabitacionController());
  Get.put(ControlUserPerfil());
  Get.put(ControlUserAuth());
  runApp(const Myapp());
}
