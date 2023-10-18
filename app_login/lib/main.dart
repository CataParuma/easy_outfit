import 'package:flutter/material.dart';
import 'login_view.dart';

void main() => runApp(const MiApp());

class MiApp extends StatelessWidget{
  const MiApp({Key? key}):super(key:key);
  
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "Easy Outfit",
      home: LoginView()
    );
  }
}