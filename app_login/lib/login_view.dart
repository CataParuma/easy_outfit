import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:app_login/register_view.dart';
import 'package:flutter/material.dart';

import 'home_view.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});
  static const String _title = 'Easy Outfit';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        appBar: AppBar(title: const Text(_title)),
        body: const MyStatefulWidget(),
      ),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  @override
  Widget build(BuildContext context) {

    TextEditingController _usuarioController = TextEditingController(text:"");
    TextEditingController _passwordController = TextEditingController(text:"");
    return Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: const Text(
                  'Bienvenido a la App',
                  style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.w500,
                      fontSize: 30),
                )),
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: const Text(
                  'Iniciar Sesión',
                  style: TextStyle(fontSize: 20),
                )),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: _usuarioController,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.person_outline),
                  border: OutlineInputBorder(),
                  labelText: 'Usuario',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.lock_outline_rounded),
                  border: OutlineInputBorder(),
                  labelText: 'Contraseña',
                ),
              ),
            ),
            Container(
                height: 50,
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: ElevatedButton(
                  child: const Text('Login'),
                  onPressed: () {
                    
                    if(_passwordController.text==""||_usuarioController.text==""){
                       const snackBar = SnackBar(content: Text('Debes llenar todos los campos!'));
                       ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }else{
                     compareLogin(_usuarioController.text, _passwordController.text);

                     }
                  
                  },
                )),
            Row(
              children: <Widget>[
                const Text('Aún no tienes una cuenta?'),
                TextButton(
                  child: const Text(
                    'Registrate',
                    style: TextStyle(fontSize: 20),
                  ),
                  onPressed: ()=> {
                    Navigator.push(
                      context, 
                      MaterialPageRoute(builder: (context)=>RegisterView())
                      )
                  },
                )
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            ),
          ],
        ));
  }

  Future<void> compareLogin(String nombre, String password) async {
  final Uri url = Uri.parse('http://192.168.1.2/webService/getTest.php');
  final response = await http.get(url); // URL de la API que deseas consultar


  if (response.statusCode == 200) {
    final List<dynamic> jsonData = json.decode(response.body);
    // Convierte la lista de dinámicos en una lista de mapas
   List<Map<String, dynamic>> dataList = jsonData.cast<Map<String, dynamic>>();
   // ignore: unnecessary_null_comparison
   if (dataList != null && dataList.isNotEmpty){

     for(var data in dataList){
      if(data['nombre']==nombre && data['password']==password) {
         Navigator.push(
                      context, 
                      MaterialPageRoute(builder: (context)=>MyHomePage())
                      );
                      return;
        }

      } 
    }

     const snackBar = SnackBar(content: Text('Usuario o contraseña incorrectos!'));
                       ScaffoldMessenger.of(context).showSnackBar(snackBar);
 
  } else {
    throw Exception('Error en la solicitud GET');

  }
}


}

