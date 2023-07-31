import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:lottie/lottie.dart';
import 'package:uex/app/modules/login/controller/login_controller.dart';
import 'package:uex/widgets/dialog/custom_dialogs.dart';
import 'package:uex/widgets/text_field/custom_text_field.dart';

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
      body: Row(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            color: const Color.fromARGB(255, 86, 177, 251),
            child: Lottie.asset('assets/agenda_lottie.json',
            repeat: false, 
            width: MediaQuery.of(context).size.width * 0.5),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Novo Cadastro', style: Theme.of(context).textTheme.displayLarge),
                const SizedBox(height: 20),
                CustomTextField(
                  controller: _emailController,
                  label: const Text('Email'),
                  margin: const EdgeInsets.only(left: 40, right: 40),
                ),
                const SizedBox(height: 10),
                Observer(
                  builder: (context) {
                    return CustomTextField(
                      suffixIcon: IconButton(
                        onPressed: (){
                          _loginController.isSignupPasswordVisible = !_loginController.isSignupPasswordVisible;
                        }, 
                        icon: Icon(!_loginController.isSignupPasswordVisible ? Icons.visibility : Icons.visibility_off)
                      ),
                      obscureText: _loginController.isSignupPasswordVisible,
                      controller: _passwordController,
                      label: const Text('Senha'),
                      margin: const EdgeInsets.only(left: 40, right: 40),
                    );
                  }
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 40,
                  width: MediaQuery.of(context).size.width * 0.3,
                  child: ElevatedButton(
                    onPressed: ()async{
                      try{
                        if(_emailController.text.isEmpty || _passwordController.text.isEmpty){
                          throw 'Preencha todos os campos';
                        }
                        await _loginController.signup(email: _emailController.text, password: _passwordController.text);
                        Modular.to.pop();
                      }
                      catch(e){
                        CustomDialog.errorDialog(
                          context: context, 
                          error: e.toString()
                        );
                      }
                    },
                    child: const Text('Cadastrar'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}