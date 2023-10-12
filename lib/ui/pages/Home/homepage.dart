import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int posicion = 0;

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
      appBar: AppBar(
        title: const Text(
          "MI PENSION",
          style: TextStyle(fontWeight: FontWeight.w700, color: Colors.white),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blue,
      ),
      body: ventanas[posicion],
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: GNav(
          selectedIndex: posicion,
          onTabChange: (index) {
            setState(() => posicion = index);
          },
          color: Colors.blue,
          tabBackgroundColor: Colors.blue,
          tabBorderRadius: 10,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          tabs: const[
            ButtonIcons(
              icon: Icons.home,
              iconActiveColor: Colors.white,
              textColor: Colors.white,
              text: "Inicio",
            ),
            ButtonIcons(
              icon: Icons.chat,
              iconActiveColor: Colors.white,
              textColor: Colors.white,
              text: "Chat",
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
  const ButtonIcons({super.key, 
    required IconData icon,
    required Color iconActiveColor,
    required Color textColor,
    required String text,
  }) : super(
          icon: icon,
          iconActiveColor: iconActiveColor,
          textColor: textColor,
          text: text,
        );
}


// import 'package:flutter/material.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Material App',
//       home: Scaffold(
//         drawer: Drawer(
//           child: Container(
//             color: Colors.blue,
//             child: Column(
//               children: [
//                 Container(
//                   width: MediaQuery.sizeOf(context).width*0.4,
//                   height: MediaQuery.sizeOf(context).height*0.2,
//                   margin: const EdgeInsets.only(top: 50, bottom: 20),
//                 child:  Image.network("https://cdn-icons-png.flaticon.com/512/1384/1384095.png"),
//                 ),
//                 const Text("Pensionado", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
//                 Container(
//                   margin: const EdgeInsets.only(top: 30),
//                   padding: const EdgeInsets.all(20),
//                   width: double.infinity,
//                   color: Colors.grey[600],
//                    alignment: Alignment.center,
//                   child: const Text("Editar Datos"),
//                 ),
//                 Container(
//                   margin: const EdgeInsets.only(top: 1),
//                   padding: const EdgeInsets.all(20),
//                   width: double.infinity,
//                   color: Colors.grey[600],
//                   alignment: Alignment.center,
//                   child: const Text("Habitacion"),
//                 ),
//                 Expanded(child: Container()),
//                 Container(
//                   margin: const EdgeInsets.only(top: 1),
//                   padding: const EdgeInsets.all(20),
//                   width: double.infinity,
//                   color: Colors.grey[800],
//                   alignment: Alignment.center,
//                   child: const Text("Cerrar sesion", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
//                 )
//                 ],
//             ),
//           ),
//         ),
//         appBar: AppBar(
//           title: const Text('Drawer')
//         ),
//         body: const Center(
//           child: Text('Hola mundo!')
//         )
//       )
//     );
//   }
// }