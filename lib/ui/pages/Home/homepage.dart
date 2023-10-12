import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:proyecto_pension2/ui/pages/Home/homeEditar.dart';
import 'package:proyecto_pension2/ui/pages/Home/homeHabitacion.dart';
import 'package:proyecto_pension2/ui/pages/Login/iniciosesion.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int posicion = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  final ventanas = [
    const Center(
      child: Text(
        "HOME",
        style: TextStyle(fontSize: 24),
      ),
    ),
    const Center(
      child: Text(
        "CHATS",
        style: TextStyle(fontSize: 24),
      ),
    ),
    const Center(
      child: Text(
        "CONFIGURACION",
        style: TextStyle(fontSize: 24),
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              leading: const Icon(Icons.support),
              title: const Text('Soporte técnico'),
              onTap: () {
                // Acción para soporte técnico
              },
            ),
            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text('Editar datos'),
              onTap: () {
                // Navegar a la pantalla de edición al presionar "Editar datos"
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const HomeEditar()),
                );
              },
            ),
            ListTile(
        leading: const Icon(Icons.hotel),
        title: const Text('Habitación'),
        onTap: () {
          // Navegar a la pantalla de gestión de habitaciones (HomeHabitacion)
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const HomeHabitacion()),
          );
        },
      ),
            ListTile(
              leading: const Icon(Icons.exit_to_app),
              title: const Text('Cerrar sesión'),
              onTap: () {
                // Navegar a la pantalla de inicio de sesión al cerrar sesión
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                  (Route<dynamic> route) => false,
                );
              },
            ),
            
          ],
        ),
      ),
      body: ventanas[posicion],
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: GNav(
          selectedIndex: posicion,
          onTabChange: (index) {
            setState(() {
              if (index == 1) {
                // Abrir la pantalla de búsqueda
                // ...
                return;
              }
              posicion = index;
              if (posicion == 2) {
                _scaffoldKey.currentState?.openDrawer();
              }
            });
          },
          color: Colors.blue,
          tabBackgroundColor: Colors.blue,
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
            ButtonIcons(
              icon: Icons.settings_outlined,
              iconActiveColor: Colors.white,
              textColor: Colors.white,
              text: "Configuración",
            ),
          ],
        ),
      ),
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
