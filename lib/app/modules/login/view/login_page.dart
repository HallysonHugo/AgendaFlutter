import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:lottie/lottie.dart';
import 'package:uex/app/controller/app_controller.dart';
import 'package:uex/app/modules/contact/contact_module.dart';
import 'package:uex/app/modules/contact/view/list_contacts_page.dart';
import 'package:uex/app/modules/login/controller/login_controller.dart';
import 'package:uex/app/modules/login/login_module.dart';
import 'package:uex/app/modules/login/view/sign_up_page.dart';
import 'package:uex/widgets/dialog/custom_dialogs.dart';
import 'package:uex/widgets/text_field/custom_text_field.dart';

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
  final AppController _appController = Modular.get();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            color: const Color.fromARGB(255, 86, 177, 251),
            child: Lottie.asset('assets/login_animation.json',
            repeat: false, 
            width: MediaQuery.of(context).size.width * 0.5),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Login', style: Theme.of(context).textTheme.displayLarge),
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
                          _loginController.isLoginPasswordVisible = !_loginController.isLoginPasswordVisible;
                        }, 
                        icon: Icon(!_loginController.isLoginPasswordVisible ? Icons.visibility : Icons.visibility_off)
                      ),
                      obscureText: _loginController.isLoginPasswordVisible,
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
                        _appController.loggedUser = await _loginController.login(
                          email: _emailController.text,
                          password: _passwordController.text,
                        );
                        Modular.to.pushReplacementNamed(ContactModule.routeName + ListContactsPage.routeName);
                      }
                      catch(e){
                        CustomDialog.errorDialog(context: context, error: e.toString());
                      }
                    },
                    child: const Text('Login'),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 40,
                  width: MediaQuery.of(context).size.width * 0.3,
                  child: TextButton(
                    onPressed: (){
                      Modular.to.pushNamed(LoginModule.routeName + SignUpPage.routeName);
                    }, 
                    child: const Text('Cadastre-se')),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}