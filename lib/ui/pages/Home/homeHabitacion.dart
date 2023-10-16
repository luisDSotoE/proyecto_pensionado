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
      'Imagen': "assets/image/Habitacion.jpg"
    },
    {
      'Titulo': "Habitacion 2",
      'Descripcion': "Pension con bonita estructura",
      'Imagen': "assets/image/Casa.jpg"
    },
  ];

  ListHabitaciones({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/image/Home.jpg"), fit: BoxFit.cover)),
      child: ListView.builder(
        itemCount: products.length,
        itemBuilder: (BuildContext context, int index) {
          final product = products[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return Photo(product: product);
              }));
            },
            child: Card(
                elevation: 5,
                margin: const EdgeInsets.all(10),
                child: Column(
                  children: <Widget>[
                    Image.asset(
                      product['Imagen'],
                      height: 150,
                      width: 150,
                      fit: BoxFit.cover,
                    ),
                    ListTile(
                      title: Text(product['Titulo']),
                      subtitle: Text(product['Descripcion']),
                    ),
                  ],
                )),
          );
        },
      ),
    );
  }
}

class Photo extends StatelessWidget {
  const Photo({super.key, required this.product});

  final Map<String, dynamic> product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product['Titulo'],
            style: const TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: PhotoView(imageProvider: AssetImage(product['Imagen'])),
      bottomNavigationBar: BottomAppBar(
        color: Colors.transparent,
        elevation: 0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                Navigator.of(context).pop(); // Regresar a la pantalla anterior (ListHabitaciones)
              },
            ),
          ],
        ),
      ),
    );
  }
}
