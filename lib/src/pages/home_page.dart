import 'package:flutter/material.dart';
import 'package:peliculas/src/providers/peliculas_provider.dart';
import 'package:peliculas/src/search/search_delegate.dart';
import 'package:peliculas/src/widgets/card_swiper_widget.dart';
import 'package:peliculas/src/widgets/movie_horizontal.dart';

class HomePage extends StatelessWidget {
  final peliculasProvider = new PeliculasProvider();

  @override
  Widget build(BuildContext context) {
    peliculasProvider.getPopulares();
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text('Peliculas en cine'),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                showSearch(
                    context: context,
                    delegate: new DataSearch(),
                    query: 'Hola');
              }),
        ],
      ),
      body: Container(
          child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            SizedBox(height: 10,),
            _swiperTarjetas(), 
              SizedBox(height: 40,),
            _footer(context),
      

          ],
        ),
      )),
    );
  }

  Widget _swiperTarjetas() {
    return FutureBuilder(
      future: peliculasProvider.getEnCines(),
      //initialData: new List<Pelicula>(),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        if (snapshot.hasData) {
          return CardSwiper(peliculas: snapshot.data);
        } else {
          return Container(
              height: 400, child: Center(child: CircularProgressIndicator()));
        }
      },
    );
  }

  Widget _footer(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
              padding: EdgeInsets.only(left: 10),
              margin: EdgeInsets.only(bottom: 5),
              child: Text(
                'Populares',
                style: Theme.of(context).textTheme.subtitle1,
              )),
          SizedBox(
            height: 2.0,
          ),
          _infiniteScroll()
        ],
      ),
    );
  }

  Widget _infiniteScroll() {
    return StreamBuilder(
      stream: peliculasProvider.popularesStream,
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        if (snapshot.hasData) {
          final data = snapshot.data;
          return MovieHorizontal(
              peliculas: data, siguientePagina: peliculasProvider.getPopulares);
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
