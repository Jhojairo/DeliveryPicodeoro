import 'package:flutter/material.dart';

// aqui esta la paerte logica metodo de navegacion hacia pagina registrar y otros
class LoginController {
  BuildContext context;
  TextEditingController emailcontroller = new TextEditingController();
  TextEditingController passwordcontroller = new TextEditingController();

  Future init(BuildContext context) {
    this.context = context;
  }

  void goToRegisterPage() {
    Navigator.pushNamed(context, "register");
  }

  void loguin() {
    String email = emailcontroller.text
        .trim(); // trim elimina espacios en blanco para que email u pass word sean validos

    String password = passwordcontroller.text.trim();
    print("email $email");
    print("pass $password");
  }
}
