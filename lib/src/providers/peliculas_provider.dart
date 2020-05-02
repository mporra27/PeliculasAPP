import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:aplicaciondepeliculas/src/models/pelicula_model.dart';

class PeliculasProvider {
  String _apikey = 'b3710126990432ba9c2e6b2fbbffd1d1';
  String _url = 'api.themoviedb.org';
  String _languaje = 'es-ES';

  Future<List<Pelicula>> getEnCines() async {
    final url = Uri.https(_url, '3/movie/now_playing', {
      'api_key': _apikey,
      'language': _languaje,
    });

    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);
    final peliculas = new Peliculas.fromJsonList(decodedData['results']);
    return peliculas.items;
  }

  Future<List<Pelicula>> getPopulares() async {
    final url = Uri.https(_url, '3/movie/popular', {
      'api_key': _apikey,
      'language': _languaje,
    });

    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);
    final peliculas = new Peliculas.fromJsonList(decodedData['results']);
    return peliculas.items;

  }
}
