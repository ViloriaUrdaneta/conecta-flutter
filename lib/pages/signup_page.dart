import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../components/my_button.dart';
import '../components/my_textfield.dart';
import '../providers/auth_provider.dart';
import '../services/auth_service.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registro de usuario'),
      ),
      body: const Center(
        child: RegisterForm(),
      ),
    );
  }
}

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String loginMessage = '';

  void goToLogin(){
    Navigator.pushReplacementNamed(context, '/login');
  }

  final AuthService authService = AuthService();


  Future<void> signup() async {
    final username = usernameController.text;
    final password = passwordController.text;
    
    try {
      final token = await authService.signup(username, password);
      Provider.of<AuthProvider>(context, listen: false).setAuthToken(token);
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
          onTap: signup,
          buttonText: 'Regitrarse',
        ),
        const SizedBox(height: 15),
        MyButton(
          onTap: goToLogin,
          buttonText: 'Ir a inicio de sesión',
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
