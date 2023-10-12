import 'package:flutter/material.dart';

class RegistroUsuarioPropietario extends StatelessWidget {
  const RegistroUsuarioPropietario({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Colors.blue,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //Imagen

            const Text("Registro Propietario", style: TextStyle(fontSize: 24, color: Colors.white) ),
          
          const SizedBox(height: 20,),

          Container(
            width: 300, 
            padding: const EdgeInsets.all(10),
            child: TextFormField(
              decoration: const InputDecoration(
                labelText: "Nombre de usuario",
                fillColor: Colors.white,
                filled: true,
              ),
            ),
          ),
          Container(
            width: 300,
            padding: const EdgeInsets.all(10),
            child: TextFormField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Cedula",
                fillColor: Colors.white,
                filled: true,
              ),
            ),
          ),
          Container(
              width: 300,
              padding: const EdgeInsets.all(10),
              child: TextFormField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: "Numero de telefono",
                  fillColor: Colors.white,
                  filled: true,
                ),
              ),
            ),
            Container(
              width: 300,
              padding: const EdgeInsets.all(10),
              child: TextFormField(
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: "Contraseña",
                  fillColor: Colors.white,
                  filled: true,
                ),
              ),
            ),

             const SizedBox(height: 20),

            // Botón de inicio de sesión
            Container(
              width: 300,
              child: ElevatedButton(
                onPressed: () {
                  // Aquí puedes agregar la lógica para el inicio de sesión
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.white)
                ),
                child: const Text("Registrarse", style: TextStyle(color: Colors.blue),),
              ),
            ),
          
          ],
        ),
      ),
    );
  }
}