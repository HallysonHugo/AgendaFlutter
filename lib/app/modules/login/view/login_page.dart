import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:uex/app/modules/login/controller/login_controller.dart';
import 'package:uex/app/modules/login/login_module.dart';
import 'package:uex/app/modules/login/view/sign_up_page.dart';

class LoginPage extends StatefulWidget {
  static const String routeName = '/';
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final LoginController _loginController = Modular.get();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Text('Login'),

          TextField(
            controller: _emailController,
          ),
          const SizedBox(height: 10),
          TextField(
            controller: _passwordController,
          ),

          ElevatedButton(
            onPressed: ()async{
              try{
                if(_emailController.text.isEmpty || _passwordController.text.isEmpty){
                  return;
                }
                await _loginController.login(
                  email: _emailController.text,
                  password: _passwordController.text,
                );
              }
              catch(e){
                print(e.toString());
              }
            },
            child: const Text('Login'),
          ),

          TextButton(
            onPressed: (){
              Modular.to.pushNamed(LoginModule.routeName + SignUpPage.routeName);
            }, 
            child: const Text('Sign Up'))
        ],
      ),
    );
  }
}