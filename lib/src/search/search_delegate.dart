import 'package:aplicaciondepeliculas/src/models/pelicula_model.dart';
import 'package:aplicaciondepeliculas/src/providers/peliculas_provider.dart';
import 'package:flutter/material.dart';

class DataSearch extends SearchDelegate {

  String seleccion = '';
  final peliculasProvider = new PeliculasProvider();
  final peliculas = [
    'superman',
    'peicula12',
    'peicula13',
    'peicula14',
    'peicula15',
    'apeicula15',
    'bapeicula15',
  ];

  final peliculasRecientes = ['spiderman', 'cpitan americca'];

  @override
  List<Widget> buildActions(BuildContext context) {
    // son las acciones de nuestro AppBar

    return [
      IconButton(
        autofocus: false,
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // icono a la IZQUIERDA de la barra, la lupita ponele
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress:
            transitionAnimation, //tiempo en el que se va a animar este icono, un numero entre 1  0 -
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  //NO LO USAMOS PORQUE VAMOS A IR A LOS RESULTADOS DE OTRA MANERA
  @override
  Widget buildResults(BuildContext context) {
    // La instruccion que muestra los resultados que vamos a mostrar
    return Center();
  }
  //NO LO USAMOS PORQUE VAMOS A IR A LOS RESULTADOS DE OTRA MANERA


  @override
  Widget buildSuggestions(BuildContext context) {
    // son las sugerencias que aparecen cuando la persona escribe
    if ( query.isEmpty){
      return Container();
    }
    return  FutureBuilder(
      future: peliculasProvider.buscarPelicula(query),
      builder: (BuildContext context, AsyncSnapshot<List<Pelicula>> snapshot) {
        if(snapshot.hasData){
          final peliculas = snapshot.data;
          return ListView(
            children: peliculas.map((pelicula){
              return ListTile(
              leading: FadeInImage(
                image: NetworkImage(pelicula.getPosterImg()),
                placeholder: AssetImage('assets/no-image.jpg'),
                width: 50.0,
                fit: BoxFit.contain,
              ),
                title: Text(pelicula.title),
                subtitle: Text(pelicula.originalTitle),
                onTap: (){
                close(context, null); //primero cierro el buscador
                pelicula.uniqueId = '' ; 
                  Navigator.pushNamed(context, 'detalle', arguments: pelicula);
                },
              );
            }).toList(), //convierte el listado de peliculas en un arreglo/colleccion de widgets
          );
        }else{
        return Center(
          child: CircularProgressIndicator(),
        );

        }
      },

    );
  }
}
