import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pico_de_oro/src/models/response_api.dart';
import 'package:pico_de_oro/src/models/user.dart';
import 'package:pico_de_oro/src/provider/users_provider.dart';
import 'package:pico_de_oro/src/utils/my_snackbar.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';


import 'dart:io';

class RegisterController {
  BuildContext context;
  TextEditingController emailController = new TextEditingController();
  TextEditingController nameController = new TextEditingController();
  TextEditingController lastnameController = new TextEditingController();
  TextEditingController phoneController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController confirmpasswordController = new TextEditingController();

  UsersProvider usersProvider = new UsersProvider();
  PickedFile pickedFile;
  File imageFile;
  Function refresh;

  ProgressDialog _progressDialog ;
  bool isEnable= true;


  Future init(BuildContext context , Function refresh) {
    this.context = context;
    this.refresh=refresh;
    usersProvider.init(context);
    _progressDialog =  ProgressDialog(context: context);

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
return;
    }

    if (password.length<6 ){
      MySnackbar.show(context, 'La contracenia deve tener miniomo 6 dijitos');
    return;
    }

    if(imageFile==null){
      MySnackbar.show(context, 'Selecciona una foto');
    }
    isEnable=false;
    _progressDialog.show(max: 100, msg: 'Momento por favor.... ');







    User user = new User(
        email: email,
        name: name,
        lastname: lastname,
        phone: phone,
        password: password);


    Stream stream =await usersProvider.createWithImage(user, imageFile);
    stream.listen((res) {
      _progressDialog.close();



      //ResponseApi responseApi = await usersProvider.create(user);
      ResponseApi responseApi = ResponseApi.fromJson(json.decode(res));
      print('Respuesta: ${responseApi.toJson()}');

      MySnackbar.show(context, responseApi.message);

      if (responseApi.success){
        Future.delayed(Duration(seconds:3),(){
          Navigator.pushReplacementNamed(context, 'login');
        });
      }
      else{
        isEnable=true;
      }

    });


  }
Future selectImage(ImageSource imageSource)async{

pickedFile = await ImagePicker().getImage(source: imageSource);
if(pickedFile != null){

  imageFile=File(pickedFile.path);
}
Navigator.pop(context);
refresh();


}


  void showAlertDialog(){
    Widget galleryButton= ElevatedButton(
        onPressed: (){
          selectImage(ImageSource.gallery);
        },
        child: Text('Galeria'),
    );

    Widget cameraButton= ElevatedButton(
        onPressed: (){
          selectImage(ImageSource.camera);
        },
        child: Text('Camara'),
    );

    AlertDialog alertDialog =AlertDialog(
      title: Text('Selecciona una foto'),
      actions: [
        galleryButton,
        cameraButton
      ],
    );

    showDialog(
     context: context,
     builder:(BuildContext context){
        return alertDialog;
      }
     );
    }

  void back () {
    Navigator.pop(context);

}
}
