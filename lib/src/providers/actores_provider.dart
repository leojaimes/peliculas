import 'dart:async';

import 'package:peliculas/src/models/actores_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ActoresProvider {
  String _apikey = 'ec790c78f61b73fbbe086c1a6987a1f5';
  String _url = 'api.themoviedb.org';
  String _language = 'es-ES';
 

 

 
  Future<List<Actor>> _procesarRespuesta(Uri url) async {
    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);
 
    final actores = Cast.fromJsonList(decodedData['cast']);
    
    return actores.items;
  }

  Future<List<Actor>> getActores(String idPelicula) async {
    final url = Uri.https(_url, '3/movie/$idPelicula/credits',
        {'api_key': _apikey, 'language': _language});

    return await _procesarRespuesta(url);
  } //end getEncines

  
} //end class

/**
 * 
 * https://api.themoviedb.org/3/movie/583083/credits?api_key=ec790c78f61b73fbbe086c1a6987a1f5
 * 
 * API (v3 auth)
 * ec790c78f61b73fbbe086c1a6987a1f5
 * 
 * 
 * Ejemplo de solicitud de API
 * https://api.themoviedb.org/3/movie/550?api_key=ec790c78f61b73fbbe086c1a6987a1f5
 * 
 * Token de acceso de lectura a la API (v4 auth)
eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJlYzc5MGM3OGY2MWI3M2ZiYmUwODZjMWE2OTg3YTFmNSIsInN1YiI6IjVmMWY5MTMxYjRhNTQzMDAzNzMyMmMyZiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.BWlq22I8_nOy-5nwZO7qvn0OphiTN-orrgkN7C55G_4
 * 
 * 
 * https://api.themoviedb.org/3/movie/now_playing?api_key=ec790c78f61b73fbbe086c1a6987a1f5&language=es-ES&page=1
 * 
 * https://image.tmdb.org/t/p/w500/  -->{b5bVzqrUZscKxNvXPBtrMHVKLU0.jpg}
 * 
 */
