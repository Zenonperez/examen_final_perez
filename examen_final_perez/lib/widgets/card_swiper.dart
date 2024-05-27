import 'package:card_swiper/card_swiper.dart';
import 'package:examen_final_perez/models/food.dart';
import 'package:flutter/material.dart';


/**Clase que se encarga de gestionar el funcionamiento del cardSwiper, esta recibira una lista de gatos desde del
home_screen que esta viene del provider, aqui se encotraran todas las razas de gatos de la API
*/


class CardSwiper extends StatelessWidget {
  
  final List<Food> foods;

  const CardSwiper({Key? key, required this.foods}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    //Para que sea visualmente más estetico mientras estan cargando los gatos, hacemos que haga esto mientras la lista esta vacia
    if(this.foods.length == 0){
      return Container(width: double.infinity,
      height: size.height*0.5,
      child: Center(
        child: CircularProgressIndicator(),
        ),
        );
    }
    return Container(
        width: double.infinity,
        // Aquest multiplicador estableix el tant per cent de pantalla ocupada 50%
        height: size.height * 0.5,
        // color: Colors.red,
        child: Swiper(
          itemCount: foods.length,
          layout: SwiperLayout.STACK,
          itemWidth: size.width * 0.6,
          itemHeight: size.height * 0.4,
          //Por cada gato se creara una card_swipe que al pulsar nos llevara a un objeto gato con su informacion
          itemBuilder: (BuildContext context, int index) {
            final food = foods[index];
            return GestureDetector(
              onTap: () => Navigator.pushNamed(context, 'details',
                  arguments: food),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: FadeInImage(
                    placeholder: AssetImage('assets/no-image.jpg'),
                    image: NetworkImage(food.picture!),
                    fit: BoxFit.cover),
              ),
            );
          },
        ));
  }
}