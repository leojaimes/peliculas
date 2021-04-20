import 'package:flutter/material.dart';
import 'package:peliculas/src/models/pelicula_model.dart';

class MovieHorizontal extends StatelessWidget {
  final List<Pelicula> peliculas;
  final Function siguientePagina;

  MovieHorizontal({@required this.peliculas, @required this.siguientePagina});
  final _pageController = new PageController(
    initialPage: 1,
    viewportFraction: 0.3,
  );

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    _pageController.addListener(() {
      if (_pageController.position.pixels >=
          _pageController.position.maxScrollExtent - 200) {
       
        siguientePagina();
      }
    });
    return Container(
      height: _screenSize.height * 0.25,
      child: PageView.builder(
        pageSnapping: false,
        controller: _pageController,
        scrollDirection: Axis.horizontal,
        itemCount: peliculas.length,
        itemBuilder: (BuildContext context, int i) {
          return _tarjeta(context, peliculas[i], _screenSize);
        },
        //children: _tarjetas(context, _screenSize),
      ),
    );
  }

  Widget _tarjeta(BuildContext context, Pelicula pelicula, Size _screenSize) {
     pelicula.uniqueId = '${pelicula.id}-poster';

    final peliculaContainer = Container(
        //margin: EdgeInsets.only(right: 15.0),
        child: Column(
      children: <Widget>[
        Hero(
            tag: pelicula.uniqueId,
            child: ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: FadeInImage(
              placeholder: AssetImage('assets/img/no-image.jpg'),
              image: NetworkImage(pelicula.getPosterImg()),
              fit: BoxFit.cover,
              height: _screenSize.height * 0.16,
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          pelicula.title,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.caption,
        )
      ],
    ));

    return GestureDetector(
      child: peliculaContainer,
      onTap: () {
        
        Navigator.pushNamed(context, 'detalle', arguments: pelicula);
      },
    );
  }

  List<Widget> _tarjetas(BuildContext context, Size _screenSize) {
    return peliculas.map((pelicula) {
      return Container(
          //margin: EdgeInsets.only(right: 15.0),
          child: Column(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: FadeInImage(
              placeholder: AssetImage('assets/img/no-image.jpg'),
              image: NetworkImage(pelicula.getPosterImg()),
              fit: BoxFit.cover,
              height: _screenSize.height * 0.16,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            pelicula.title,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.caption,
          )
        ],
      ));
    }).toList();
  }
}
