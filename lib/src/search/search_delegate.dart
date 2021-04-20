import 'package:flutter/material.dart';
import 'package:peliculas/src/models/pelicula_model.dart';
import 'package:peliculas/src/providers/peliculas_provider.dart';

class DataSearch extends SearchDelegate {
  String seleccion = ''; //se setea para guardar el elemento seleccionado
  final peliculasProvider = PeliculasProvider();
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

    if (query.isEmpty) {
      return Container();
    }

    return FutureBuilder(
      future: peliculasProvider.buscarPelicula(query),
      //initialData: InitialData,
      builder: (BuildContext context, AsyncSnapshot<List<Pelicula>> snapshot) {
        if (snapshot.hasData) {
          final peliculas = snapshot.data;
          return ListView(
              children: peliculas.map((pelicula) {
            return ListTile(
              leading: FadeInImage(
                  placeholder: AssetImage('assets/img/no-image.jpg'),
                  image: NetworkImage(pelicula.getPosterImg()),
                  width: 50,
                  fit: BoxFit.contain),
              title: Text(pelicula.title),
              subtitle: Text(pelicula.originalTitle),
              onTap: () {
                close(context, null);
                pelicula.uniqueId = '${pelicula.id}_search';
                Navigator.pushNamed(context, 'detalle', arguments: pelicula);
              },
            );
          }).toList());
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
