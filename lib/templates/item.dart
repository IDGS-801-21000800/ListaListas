import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:lista_listas/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ItemLista extends StatefulWidget {
  const ItemLista({super.key, required this.nombreLista});

  final String nombreLista;

  @override
  State<ItemLista> createState() => _ItemLista();
}

class _ItemLista extends State<ItemLista> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> AgregarContenido() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      List<String> lista = prefs.getStringList(widget.nombreLista)!;
      lista.add(_controller.text);
      prefs.setStringList(widget.nombreLista, lista);
    });
  }

  Future<void> CargarContenido() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      if (widget.nombreLista.isEmpty) {
        List<String> lista = prefs.getStringList(widget.nombreLista)!;
        print(lista);
        if (lista.isEmpty) {
          Navigator.pop(context);
          /* Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) => const MyHomePage(
                        title: '1',
                        indice: 0,
                        nombreSublista: "none",
                      )),
              (route) => false); */
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();
    CargarContenido();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("Agregar elemento a ${widget.nombreLista}"),
        Container(
          width: 100,
          height: 30,
          color: Colors.red,
          child: TextField(
            controller: _controller,
            decoration: const InputDecoration(
              hintText: 'Ingresa un término de búsqueda',
            ),
          ),
        ),
        FloatingActionButton(
          onPressed: AgregarContenido,
          child: Icon(Icons.search),
        ),
      ],
    );
  }
}
