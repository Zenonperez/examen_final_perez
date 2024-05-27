import 'package:card_swiper/card_swiper.dart';
import 'package:examen_final_perez/models/food.dart';
import 'package:flutter/material.dart';



class CardSwiper extends StatelessWidget {
  
  final List<Food> foods;

  const CardSwiper({Key? key, required this.foods}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
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
        height: size.height * 0.5,
        child: Swiper(
          itemCount: foods.length,
          layout: SwiperLayout.STACK,
          itemWidth: size.width * 0.6,
          itemHeight: size.height * 0.4,
          itemBuilder: (BuildContext context, int index) {
            final food = foods[index];
            return GestureDetector(
              onTap: () => Navigator.pushNamed(context, 'details',
                  arguments: food),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: FadeInImage(
                    placeholder: AssetImage('assets/no-image.jpg'),
                    image: NetworkImage(food.Urlimage),
                    fit: BoxFit.cover),
              ),
            );
          },
        ));
  }
}