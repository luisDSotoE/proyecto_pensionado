import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';


class Habitaciones extends StatelessWidget {
  const Habitaciones({super.key});

  @override
  Widget build(BuildContext context) {
    return ListHabitaciones();
  }
}

class ListHabitaciones extends StatelessWidget {
  final List<Map<String, dynamic>> products = [
    {
      'Titulo': "Habitacion 1",
      'Descripcion': "Habitacion con mirada hacia la ciudad",
      'Mensualidad': 800.000,   
      'Direccion': 'Kr 20',
      'Imagen': "assets/image/Habitacion.jpg"
    },
    {
      'Titulo': "Habitacion 2",
      'Descripcion': "Pension con bonita estructura",
      'Mensualidad': 800.000,
      'Direccion': 'Kr 20',
      'Imagen': "assets/image/Casa.jpg"
    },
    {
      'Titulo': "Habitacion 3",
      'Descripcion': "Habitacion con mirada hacia la ciudad en el barrio x",
      'Mensualidad': 800.000,
      'Direccion': 'Kr 20',
      'Imagen': "assets/image/Habitacion.jpg"
    },
    
  ];

  ListHabitaciones({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (BuildContext context, int index) {
        final product = products[index];
        return Card(
              elevation: 5,
              margin: const EdgeInsets.all(10),
              child: Column(
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                      return Photo(product: product);
                      }));
                    },
                    child: Image.asset(
                      product['Imagen'],
                      height: 150,
                      width: 150,
                      fit: BoxFit.cover,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      //Abrir ventana para observar la habitacion bien
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                      return DetallesHabitacion(cuarto: product);
                      }));
                    },
                    child: ListTile(
                      title: Text(product['Titulo']),
                      subtitle: Text(product['Descripcion']),
                    ),
                  ),
                ],
              ));
      },
    );
  }
}

class Photo extends StatelessWidget {
  const Photo({super.key, required this.product});

  final Map<String, dynamic> product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        title: Text(product['Titulo'],
            style: const TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: PhotoView(imageProvider: AssetImage(product['Imagen'])),
      
    );
  }
}

class DetallesHabitacion extends StatelessWidget {
  final Map<String, dynamic> cuarto;

  const DetallesHabitacion({super.key, required this.cuarto});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalles de la habitacion'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(cuarto['Imagen'], width: 200, height: 200,),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Direccion: ${cuarto['Direccion']}'),
                Text('Mensualidad: \$${cuarto['Mensualidad']}'),
                Text('Description: ${cuarto['Descripcion']}'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


