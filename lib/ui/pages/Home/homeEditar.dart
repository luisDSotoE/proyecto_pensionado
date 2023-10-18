import 'package:flutter/material.dart';

class HomeEditar extends StatelessWidget {
  const HomeEditar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Datos Personales'),
        backgroundColor: const Color.fromARGB(255, 122, 171, 212),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildTextField('Nombre'),
            _buildTextField('Apellido'),
            _buildTextField('Teléfono'),
            _buildTextField('Correo'),
            _buildChangePasswordButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: TextField(
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }

  Widget _buildChangePasswordButton(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.only(top: 20.0),
    child: ElevatedButton(
      onPressed: () {
        
      },
      child: const Text(
        'Guardar Cambios',
        style: TextStyle(
          color: Colors.black, 
        ),
      ),
    ),
  );
}
}
