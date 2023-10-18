import 'package:flutter/material.dart';


 class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;

  final List<Widget> _tabs = [
    HomeTab(),
    UserTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Easy Outfit'),
      ),
      body: _tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Usuario',
          ),
        ],
      ),
    );
  }
}

class HomeTab extends StatefulWidget {
  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  int _currentImageIndex = 0;
  List<String> imagePaths = [
    'assets/images/1.png',
    'assets/images/2.png',
    'assets/images/3.png',
  ];

  void _changeImage(int newIndex) {
    setState(() {
      _currentImageIndex = newIndex;
    });
  }

  void _onPonermePressed() {
    // Accion del boton
  }

  void _onDescartarPressed() {
    // Accion del boton
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  if (_currentImageIndex > 0) {
                    _changeImage(_currentImageIndex - 1);
                  }
                },
              ),
              Image.asset(imagePaths[_currentImageIndex]),
              IconButton(
                icon: Icon(Icons.arrow_forward),
                onPressed: () {
                  if (_currentImageIndex < imagePaths.length - 1) {
                    _changeImage(_currentImageIndex + 1);
                  }
                },
              ),
            ],
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                onPressed: _onPonermePressed,
                child: Text('Ponerme'),
              ),
              ElevatedButton(
                onPressed: _onDescartarPressed,
                child: Text('Descartar'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class UserTab extends StatelessWidget {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  void _submitForm() {
    final name = nameController.text;
    final email = emailController.text;
    print('Nombre: $name');
    print('Correo electrónico: $email');
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Completa el formulario de usuario:',
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(height: 16),
          TextField(
            controller: nameController,
            decoration: InputDecoration(labelText: 'Nombre'),
          ),
          SizedBox(height: 16),
          TextField(
            controller: emailController,
            decoration: InputDecoration(labelText: 'Correo electrónico'),
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: _submitForm,
            child: Text('Enviar'),
          ),
        ],
      ),
    );
  }
}
