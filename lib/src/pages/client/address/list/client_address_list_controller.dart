import 'package:flutter/material.dart';
import 'package:pico_de_oro/src/models/order.dart';
import 'package:pico_de_oro/src/models/product.dart';
import 'package:pico_de_oro/src/models/response_api.dart';
import 'package:pico_de_oro/src/models/user.dart';
import 'package:pico_de_oro/src/models/address.dart';
import 'package:pico_de_oro/src/provider/StripeProvider.dart';
import 'package:pico_de_oro/src/provider/products_provider.dart';
import 'package:pico_de_oro/src/provider/address_provider.dart';
import 'package:pico_de_oro/src/provider/orders_provider.dart';
import 'package:pico_de_oro/src/utils/my_snackbar.dart';
import 'package:pico_de_oro/src/utils/shared_pref.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';

class ClientAddressListController {

  BuildContext context;
  Function refresh;

  List<Address> address = [];
  List<Product> selectedProducts = [];

  AddressProvider _addressProvider = new AddressProvider();
  User user;
  SharedPref _sharedPref = new SharedPref();

  Order order;
  Product product;

  double total = 0;

  int radioValue = 0;

  bool isCreated;

  Map<String, dynamic> dataIsCreated;

  OrdersProvider _ordersProvider = new OrdersProvider();
  ProductsProvider _productsProvider =new ProductsProvider();
  StripeProvider _stripeProvider = new StripeProvider();  ////cambio para pagos stripe
  ProgressDialog progressDialog;

  Future init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;
    progressDialog = new ProgressDialog(context: context);
    user = User.fromJson(await _sharedPref.read('user'));
    _addressProvider.init(context, user);
    _ordersProvider.init(context, user);
    _productsProvider.init(context, user);
    _stripeProvider.init(context);/// pagos stripe
    selectedProducts = Product.fromJsonList(await _sharedPref.read('order')).toList;

    getTotal();

    refresh();
  }
  void getTotal() {
    total = 0;
    selectedProducts.forEach((product) {
      total = total + (product.quantity * product.price);
      return total;

    });
    refresh();
  }

  void createOrder() async {


    progressDialog.show(max: 50, msg: 'Estamos prosesando su transaccion');

    var response = await _stripeProvider.payWhitCard('${(total*100).floor()}', 'USD' );

    progressDialog.close();

    MySnackbar.show(context, response.message)  ;

    if (response.success){

      Address a = Address.fromJson(await _sharedPref.read('address') ?? {});

      List<Product> selectedProducts = Product.fromJsonList(await _sharedPref.read('order')).toList;
      Order order = new Order(
          idClient: user.id,
          idAddress: a.id,
          products: selectedProducts
      );
      ResponseApi responseApi = await _ordersProvider.create(order);

      // imprimir pantalla de recivo
      if(responseApi.success){
        
        Navigator.pushNamedAndRemoveUntil(
            context,
            'client/payments/status',
                (route) => false,
          arguments: {
              'brand': response.paymentMethod.card.brand,
              'last4': response.paymentMethod.card.last4,

          }
        );
      }
      
      print('Respuesta orden : ${responseApi.message}');
    }

   // Navigator.pushNamed(context, 'client/payments/create');

  }

  void handleRadioValueChange(int value) async {

    radioValue = value;
    _sharedPref.save('address', address[value]);
    refresh();
     print('Valor seleccionado: $radioValue');
  }

  Future<List<Address>> getAddress() async {
    address = await _addressProvider.getByUser(user.id);

    Address a = Address.fromJson(await _sharedPref.read('address') ?? {});
    int index = address.indexWhere((ad) => ad.id == a.id);

    if (index != -1) {
      radioValue = index;
    }
    print('SE GUARDO LA DIRECCION: ${a.toJson()}');

    return address;
  }



  void goToNewAddress() async {
    // AQUI SE PUEDE PONER EL METODO PARA BORRAR ORDEN COMPRADA  DE LA LISTA ANTES DE QUE REGRESE A LA PANTALLA DE COMPRS
    var result = await Navigator.pushNamed(context, 'client/address/create');

    if (result != null) {
      if (result) {
        refresh();
      }
    }
  }

}