import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:proyecto_pension2/domain/controllers/controluser.dart';
import 'package:proyecto_pension2/ui/pages/Home/homeBuscador.dart';
import 'package:proyecto_pension2/ui/pages/Home/homeHabitacion.dart';
import 'package:proyecto_pension2/ui/pages/Home/homeSoporte.dart';
import 'package:proyecto_pension2/ui/pages/Home/perfil.dart';
import 'package:proyecto_pension2/ui/pages/Login/iniciosesion.dart';
import 'package:proyecto_pension2/ui/pages/habitacion/listarHabitaciones.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  ControlUserAuth cua = Get.find(); // Obtener el controlador ControlUser

  int posicion = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final ventanas = [
    const Center(child: Habitaciones()),
    const Buscador(),
  ];
  @override
  void initState() {
    super.initState();
    cua.cargarNombreYFoto(); // Llama al método para cargar el nombre y la foto de perfil
  }

  @override
  Widget build(BuildContext context) {
    ControlUserAuth cua = Get.find(); // Obtener el controlador ControlUser

    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: FlexibleSpaceBar(
          centerTitle: true,
          background: Center(child: Image.asset("assets/image/Logo.png")),
        ),
      ),
      key: _scaffoldKey,
      drawer: Drawer(
        child: Obx(
          () {
            final correo = cua.userValido?.user!.email ?? '';
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
                  currentAccountPicture: CircleAvatar(
                    backgroundImage: NetworkImage(fotoPerfil),
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
                  leading: const Icon(Icons.support),
                  title: const Text('Soporte técnico'),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => SoporteTecnico()),
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.exit_to_app),
                  title: const Text('Cerrar sesión'),
                  onTap: () {
                    cua.cerrarSesion();
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => LoginPage()),
                      (Route<dynamic> route) => false,
                    );
                  },
                ),
              ],
            );
          },
        ),
      ),
      body: Navegacion(ventanas: ventanas, posicion: posicion),
      bottomNavigationBar: Container(
        color: Colors.transparent,
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: GNav(
          selectedIndex: posicion,
          onTabChange: (index) {
            setState(() {
              posicion = index;
            });
          },
          color: Colors.yellow,
          tabBackgroundColor: Colors.yellow,
          tabBorderRadius: 10,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          tabs: const [
            ButtonIcons(
              icon: Icons.home,
              iconActiveColor: Colors.white,
              textColor: Colors.white,
              text: "Inicio",
            ),
            ButtonIcons(
              icon: Icons.search,
              iconActiveColor: Colors.white,
              textColor: Colors.white,
              text: "Buscar",
            ),
          ],
        ),
      ),
    );
  }
}

class Navegacion extends StatelessWidget {
  const Navegacion({
    super.key,
    required this.ventanas,
    required this.posicion,
  });

  final List<Widget> ventanas;
  final int posicion;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/image/Home.jpg"), fit: BoxFit.cover)),
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
