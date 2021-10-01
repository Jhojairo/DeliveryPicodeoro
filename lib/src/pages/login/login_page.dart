import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:pico_de_oro/src/pages/login/login_controller.dart';
import 'package:pico_de_oro/src/utils/my_theme.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // clase para llamar a la pagina  de registro del metodo de login controller

  LoginController _con = new LoginController();
  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _con.init(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Mycolors.backgrund,
        body: Container(
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              children: [
                _imageBaner(),
                _textfieldemail(),
                _textfieldpass(),
                _buutonIngresr(),
                _textfieldNoAcount(),
              ],
            ),
          ),
        ));
  }

  Widget _imageBaner() {
    return Container(
      margin: EdgeInsets.only(
          top: 100, bottom: MediaQuery.of(context).size.height * 0.20),
      child: Image.asset(
        'assets/img/picodeoro.png',
        width: 400,
        height: 200,
      ),
    );
  }

  Widget _textfieldemail() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      decoration: BoxDecoration(
          color: Mycolors.primaryOpacityColor,
          borderRadius: BorderRadius.circular(30)),
      child: TextField(
        controller: _con.emailcontroller,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
            hintText: 'Correo Electronico',
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(15),
            hintStyle: TextStyle(color: Mycolors.secundaryColordark),
            prefixIcon: Icon(
              Icons.email,
              color: Mycolors.primaryColor,
            )),
      ),
    );
  }

  Widget _textfieldpass() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      decoration: BoxDecoration(
          color: Mycolors.primaryOpacityColor,
          borderRadius: BorderRadius.circular(30)),
      child: TextField(
        controller: _con.passwordcontroller,
        //keyboardType: TextInputType.visiblePassword,
        obscureText: true,
        decoration: InputDecoration(
            hintText: 'password',
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(15),
            hintStyle: TextStyle(color: Mycolors.secundaryColordark),
            prefixIcon: Icon(
              Icons.lock,
              color: Mycolors.primaryColor,
            )),
      ),
    );
  }

  Widget _textfieldNoAcount() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'No tienes Cuenta?',
          style: TextStyle(color: Mycolors.primaryColor),
        ),
        SizedBox(
          width: 7,
        ),
        GestureDetector(
          onTap: _con.goToRegisterPage,
          child: Text(
            'Registrate',
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Mycolors.primaryColor),
          ),
        )
      ],
    );
  }

  Widget _buutonIngresr() {
    return Container(
        width: double.infinity,
        margin: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
        child: ElevatedButton(
          onPressed: _con.loguin,
          child: Text('Ingresar'),
          style: ElevatedButton.styleFrom(
              primary: Mycolors.primaryColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              padding: EdgeInsets.symmetric(vertical: 15)),
        ));
  }
}
