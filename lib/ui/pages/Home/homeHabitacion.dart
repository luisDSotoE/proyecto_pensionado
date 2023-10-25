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
      'Descripcion': "Habitacion con mirada hacia la ciudad, con mira hacia la universidad X",
      'Mensualidad': 800.000,   
      'Direccion': 'Kr 21',
      'Imagen': "assets/image/Habitacion.jpg"
    },
    {
      'Titulo': "Habitacion 2",
      'Descripcion': "Pension con bonita estructura",
      'Mensualidad': 950.000,
      'Direccion': 'Kr 20',
      'Imagen': "assets/image/Casa.jpg"
    },
    {
      'Titulo': "Habitacion 3",
      'Descripcion': "Habitacion con mirada hacia la ciudad en el barrio x",
      'Mensualidad': 1200.000,
      'Direccion': 'Kr 10',
      'Imagen': "assets/image/Habitacion.jpg"
    },
    
  ];

  

  ListHabitaciones({super.key});

@override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
        itemCount: products.length,
        itemBuilder: (BuildContext context, int index) {
          final product = products[index];        
          int limiteDescricion = 30;
          String descr = product["Descripcion"];
          String DescripcionRecortada = descr.length > limiteDescricion? 
          descr.substring(0,limiteDescricion)+"..." : descr;
          return Card(
            color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) {
                          return Photo(product: product);
                        }));
                      },
                        child: Image.asset(product['Imagen'],
                          width:  100,  
                          height:  100, 
                          fit: BoxFit.cover,
                        ),
                      ),
                      ),
                      GestureDetector(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) {
                              return DetallesHabitacion(cuarto: product);
                            }));
                            },
                            child: Wrap(
                              children:[ 
                                Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(product['Titulo'], style: const TextStyle(fontWeight: FontWeight.bold),),
                                  Container(
                                  width: MediaQuery.of(context).size.width - 150, // Ancho máximo para el texto
                                  child: Text(DescripcionRecortada),
                                  ),
                                  Text("\$${product['Mensualidad']}", style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold),),
                                  ],
                              ),]
                            ),
                          ),
                  ],
                ),
              ),
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
        backgroundColor: const Color.fromARGB(255, 122, 171, 212),
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


