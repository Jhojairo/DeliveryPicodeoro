import 'package:flutter/material.dart';

class RegisterController {
  BuildContext context;
  TextEditingController emailController = new TextEditingController();
  TextEditingController nameController = new TextEditingController();
  TextEditingController lastnameController = new TextEditingController();
  TextEditingController foneController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController confirmpasswordController = new TextEditingController();

  Future init(BuildContext context) {
    this.context = context;
  }

  void register() {
    String email = emailController.text.trim();
    String name = nameController.text.trim();
    String lastname = lastnameController.text.trim();
    String fone = foneController.text.trim();
    String password = passwordController.text.trim();
    String confirmpassword = confirmpasswordController.text.trim();

    print(email);
    print(name);
    print(lastname);
    print(fone);
    print(password);
    print(confirmpassword);
  }
}
