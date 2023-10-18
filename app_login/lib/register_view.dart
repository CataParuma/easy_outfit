import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'login_view.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

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
  final TextEditingController nombreController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> registrarUsuario(
      String nombre, String email, String password) async {
    final Uri url = Uri.parse('http://192.168.1.2/webService/getTest.php');
    final response = await http.get(url); // URL de la API que deseas consultar

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      // Convierte la lista de dinámicos en una lista de mapas
      List<Map<String, dynamic>> dataList =
          jsonData.cast<Map<String, dynamic>>();
      // ignore: unnecessary_null_comparison
      if (dataList != null && dataList.isNotEmpty) {
        for (var data in dataList) {
          if (data['nombre'] == nombre) {
            const snackBar =
                SnackBar(content: Text('Nombre de usuario no disponible!'));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
            return;
          } else if (data['email'] == email) {
            const snackBar =
                SnackBar(content: Text('Ese email ya ha sido registrado!'));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
            return;
          }
        }

        final url2 = Uri.parse(
            'http://192.168.1.2/webService/ejemploPost.php'); // Reemplaza con la URL correcta

        final response2 = await http.post(
          url2,
          body: {
            'nombre': nombre,
            'email': email,
            'password': password,
          },
        );

        if (response2.statusCode == 200) {
          // La solicitud se realizó con éxito
          final responseData = response2.body;
          const snackBar =
                SnackBar(content: Text('Usuario correctamente registrado!'));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
            Navigator.push(
                      context, 
                      MaterialPageRoute(builder: (context)=>LoginView())
                      );
            return; // Puedes procesar la respuesta aquí
        } else {
          // Hubo un error en la solicitud
          print('Error: ${response2.statusCode}');
          print('Mensaje de error: ${response2.body}');
        }
      }
    } else {
      throw Exception('Error en la solicitud GET');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: const Text(
                  'Registrar usuario',
                  style: TextStyle(fontSize: 20),
                )),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: nombreController,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.person_2_outlined),
                  border: OutlineInputBorder(),
                  labelText: 'Nombre',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.email_outlined),
                  border: OutlineInputBorder(),
                  labelText: 'Email',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: TextField(
                controller: passwordController,
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
                  child: const Text('Registrarse'),
                  onPressed: () {
                    if (nombreController.text != "" &&
                        emailController.text != "" &&
                        passwordController.text != "") {
                      registrarUsuario(nombreController.text,
                          emailController.text, passwordController.text);
                    } else {
                      const snackBar = SnackBar(
                          content: Text('Debes llenar todos los campos!'));
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  },
                ))
          ],
        ));
  }
}
