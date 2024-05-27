
import 'package:examen_final_perez/providers/food_provider.dart';
import 'package:examen_final_perez/screens/login_screen.dart';
import 'package:examen_final_perez/widgets/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  



  @override
  Widget build(BuildContext context) {
  
  final foodProvider = Provider.of<FoodProvider>(context);
  Future<void> logout() async {
  final credenciales = await SharedPreferences.getInstance();
  await credenciales.remove('login');
  Navigator.pushReplacement(context, MaterialPageRoute(
                          builder: (context) => LoginScreen()));
}


    return Scaffold(
      backgroundColor: Colors.white70,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.indigo,
        title: Row(children: [
          Text(
            'Comida',
            style: TextStyle(color: Colors.white),
          ),
          Container(width: 120),
          MaterialButton(
              color: Colors.pink,
              child: Text(
                'Desconectarse',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () async {
                await logout();
              }),
        ]),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              CardSwiper(foods: foodProvider.foods),
              
            ],
          ),
        ),
      ),
      
    );
  }
}