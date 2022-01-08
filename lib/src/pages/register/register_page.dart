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
      _con.init(context,refresh);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.backgrund,
      body: Container(
        width: double
            .infinity, // para usar todo el ancjho de la pantalla double.Infinity

        child: Stack(
          children: [
            Positioned(
                top: 63,
                left: 15,
                child: _textregister() ),

            Container(
              width: double.infinity,
              margin: EdgeInsets.only(top: 50),
              child: SingleChildScrollView(
                //SingleChildScrollView es para que no salga error de overfloat aal momento de escrivir en los campos de texto
                child: Column(
                  children: [
                    _iconback(),
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
    return GestureDetector(
      onTap: _con.showAlertDialog,
      child: CircleAvatar(
      backgroundImage:_con.imageFile != null
      ?FileImage(_con.imageFile)
      :AssetImage('assets/img/user_profile_2.png'),
      radius: 60,
      backgroundColor: Colors.red[800],
      ),
    );
  }

  Widget _textregister() {
    return Text(
      ' Atras',
      style: TextStyle(
          color: Colors.red,
          fontWeight: FontWeight.bold,
          fontSize: 20,
          fontFamily: 'NimbusSans'),
    );
  }

  Widget _iconback() {
    return IconButton(
      padding: EdgeInsets.only(left:5,right:500),
        onPressed: _con.back ,
        icon: Icon(Icons.arrow_back_ios));
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
          color: MyColors.primaryOpacityColor,
          borderRadius: BorderRadius.circular(30)),
      child: TextField(
        controller: _con.emailController,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
            hintText: 'Correo Electronico',
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(15),
            hintStyle: TextStyle(color: MyColors.secundaryColordark),
            prefixIcon: Icon(
              Icons.email,
              color: MyColors.primaryColor,
            )),
      ),
    );
  }

  Widget _textfieldname() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacityColor,
          borderRadius: BorderRadius.circular(30)),
      child: TextField(
        controller: _con.nameController,
        decoration: InputDecoration(
            hintText: 'Nombre',
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(15),
            hintStyle: TextStyle(color: MyColors.secundaryColordark),
            prefixIcon: Icon(
              Icons.person,
              color: MyColors.primaryColor,
            )),
      ),
    );
  }

  Widget _textfieldlastname() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacityColor,
          borderRadius: BorderRadius.circular(30)),
      child: TextField(
        controller: _con.lastnameController,
        decoration: InputDecoration(
            hintText: 'Apellido',
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(15),
            hintStyle: TextStyle(color: MyColors.secundaryColordark),
            prefixIcon: Icon(
              Icons.person_outline,
              color: MyColors.primaryColor,
            )),
      ),
    );
  }

  Widget _textfieldfone() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacityColor,
          borderRadius: BorderRadius.circular(30)),
      child: TextField(
        controller: _con.phoneController,
        keyboardType: TextInputType.phone,
        decoration: InputDecoration(
            hintText: 'Telefono',
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(15),
            hintStyle: TextStyle(color: MyColors.secundaryColordark),
            prefixIcon: Icon(
              Icons.email,
              color: MyColors.primaryColor,
            )),
      ),
    );
  }

  Widget _textfieldpass() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacityColor,
          borderRadius: BorderRadius.circular(30)),
      child: TextField(
        controller: _con.passwordController,
        obscureText: true,
        decoration: InputDecoration(
            hintText: 'password',
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(15),
            hintStyle: TextStyle(color: MyColors.secundaryColordark),
            prefixIcon: Icon(
              Icons.lock,
              color: MyColors.primaryColor,
            )),
      ),
    );
  }

  Widget _textfieldconfirmpassword() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacityColor,
          borderRadius: BorderRadius.circular(30)),
      child: TextField(
        controller: _con.confirmpasswordController,
        obscureText: true,
        decoration: InputDecoration(
            hintText: 'Repita Contraceña',
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(15),
            hintStyle: TextStyle(color: MyColors.secundaryColordark),
            prefixIcon: Icon(
              Icons.lock_outline,
              color: MyColors.primaryColor,
            )),
      ),
    );
  }

  Widget _buutonIngresr() {
    return Container(
        width: double.infinity,
        margin: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
        child: ElevatedButton(
          onPressed:_con.isEnable ? _con.register : null,
          child: Text('Registate'),
          style: ElevatedButton.styleFrom(
              primary: MyColors.primaryColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              padding: EdgeInsets.symmetric(vertical: 15)),
        )
    );
  }
  void refresh(){
    setState(() {

    });
  }
}
