import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:uex/app/modules/login/controller/login_controller.dart';

class SignUpPage extends StatefulWidget {
  static const routeName = '/signup';
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final LoginController _loginController = Modular.get();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Text('Sign Up'),
          TextField(
            controller: _emailController,
          ),
          const SizedBox(height: 10),
          TextField(
            controller: _passwordController,
          ),
          ElevatedButton(
            onPressed: ()async{
            }, 
            child: const Text('Sign Up'),
          ),
          TextButton(
            onPressed: (){
              _loginController.signup(
                email: _emailController.text, 
                password: _passwordController.text
              );
            }, 
            child: const Text('Login'))
        ],
      ),
    );
  }
}