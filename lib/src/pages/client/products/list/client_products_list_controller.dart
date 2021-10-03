import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pico_de_oro/src/utils/shared_pref.dart';

class ClientProductsListController{

  BuildContext context;
  SharedPref _sharedPref =new SharedPref();

  Future init (BuildContext  context){
    this.context= context;
  }
  logout(){
  _sharedPref.logout(context);
  }

}