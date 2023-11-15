
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MyApp());
}

class Soporte{
  final String nombre;
  final String numero;

  Soporte({required this.nombre, required this.numero});
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SoporteTecnico(),
    );
  }
}

class SoporteTecnico extends StatelessWidget {
  final List<Soporte> soporte= [
    Soporte(nombre: 'Luis Soto', numero: '3125276355'),
    Soporte(nombre: 'Robin Restrepo', numero: '3235810758'),
  ];

 SoporteTecnico({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 99, 152, 196),
        title: const Text('Contacto de soporte'),
      ),
      body: Container(
        decoration:const  BoxDecoration(
          color: Color.fromARGB(255, 122, 171, 212)
        ),
        child: ListView.builder(
          itemCount: soporte.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Row(
                children: [
                  const Icon(Icons.contact_support_outlined),
                  const SizedBox(width: 10,),
                  Text(soporte[index].nombre),
                ],
              ),
              onTap: () {
                ContactoWhatsApp(soporte[index].numero);
              },
            );
          },
        ),
      ),
    );
  }

}

// ignore: non_constant_identifier_names
void ContactoWhatsApp(String phoneNumber) async {
    String url = "https://wa.me/${"+57$phoneNumber"}";
    // ignore: deprecated_member_use
    if (await canLaunch(url)) {
      // ignore: deprecated_member_use
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
