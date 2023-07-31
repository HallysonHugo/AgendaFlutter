import 'package:flutter/material.dart';
import 'package:uex/widgets/text_field/custom_text_field.dart';

class ContactPage extends StatefulWidget {
  static const String routeName = '/cadastro';
  const ContactPage({super.key});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [
          Text('Cadastro de contatos'),
          CustomTextField()
        ],
      ),
    );
  }
}