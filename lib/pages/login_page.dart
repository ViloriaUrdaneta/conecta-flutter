import 'package:conecta/components/my_button.dart';
import 'package:conecta/components/my_textfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../services/auth_service.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inicio de sesión'),
      ),
      body: const Center(
        child: LoginForm(),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String loginMessage = '';

  void goToRegister(){
    Navigator.pushReplacementNamed(context, '/signup');
  }

  final AuthService authService = AuthService();


  Future<void> login() async {
    final username = usernameController.text;
    final password = passwordController.text;
    
    try {
      final res = await authService.login(username, password);
      Provider.of<AuthProvider>(context, listen: false).setAuthToken(res['token']);
      Provider.of<AuthProvider>(context, listen: false).setLastLogin(res['last_login']);
      Navigator.pushReplacementNamed(context, '/dashboard');
    } catch (error) {
      setState(() {
        loginMessage = 'Error al iniciar sesión';
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        // Agrega campos de entrada para el nombre de usuario y la contraseña
        MyTextField(
          controller: usernameController, 
          hintText: 'Nombre de usuario', 
          obscureText: false
        ),
        const SizedBox(height: 15),
        MyTextField(
          controller: passwordController,
          hintText: 'Contraseña', 
          obscureText: true
        ),
        const SizedBox(height: 35),
        MyButton(
          onTap: login,
          buttonText: 'Iniciar sesión',
        ),
        const SizedBox(height: 15),
        MyButton(
          onTap: goToRegister,
          buttonText: 'Registrarse',
        ),
        Text(
          loginMessage,
          style: TextStyle(
            color: loginMessage.startsWith('Error') ? Colors.red : Colors.green,
          ),
        ),
      ],
    );
  }
}
