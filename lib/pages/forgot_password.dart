// ignore_for_file: use_build_context_synchronously

import 'package:calendario/components/button.dart';
import 'package:calendario/components/textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _emailController = TextEditingController();
  final FocusNode emailFocus = FocusNode();
  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future passwordReset() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: _emailController.text.trim());
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text('O link foi enviado para o email digitado'),
          );
        },
      );
    } on FirebaseAuthException {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text('Esse email não existe!'),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF202C39),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Digite seu email e iremos te enviar um link para restaurar sua senha',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 10),
          MyTextField(
              preffixIcon: Icon(Icons.person),
              suffixIcon: Icon(
                Icons.email,
              ),
              controller: _emailController,
              hintText: 'Email',
              obscureText: false),
          SizedBox(height: 10),
          SaveButton(
              onTap: passwordReset,
              text: 'Resetar senha',
              buttonColor: Color(0xFF202C39))
        ],
      ),
    );
  }
}
