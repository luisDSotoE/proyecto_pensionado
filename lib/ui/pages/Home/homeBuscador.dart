import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Buscador extends StatelessWidget {
  const Buscador({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
        shrinkWrap: true,
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(35.0),
                topRight: Radius.circular(35.0),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: 40.0,
                    left: 30.0,
                    right: 30.0
                  ),
                  child: BarraSearch(),
                )
                
              ],
            ),
          )
        ],
      );
  }




  // ignore: non_constant_identifier_names
  BarraSearch() {
    return Container(
    alignment: Alignment.center,
    padding: const EdgeInsets.only(
      left: 8.0,
      right: 8.0,
    ),
    height: 50.0,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0)
    ),
    child: const TextField(
      decoration: InputDecoration(
        prefixIcon: Icon(CupertinoIcons.search, size: 40.0,),
        border: InputBorder.none,
        hintStyle: TextStyle(
          color: Colors.black26,
          fontSize: 15.0,
        ),
        hintText: "Buscar",
      ),
    ),
  );
  }
}