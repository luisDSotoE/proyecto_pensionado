import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:proyecto_pension2/ui/pages/Home/habitacionCrud.dart';
import 'package:proyecto_pension2/ui/pages/Home/homeEditar.dart';
import 'package:proyecto_pension2/ui/pages/Home/homeHabitacion.dart';
import 'package:proyecto_pension2/ui/pages/Home/homeSoporte.dart';
import 'package:proyecto_pension2/ui/pages/Login/iniciosesion.dart';



class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int posicion = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>(); // Agregado

  final ventanas = [
    const Center(child: Habitaciones()),
    const Center(child: Text("BUSCAR", style: TextStyle(fontSize: 24),)),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent, elevation: 0,
        flexibleSpace: FlexibleSpaceBar(
          centerTitle: true,
          background: Center(child: Image.asset("assets/image/Logo.png")),
          )
      ),
      key: _scaffoldKey, // Agregado
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              leading: const Icon(Icons.support),
              title: const Text('Soporte técnico'),
              onTap: () {Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => SoporteTecnico()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text('Editar datos'),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const HomeEditar()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.hotel),
              title: const Text('Habitación'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  const Habitacion()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.exit_to_app),
              title: const Text('Cerrar sesión'),
              onTap: () {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                  (Route<dynamic> route) => false,
                );
              },
            ),
          ],
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/image/Home.jpg"), fit: BoxFit.cover)),
        child: ventanas[posicion],
        ),
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
