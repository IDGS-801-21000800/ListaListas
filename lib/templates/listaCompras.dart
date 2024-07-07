import 'package:flutter/material.dart';
import 'package:lista_listas/main.dart';
import 'package:lista_listas/templates/agregarLista.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ListaCompras extends StatefulWidget {
  const ListaCompras({super.key, required this.title});

  final String title;

  @override
  State<ListaCompras> createState() => _ListaCompras();
}

class _ListaCompras extends State<ListaCompras> {
  List<String>? listas = ["Primero", "Segundo"];
  List<String>? lista = [];

  Future<void> cargarLista() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      //prefs.setStringList("none", ["value", "color", "name", "prop"]);

      listas = prefs.getStringList("listas") ?? listas;
    });
  }

  @override
  void initState() {
    super.initState();
    cargarLista();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(children: [
      Row(
        children: [
          const Text("Listas"),
          FloatingActionButton(
              child: const Text("text"),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AgregarLista()));
              })
        ],
      ),
      Expanded(
        child: ListView(
          children: listas!
              .asMap()
              .entries
              .map((e) => ListTile(
                    leading: const Icon(Icons.map),
                    title: Text(e.value),
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MyHomePage(
                                  title: "1",
                                  nombreSublista: e.value,
                                  indice: 2)));
                    },
                  ))
              .toList(),
        ),
      ),
    ]));
  }
}
