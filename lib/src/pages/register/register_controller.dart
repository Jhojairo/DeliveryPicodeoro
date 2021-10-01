import 'package:flutter/material.dart';
import 'package:pico_de_oro/src/models/response_api.dart';
import 'package:pico_de_oro/src/models/user.dart';
import 'package:pico_de_oro/src/provider/users_provider.dart';
import 'package:pico_de_oro/src/utils/my_snackbar.dart';

class RegisterController {
  BuildContext context;
  TextEditingController emailController = new TextEditingController();
  TextEditingController nameController = new TextEditingController();
  TextEditingController lastnameController = new TextEditingController();
  TextEditingController phoneController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController confirmpasswordController = new TextEditingController();

  UsersProvider usersProvider = new UsersProvider();

  Future init(BuildContext context) {
    this.context = context;
    usersProvider.init(context);
  }

  void register() async {
    String email = emailController.text.trim();
    String name = nameController.text.trim();
    String lastname = lastnameController.text.trim();
    String phone = phoneController.text.trim();
    String password = passwordController.text.trim();
    String confirmpassword = confirmpasswordController.text.trim();

    if (email.isEmpty||name.isEmpty||lastname.isEmpty||phone.isEmpty||password.isEmpty||confirmpassword.isEmpty){
MySnackbar.show(context, 'Por Favor ingresa todos los campos ');
      return;
    }
    if (confirmpassword != password){
      MySnackbar.show(context, 'Las contracenias no coinsiden');

    }

    if (password.length<6 ){
      MySnackbar.show(context, 'La contracenia deve tener miniomo 6 dijitos');
    }
    User user = new User(
        email: email,
        name: name,
        lastname: lastname,
        phone: phone,
        password: password);

    ResponseApi responseApi = await usersProvider.create(user);
    MySnackbar.show(context, responseApi.message);

    print('Respuesta: ${responseApi.toJson()}');

    print(email);
    print(name);
    print(lastname);
    print(phone);
    print(password);
    print(confirmpassword);
  }
}
