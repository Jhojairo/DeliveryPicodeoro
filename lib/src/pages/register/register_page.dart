import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:pico_de_oro/src/pages/register/register_controller.dart';
import 'package:pico_de_oro/src/utils/my_theme.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  RegisterController _con = new RegisterController();

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
        width: double
            .infinity, // para usar todo el ancjho de la pantalla double.Infinity

        child: Stack(
          children: [
            Positioned(top: 65, left: 27, child: _textregister()),
            Positioned(top: 51, left: -5, child: _iconback()),
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(top: 50),
              child: SingleChildScrollView(
                //SingleChildScrollView es para que no salga error de overfloat aal momento de escrivir en los campos de texto
                child: Column(
                  children: [
                    _imageBaner(),
                    _imageuser(),
                    _textfieldemail(),
                    _textfieldname(),
                    _textfieldlastname(),
                    _textfieldfone(),
                    _textfieldpass(),
                    _textfieldconfirmpassword(),
                    _buutonIngresr(),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _imageuser() {
    return CircleAvatar(
      backgroundImage: AssetImage('assets/img/user_profile_2.png'),
      radius: 60,
      backgroundColor: Colors.red[800],
    );
  }

  Widget _textregister() {
    return Text(
      'Registrate',
      style: TextStyle(
          color: Colors.red,
          fontWeight: FontWeight.bold,
          fontSize: 20,
          fontFamily: 'NimbusSans'),
    );
  }

  Widget _iconback() {
    return IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back_ios));
  }

  Widget _imageBaner() {
    return Container(
      margin: EdgeInsets.only(
          top: 80, bottom: MediaQuery.of(context).size.height * 0.00),
      child: Image.asset(
        'assets/img/picodeoro.png',
        width: 200,
        height: 100,
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
        controller: _con.emailController,
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

  Widget _textfieldname() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      decoration: BoxDecoration(
          color: Mycolors.primaryOpacityColor,
          borderRadius: BorderRadius.circular(30)),
      child: TextField(
        controller: _con.nameController,
        decoration: InputDecoration(
            hintText: 'Nombre',
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(15),
            hintStyle: TextStyle(color: Mycolors.secundaryColordark),
            prefixIcon: Icon(
              Icons.person,
              color: Mycolors.primaryColor,
            )),
      ),
    );
  }

  Widget _textfieldlastname() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      decoration: BoxDecoration(
          color: Mycolors.primaryOpacityColor,
          borderRadius: BorderRadius.circular(30)),
      child: TextField(
        controller: _con.lastnameController,
        decoration: InputDecoration(
            hintText: 'Apellido',
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(15),
            hintStyle: TextStyle(color: Mycolors.secundaryColordark),
            prefixIcon: Icon(
              Icons.person_outline,
              color: Mycolors.primaryColor,
            )),
      ),
    );
  }

  Widget _textfieldfone() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      decoration: BoxDecoration(
          color: Mycolors.primaryOpacityColor,
          borderRadius: BorderRadius.circular(30)),
      child: TextField(
        controller: _con.phoneController,
        keyboardType: TextInputType.phone,
        decoration: InputDecoration(
            hintText: 'Telefono',
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
        controller: _con.passwordController,
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

  Widget _textfieldconfirmpassword() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      decoration: BoxDecoration(
          color: Mycolors.primaryOpacityColor,
          borderRadius: BorderRadius.circular(30)),
      child: TextField(
        controller: _con.confirmpasswordController,
        obscureText: true,
        decoration: InputDecoration(
            hintText: 'Repita Contraceña',
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(15),
            hintStyle: TextStyle(color: Mycolors.secundaryColordark),
            prefixIcon: Icon(
              Icons.lock_outline,
              color: Mycolors.primaryColor,
            )),
      ),
    );
  }

  Widget _buutonIngresr() {
    return Container(
        width: double.infinity,
        margin: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
        child: ElevatedButton(
          onPressed: _con.register,
          child: Text('Registate'),
          style: ElevatedButton.styleFrom(
              primary: Mycolors.primaryColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              padding: EdgeInsets.symmetric(vertical: 15)),
        ));
  }
}
