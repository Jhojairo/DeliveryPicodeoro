import 'package:flutter/material.dart';
import 'package:pico_de_oro/src/models/response_api.dart';
import 'package:pico_de_oro/src/models/user.dart';
import 'package:pico_de_oro/src/provider/users_provider.dart';
import 'package:pico_de_oro/src/utils/my_snackbar.dart';
import 'package:pico_de_oro/src/utils/shared_pref.dart';

// aqui esta la paerte logica metodo de navegacion hacia pagina registrar y otros
class LoginController {
  BuildContext context;
  TextEditingController emailcontroller = new TextEditingController();
  TextEditingController passwordcontroller = new TextEditingController();

  UsersProvider usersProvider = new UsersProvider();
  SharedPref _sharedPref = new SharedPref();

  Future init(BuildContext context) async {
    this.context = context;
    await usersProvider.init(context);

    User user = User.fromJson(await _sharedPref.read('user') ?? {});
    print('Usuario : ${user.toJson()}');

   if(user?.sessionToken!= null){
    Navigator.pushNamedAndRemoveUntil(context, 'client/products/list', (route) => false);

    }
  }

  void goToRegisterPage() {
    Navigator.pushNamed(context, "register");
  }

  void login() async {
    String email = emailcontroller.text.trim(); // trim elimina espacios en blanco para que email u pass word sean validos
    String password = passwordcontroller.text.trim();
    ResponseApi responseApi = await usersProvider.login(email, password);
    print('Respuesta: ${responseApi}');
    print('Respuesta object: ${responseApi.toJson()}');


    if (responseApi.success) {
      User user = User.fromJson(responseApi.data); // responseApi. data regresa un mapa de valores
      _sharedPref.save('user', user.toJson());
      Navigator.pushNamedAndRemoveUntil(context, 'client/products/list', (route) => false);
    } else {
      MySnackbar.show(context, responseApi.message);
    }


  }
}
