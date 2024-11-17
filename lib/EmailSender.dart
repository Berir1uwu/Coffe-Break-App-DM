import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';

class EmailSender {
  static Future<void> sendReminderEmail() async {
    final Email email = Email(
      body: _buildEmailBody(),
      subject: 'Recuerda seguir explorando nuevas recetas',
      recipients: ['example@example.com'], // Puedes cambiar esto por una lista de correos
      isHTML: false,
    );

    try {
      await FlutterEmailSender.send(email);
      print('Correo enviado');
    } catch (error) {
      print('Error al enviar el correo: $error');
    }
  }

  static String _buildEmailBody() {
    return '''
    ¡Hola!

    No dejes de explorar el delicioso mundo del café, miles de recetas nuevas te esperan.

    ¡Espero que disfrutes preparándolas! Vuelve pronto. 
    ''';
  }
}
