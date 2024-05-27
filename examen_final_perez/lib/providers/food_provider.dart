import 'package:examen_final_perez/models/food.dart';
import 'package:flutter/material.dart';

import 'dart:convert' as convert;
import 'package:http/http.dart' as http;



class FoodProvider extends ChangeNotifier {

  String _baseUrl = 'https://examen-practic-sim-default-rtdb.europe-west1.firebasedatabase.app/plats.json';
  


  List<Food> foods = [];
 

  FoodProvider() {

    this.getOnDisplayFood();
  }
  getOnDisplayFood() async {
    print('getOnDisplayFood');
    var url = Uri.https(_baseUrl);

    final result = await http.get(url);
    if (result.statusCode == 200) {
      final List<dynamic> jsonResponse = convert.jsonDecode(result.body);
      foods.clear();

      for (final foodJson in jsonResponse) {
        final food = Food.fromJson(foodJson);
        foods.add(food);
      }

      notifyListeners();
    } else {
      print('Error en la peticion con el codigo: ${result.statusCode}');
    }
  }
}
