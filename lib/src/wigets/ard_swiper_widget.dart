import 'package:aplicaciondepeliculas/src/models/pelicula_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class CardSwiper extends StatelessWidget {
  final List<Pelicula> peliculas;

  CardSwiper({@required this.peliculas});

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.only(top: 10.0),
      child: Swiper(
        containerWidth: _screenSize.width * 0.75,
        itemHeight: _screenSize.height * 0.50,
        layout: SwiperLayout.STACK,
        itemWidth: 200.0,
        itemBuilder: (BuildContext context, int index) {

          peliculas[index].uniqueId = '${peliculas[index].id}-tarjeta';  //este es el que le voy a mandar al Hero

          return Hero(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: GestureDetector(
                onTap: (){
                  Navigator.pushNamed(context, 'detalle', arguments: peliculas[index]);
                },
                child: FadeInImage(
                  placeholder: AssetImage('assets/no-image.jpg'),
                  fit: BoxFit.cover,
                  image: NetworkImage( peliculas[index].getPosterImg()),

                ),
              )
            ), tag: peliculas[index].uniqueId,
          );
        },
        itemCount: peliculas.length,
        //pagination: new SwiperPagination(),
        //control: new SwiperControl(),
      ),
    );
  }
}
