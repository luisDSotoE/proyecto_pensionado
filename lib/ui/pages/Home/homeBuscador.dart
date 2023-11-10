import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:proyecto_pension2/domain/models/habitacion.dart';

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
                padding:
                    const EdgeInsets.only(top: 40.0, left: 30.0, right: 30.0),
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
          color: Colors.white, borderRadius: BorderRadius.circular(12.0)),
      child: TextField(
        onSubmitted: (value) {
          print(value);
        },
        decoration: const InputDecoration(
          prefixIcon: Icon(
            CupertinoIcons.search,
            size: 40.0,
          ),
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

//INTENTO FALLIDO DE HACER FUNCIONAR EL BUSCADOR :'(
class SearchHabitacionDelegate extends SearchDelegate<dynamic> {
  @override
  List<Widget>? buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [
      IconButton(
        onPressed: () {
          query = "";
        },
        icon: const Icon(Icons.close),
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
      onPressed: () {
        close(context, const Text(""));
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return Center();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    return Center();
  }
}
