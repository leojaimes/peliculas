import 'package:flutter/material.dart';

class DataSearch extends SearchDelegate {
  String seleccion = ''; //se setea para guardar el elemento seleccionado
  final peliculas = [
    'Acuaman 1',
    'Spiderman 4',
    'Batman 3',
    'Guild Wars 4',
    'La chinagada 5',
    'Superman 6',
    'Juanito 7',
  ];
  final peliculasRecientes = [
    'Chama 1',
    'Hola 4',
    'Shurnicova 3',
    'se abrio 4',
    'zapato 5',
    'Superman 6',
    'Cielo Azul 7',
  ];
  @override
  List<Widget> buildActions(BuildContext context) {
    //Son las acciones de nuestro appBar (Ejemplo icon para limpiar el texto)

    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            print('Action Icon PRessed');
            query = '';
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    //Icono a la izquierda del appbar
    return IconButton(
      icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
      onPressed: () {
        print('leading Icon PRessed');
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    //Builder que crea los resultados que vamos a mostrar
    return Center(
      child: Container(
        height: 100,
        width: 100,
        color: Colors.blueAccent,
        child: Text(seleccion),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    //Son las sugerencias que aparecen cuando la persona escribe

    final listaSugerida = query.isEmpty
        ? peliculasRecientes
        : peliculas
            .where((p) => p.toLowerCase().startsWith(query.toLowerCase()))
            .toList();

    return ListView.builder(
        itemCount: listaSugerida.length,
        itemBuilder: (BuildContext context, index) {
          return ListTile(
            leading: Icon(Icons.movie),
            title: Text(listaSugerida[index]),
            onTap: () {
              seleccion = listaSugerida[index];
              showResults(context);
            },
          );
        });
  }
}
