import 'package:flutter/material.dart';
import 'package:proyecto_pension2/domain/models/habitacion.dart';
import 'package:proyecto_pension2/ui/pages/Widgets/VerFotosHabitaciones.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:proyecto_pension2/ui/pages/Home/homeSoporte.dart';

class DetalleHabitacionScreen extends StatefulWidget {
  final Habitacion servicio;

  const DetalleHabitacionScreen({Key? key, required this.servicio})
      : super(key: key);

  @override
  _DetalleHabitacionScreenState createState() =>
      _DetalleHabitacionScreenState();
}

class _DetalleHabitacionScreenState extends State<DetalleHabitacionScreen> {
  bool _mapaCargado = false;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalle Habitación'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return VerFoto(
                    nombre: widget.servicio.nombre,
                    imagen: widget.servicio.imagen,
                  );
                }));
              },
              child: ServicioCoverWidget(coverUrl: widget.servicio.imagen),
            ),
            ServicioInfoWidget(
              nombre: "Nombre: ${widget.servicio.nombre}",
              descripcion: "Descripción: ${widget.servicio.descripcion}",
              direccion: "Dirección: ${widget.servicio.direccion}",
              mensualidad: "Mensualidad: \$${widget.servicio.mensualidad}",
              celular: "# Contacto: ${widget.servicio.celular}",
            ),
            ElevatedButton.icon(
            onPressed: (){
              ContactoWhatsApp(widget.servicio.celular);
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
              iconColor: MaterialStateProperty.all<Color>(Colors.white),
            ), 
            icon: const Icon(Icons.perm_phone_msg_sharp), 
            label: const Text("Ir a Whatsaps", style: TextStyle(color: Colors.white),)),
            const SizedBox(height: 20,),
            ElevatedButton.icon(
              onPressed: () {
                print(
                    'Dirección a abrir en Google Maps: ${widget.servicio.direccion}');
                _abrirDireccionEnGoogleMaps(widget.servicio.direccion);
              },
              style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
              iconColor: MaterialStateProperty.all<Color>(Colors.white),
              ), 
              icon: const Icon(Icons.map),
              label: const Text('Abrir en Google Maps', style: TextStyle(color: Colors.white),),
            ),
            const SizedBox(height: 20,),
            _mapaCargado
                ? SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.8,
                    child: WebView(
                      initialUrl:
                          'https://www.google.com/maps?q=${widget.servicio.direccion},Valledupar',
                      javascriptMode: JavascriptMode.unrestricted,
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }

  void _abrirDireccionEnGoogleMaps(String direccion) async {
    String googleMapsUrl =
        'https://www.google.com/maps/search/?api=1&query=$direccion';
    try {
      if (await canLaunch(googleMapsUrl)) {
        await launch(googleMapsUrl);
      } else {
        throw 'No se pudo abrir Google Maps';
      }
    } catch (error) {
      print('Error al abrir Google Maps: $error');
    }
  }

  @override
  void initState() {
    super.initState();
    _cargarMapa();
  }

  void _cargarMapa() {
    // Lógica para cargar el mapa
    print('Mapa cargado con la dirección: ${widget.servicio.direccion}');
    setState(() {
      _mapaCargado = true;
    });
  }
}

class ServicioCoverWidget extends StatelessWidget {
  final String coverUrl;
  const ServicioCoverWidget({Key? key, required this.coverUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20, bottom: 20),
      width: 400,
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 5,
            blurRadius: 10)
      ]),
      child: getImageWidget(coverUrl),
    );
  }

  getImageWidget(String imagenes) {
    if (imagenes.startsWith("http")) {
      return Image.network(imagenes, height: 150, width: 150);
    } else {
      return Image.asset(imagenes, height: 150, width: 150);
    }
  }
}

class ServicioInfoWidget extends StatelessWidget {
  final String nombre;
  final String descripcion;
  final String direccion;
  final String mensualidad;
  final String celular;

  const ServicioInfoWidget({
    Key? key,
    required this.nombre,
    required this.descripcion,
    required this.direccion,
    required this.mensualidad,
    required this.celular
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        children: [
          Text(
            nombre,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            descripcion,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
          Text(
            direccion,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
          Text(
            mensualidad,
            style: const TextStyle(
              fontSize: 16,
            ),
            textAlign: TextAlign.start,
          ),
          Text(
            celular,
            style: const TextStyle(
              fontSize: 16,
            ),
            textAlign: TextAlign.start,
          ),
        ],
      ),
    );
  }
}
