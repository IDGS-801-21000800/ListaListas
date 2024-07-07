import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';

class AgregarLista extends StatefulWidget {
  const AgregarLista({super.key});

  @override
  State<AgregarLista> createState() => _AgregarLista();
}

class _AgregarLista extends State<AgregarLista> {
  String newLista = "Pruebas 21";
  List<String> listas = [];

  Future<void> agregarListaLista() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      listas = prefs.getStringList("listas")!;
      listas.add(newLista);
      prefs.setStringList("listas", listas);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: <Widget>[
      Text("Form"),
      TextField(
        onChanged: (value) {
          setState(() {
            newLista = value;
          });
        },
      ),
      FloatingActionButton(
          child: const Text("Agregar"),
          onPressed: () {
            setState(() {
              agregarListaLista();
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const MyHomePage(title: "1")),
                  (Route<dynamic> route) => false);
            });
          }),
      FloatingActionButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text("Volver"))
    ]));
  }
}
