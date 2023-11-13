import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:proyecto_pension2/domain/controllers/controluser.dart';
import 'package:proyecto_pension2/domain/controllers/habitacion_controller.dart';
import 'package:proyecto_pension2/ui/pages/Home/homeBuscador.dart';
import 'package:proyecto_pension2/ui/pages/Home/homeHabitacion.dart';
import 'package:proyecto_pension2/ui/pages/Home/homeSoporte.dart';
import 'package:proyecto_pension2/ui/pages/Home/perfil.dart';
import 'package:proyecto_pension2/ui/pages/Widgets/VerFotosHabitaciones.dart';
import 'package:proyecto_pension2/ui/pages/habitacion/detallehabitacion.dart';
import 'package:proyecto_pension2/ui/pages/habitacion/listarHabitaciones.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  ControlUserAuth cua = Get.find();

  int posicion = 0;
  late final GlobalKey<ScaffoldState> _scaffoldKey;


  final ventanas = [
    const Center(child: Habitaciones()),
    const Buscador(),
  ];

  @override
  void initState() {
    super.initState();
    _scaffoldKey = GlobalKey<ScaffoldState>();
    cua.cargarNombreYFoto();
  }

  Widget buildClienteDrawer() {
    ControlUserAuth controlUserAuth = Get.find();
    HabitacionController sc = Get.find();
    String? uidUsuarioAutenticado = controlUserAuth.userValido?.user?.uid;

    if (controlUserAuth.rol == 'Admin') {
      sc.consultarHabitaciones(uidUsuarioAutenticado);
    } else {
      sc.consultarHabitacionesgenerales();
    }

    return Drawer(
      child: Obx(
        () {
          final correo = cua.email ?? '';
          final nombre = cua.nombre ?? '';
          final fotoPerfil = cua.fotoPerfil ?? '';

          return Column(
            children: [
              UserAccountsDrawerHeader(
                accountName: Text(
                  nombre,
                  style: const TextStyle(color: Colors.black),
                ),
                accountEmail: Text(
                  correo,
                  style: const TextStyle(color: Colors.black),
                ),
                currentAccountPicture: GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return VerFoto(
                        nombre: nombre,
                        imagen: fotoPerfil,
                      );
                    }));
                  },
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(fotoPerfil),
                  ),
                ),
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                      "https://static.vecteezy.com/system/resources/previews/007/620/939/non_2x/blue-wave-abstract-background-web-background-blue-texture-banner-design-creative-cover-design-backdrop-minimal-background-illustration-vector.jpg",
                    ),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.edit),
                title: const Text('Editar datos'),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const Perfil()),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.hotel),
                title: const Text('Listar Habitaciones'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DetalleHabitacionScreen(
                              servicio: sc.listahab![0],
                            )),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.contact_page_outlined),
                title: const Text('Soporte Tecnico'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SoporteTecnico()),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.exit_to_app),
                title: const Text('Cerrar sesión'),
                onTap: () {
                  cua.cerrarSesion();
                  Get.offAllNamed('/login');
                },
              ),
            ],
          );
        },
      ),
    );
  }

  Widget buildAdminDrawer() {
    ControlUserAuth cua = Get.find();
    cua.cargarNombreYFoto();
    final ControlUserAuth controlUserAuth = Get.find();
    final HabitacionController hc = Get.find();
    if (controlUserAuth.rol == 'Admin') {
      hc.consultarHabitaciones(controlUserAuth.userValido?.user?.uid);
    } else {
      hc.consultarHabitacionesgenerales();
    }
    return Drawer(
      child: Obx(
        () {
          final correo = cua.email ?? '';
          final nombre = cua.nombre ?? '';
          final fotoPerfil = cua.fotoPerfil ?? '';

          return ListView(
            children: [
              UserAccountsDrawerHeader(
                accountName: Text(
                  nombre,
                  style: const TextStyle(color: Colors.black),
                ),
                accountEmail: Text(
                  correo,
                  style: const TextStyle(color: Colors.black),
                ),
                currentAccountPicture: GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return VerFoto(
                        nombre: nombre,
                        imagen: fotoPerfil,
                      );
                    }));
                  },
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(fotoPerfil),
                  ),
                ),
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                      "https://static.vecteezy.com/system/resources/previews/007/620/939/non_2x/blue-wave-abstract-background-web-background-blue-texture-banner-design-creative-cover-design-backdrop-minimal-background-illustration-vector.jpg",
                    ),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.edit),
                title: const Text('Editar datos'),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const Perfil()),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.hotel),
                title: const Text('Habitación'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ListarHabitaciones()),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.contact_page_outlined),
                title: const Text('Soporte Tecnico'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SoporteTecnico()),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.exit_to_app),
                title: const Text('Cerrar sesión'),
                onTap: () {
                  cua.cerrarSesion();
                  Get.offAllNamed('/login');
                },
              ),
            ],
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      extendBody: true,
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 167, 192, 204),
        elevation: 0,
        flexibleSpace: FlexibleSpaceBar(
          centerTitle: true,
          background: Center(child: Image.asset("assets/image/Logo.png")),
        ),
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
            setState(() {
              cua.cargarNombreYFoto();
            });
          },
        ),
      ),
      drawer: cua.rol == 'Admin' ? buildAdminDrawer() : buildClienteDrawer(),
      body: Navegacion(ventanas: ventanas, posicion: posicion),
    );
  }
}

class Navegacion extends StatelessWidget {
  const Navegacion({
    Key? key,
    required this.ventanas,
    required this.posicion,
  }) : super(key: key);

  final List<Widget> ventanas;
  final int posicion;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/image/Home.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: ventanas[posicion],
    );
  }
}

class ButtonIcons extends GButton {
  const ButtonIcons({
    Key? key,
    required IconData icon,
    required Color iconActiveColor,
    required Color textColor,
    required String text,
  }) : super(
          key: key,
          icon: icon,
          iconActiveColor: iconActiveColor,
          textColor: textColor,
          text: text,
        );
}
