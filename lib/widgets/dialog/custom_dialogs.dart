import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class CustomDialog{

  static errorDialog({required BuildContext context, required String error, String title = 'Erro'}){
    return showDialog(
      context: context, 
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(error),
        actions: [
          TextButton(
            onPressed: (){
              Modular.to.pop();
            }, 
            child: const Text('Ok')
          )
        ],
      )
    );
  }
}