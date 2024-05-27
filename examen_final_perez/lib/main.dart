import 'package:examen_final_perez/providers/food_provider.dart';
import 'package:examen_final_perez/providers/login_form_provider.dart';
import 'package:examen_final_perez/screens/home_screen.dart';
import 'package:examen_final_perez/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final bool estaConectado = await loginStatus();
  MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FoodProvider()),
        ChangeNotifierProvider(create: (_) => LoginFormProvider()),
      ],
      child: 
MyApp(estaConectado: estaConectado));
}

Future<bool> loginStatus() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('login') != null;
}

class MyApp extends StatelessWidget {
  final bool estaConectado;

  MyApp({required this.estaConectado});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: estaConectado ? HomeScreen() : LoginScreen(),
    );
  }
}