import 'package:flutter/cupertino.dart';
import 'package:pico_de_oro/src/models/product.dart';
import 'package:pico_de_oro/src/utils/shared_pref.dart';

class ClientPaymentsStatusController {



BuildContext context;
Function refresh;

String brandCard = '';
String last4='';
SharedPref _sharedPref = new SharedPref();/// editado

List<Product> selectedProducts = [];///editado


Future init(BuildContext context, Function refresh) async  {   /// asiinc editado
  this.context = context;
  this.refresh = refresh;
Map<String,dynamic> arguments = ModalRoute.of(context).settings.arguments as Map <String, dynamic>;
  selectedProducts = Product
      .fromJsonList(await _sharedPref.read('order'))
      .toList;

brandCard= arguments ['brand'];
last4 = arguments['last4'];

refresh();

}
void finihsShoping(){
// _sharedPref.remove('order');

  Navigator.pushNamedAndRemoveUntil(context, 'client/products/list', (route) => false);
}



}