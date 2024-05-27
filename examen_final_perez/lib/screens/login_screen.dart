
import 'package:examen_final_perez/providers/login_form_provider.dart';
import 'package:examen_final_perez/screens/home_screen.dart';
import 'package:examen_final_perez/widgets/auth_background.dart';
import 'package:examen_final_perez/widgets/card_container.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../ui/input_decorations.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //Scaffold de login
    return Scaffold(
      body: AuthBackground(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 250),
              CardContainer(
                child: Column(
                  children: [
                    SizedBox(height: 10),
                    Text('Login', style: Theme.of(context).textTheme.headline4),
                    SizedBox(height: 30),
                    ChangeNotifierProvider(
                      create: (_) => LoginFormProvider(),
                      child: _LoginForm(),
                    ),
                  ],
                ),
              ),
              //Texto boton de registrar a un usuario.
            ],
          ),
        ),
      ),
    );
  }
}

class _LoginForm extends StatelessWidget {
  String _error = '';

  Future<void> sesionGuardada(String token) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('login', token);
}

  @override
  Widget build(BuildContext context) {
    final loginForm = Provider.of<LoginFormProvider>(context);

    //El formulario utiliza una key correspondiente, cada formulario tendra la suya para poder crear o iniciar sesion la cuenta de un usuario
    return Container(
      child: Form(
        key: loginForm.formKey,
        //TODO: Mantenir la referencia a la Key
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: [
            TextFormField(
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecorations.authInputDecoration(
                labelText: 'Usari',
                prefixIcon: Icons.account_circle_rounded,
              ),
              onChanged: (value) => loginForm.email = value,
              //Valida que el correo se tenga el formarto de un correo 'letra@letra.letra
              //Si se trara de un correo dejara ponerlo y el usuario debera de poner un correo para que le deje realizar el formulario
              validator: (value) { 
                return (value != null) 
                  ? null
                  : 'El usuario no puede estar vacio';
              },
            ),
            SizedBox(height: 30),
            TextFormField(
              autocorrect: false,
              obscureText: true,
              keyboardType: TextInputType.visiblePassword,
              decoration: InputDecorations.authInputDecoration(
                labelText: 'Contraseña',
                prefixIcon: Icons.lock_outline,
              ),
              onChanged: (value) => loginForm.password = value,
              //Valida que la contraseña contega almenos o más de 6 caracteres de lo contrario no dejara inciar sesión.
              validator: (value) {
                return (value != null && value.length >= 6)
                    ? null
                    : 'La contrasenya ha de ser de 6 caràcters';
              },
            ),
            SizedBox(height: 30),
            MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              disabledColor: Colors.grey,
              elevation: 0,
              color: Colors.deepPurple,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                //Boton de inicio de sesion que cambiara a esperi si se esta cargando la sesion de un usuario.
                child: Text(
                  loginForm.isLoading ? 'Esperi' : 'Iniciar sesion',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              //Aqui se podrucira el inicio de sesion.
              onPressed: loginForm.isLoading
                  //Si esta cargando no dejara pulsar el boton.
                  ? null
                  //De lo contrario dejara pulsarlo y empezaria el inicio de sesion.
                  : () async {
                      // Deshabilitamos el tecladp
                      FocusScope.of(context).unfocus();
                      //Si el formulario es valido
                      if (loginForm.isValidForm()) {
                        //Primero estara cargando
                        loginForm.isLoading = true;
                        //Luego intentara inciar sesion y de conseguirlo cargara a la pantalla home.
                        
                        await sesionGuardada('login');
                        Navigator.pushReplacement(context, MaterialPageRoute(
                          builder: (context) => HomeScreen()));
                        
                      }
                      //Dejara de cargar.
                      loginForm.isLoading = false;
                    },
            ),
          ],
        ),
      ),
    );
  }
}


