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
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final ventanas = [
    const Center(child: Habitaciones()),
    const Center(child: Text("", style: TextStyle(fontSize: 24))),
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
        ),
      ),
      key: _scaffoldKey,
      drawer: Drawer(
        child: ListView(
          children: [
            const UserAccountsDrawerHeader(
              accountName: Text(
    "Luis Soto",
    style: TextStyle(color: Colors.black), 
  ),
  accountEmail: Text(
    "ldosoto@unicesar.edu.co",
    style: TextStyle(color: Colors.black), 
  ),
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage(
                  "https://blog.hubspot.es/hs-fs/hubfs/ES%20Blog%20images/Los%2015%20logos%20m%C3%A1s%20creativos%20e%20inspiradores%20del%20mundo/logo_famoso_starbucks.jpg?width=650&name=logo_famoso_starbucks.jpg",
                ),
              ),
              decoration: BoxDecoration(
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
                  MaterialPageRoute(builder: (context) => const Habitacion()),
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
