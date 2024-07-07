import 'package:flutter/material.dart';
import 'package:lista_listas/main.dart';
import 'package:lista_listas/templates/item.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SubListas extends StatefulWidget {
  const SubListas({super.key, required this.nombreLista});

  final String nombreLista;

  @override
  _SubListas createState() => _SubListas(nombreLista);
}

class _SubListas extends State<SubListas> {
  _SubListas(String nombreLista);
  List<String> contenidos = [];

  Future<void> cargarContenidos() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      if (widget.nombreLista == "none") {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) => const MyHomePage(
                      title: '1',
                      indice: 0,
                      nombreSublista: "none",
                    )),
            (route) => false);
      }
      widget.nombreLista.isNotEmpty
          ? contenidos = prefs.getStringList(widget.nombreLista)!
          : Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) => const MyHomePage(title: '1')),
              (Route<dynamic> route) => false);
    });
  }

  @override
  void initState() {
    super.initState();
    cargarContenidos();
  }

  @override
  Widget build(BuildContext context) {
    return Row(children: <Widget>[
      Text(widget.nombreLista),
      FloatingActionButton(
          child: Text("Agregar contenido"),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        ItemLista(nombreLista: widget.nombreLista)));
          }),
      Column(
        children: contenidos.map((e) => Text(e)).toList(),
      )
    ]);
  }
}
