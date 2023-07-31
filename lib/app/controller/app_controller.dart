import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:uex/app/modules/login/model/login_model.dart';
import 'package:uex/app/repository/app_repository.dart';
import 'package:uex/widgets/dialog/custom_dialogs.dart';
import 'package:uex/widgets/text_field/custom_text_field.dart';

part 'app_controller.g.dart';

@Injectable()
class AppController = AppControllerBase with _$AppController;

abstract class AppControllerBase with Store{
  final AppRepository repository;
  AppControllerBase({required this.repository});

  LoginModel? loggedUser;

  bool get isLogged => loggedUser != null;


  Future<void> deleteUser({required BuildContext context})async{
    final TextEditingController controller = TextEditingController();
    await showDialog(context: context, builder: (context){
      return Dialog(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.4,
          margin: const EdgeInsets.all(20),
          padding: const EdgeInsets.all(5),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Atenção', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              const Text('Para deletar sua conta você precisa informar a senha', style: TextStyle(fontSize: 16)),
              const SizedBox(height: 10),
              CustomTextField(
                controller: controller,
                obscureText: true,
                label: const Text('Senha'),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: (){
                      Modular.to.pop();
                    }, 
                    child: const Text('Cancelar')
                  ),
                  TextButton(
                    onPressed: ()async{
                      try{
                        if(controller.text != loggedUser?.password){
                          throw 'Senha incorreta';
                        }
                          
                          await repository.deleteUser(loginModel: loggedUser!).then((value) async{
                            await CustomDialog.sucessDialog(context: context, message: 'Usuario excluido com sucesso');
                          });
                          loggedUser = null;
                          Modular.to.navigate('/login');
                      }
                      catch(e){
                        CustomDialog.errorDialog(context: context, error: e.toString());
                      }
                    }, 
                    child: const Text('Deletar')
                  ),
                ],
              )
            ],
          ),
        ),
      );
    });
  }
}