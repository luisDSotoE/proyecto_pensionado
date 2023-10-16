
import 'package:flutter/material.dart';
import 'package:proyecto_pension2/ui/pages/Login/reg_u_normal.dart';
import 'package:proyecto_pension2/ui/pages/Login/reg_u_propietario.dart';

class MenuOpcionesRegistro extends StatelessWidget {
  const MenuOpcionesRegistro({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          image: DecorationImage(image: AssetImage("assets/image/Casa.jpg"), fit: BoxFit.cover),
        ),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 200.0,
                  height: 200.0,
                  child: Image.asset("assets/image/Logo.png", width: 100, height: 100),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Elige una opción',
                  style: TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const RegistroUsuarioNormal()),
                    );
                  },
                  style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all(Colors.black),
                  ),
                  
                  child: const Text('Registro de Usuario'),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const RegistroUsuarioPropietario()),
                    );
                  },
                  style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all( Colors.black),
                  ),
                  child: const Text('Registro de Propietario'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
