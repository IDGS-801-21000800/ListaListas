import 'package:flutter/material.dart';
import 'package:lista_listas/templates/listaCompras.dart';
import 'package:lista_listas/templates/menuOpciones.dart';
import 'package:lista_listas/templates/sublistas.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage(
      {super.key,
      required this.title,
      this.indice = 0,
      this.nombreSublista = "none"});

  final String title;
  final int indice;
  final String nombreSublista;

  @override
  _MyHomePageState createState() =>
      _MyHomePageState(this.indice, this.nombreSublista);
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;
  _MyHomePageState(int indiceSublista, String nombreSublista);
  List<Widget> _screens = [];


  Future<void> todo() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setStringList("Primero", ["color", "color", "value", "prop"]);
      prefs.setStringList("Segundo", ["asdfg", "qwert", "12345", "porp"]);

      _currentIndex = widget.indice;
      
    });
  }

  @override
  void initState() {
    super.initState();
    todo();
    setState(() {
      _screens = [
        const ListaCompras(
          title: '1',
        ),
        const opciones(),
        SubListas(nombreLista: widget.nombreSublista,)
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mi App de Listas'),
      ),
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Crear Lista',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Todas las Listas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Ajustes',
          ),
        ],
      ),
    );
  }
}
