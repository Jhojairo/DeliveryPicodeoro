import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:pico_de_oro/src/models/order.dart';
import 'package:pico_de_oro/src/models/user.dart';
import 'package:pico_de_oro/src/pages/client/orders/detail/client_orders_detail_page.dart';
import 'package:pico_de_oro/src/provider/orders_provider.dart';
import 'package:pico_de_oro/src/provider/orders_provider.dart';
import 'package:pico_de_oro/src/utils/shared_pref.dart';

class ClientOrdersListController {

  BuildContext context;
  SharedPref _sharedPref = new SharedPref();
  GlobalKey<ScaffoldState> key = new GlobalKey<ScaffoldState>();
  Function refresh;
  User user;
  double total = 0;
  Order order;

  List<String> status = ['PAGADO','DESPACHADO', 'EN CAMINO', 'ENTREGADO'];
  OrdersProvider _ordersProvider = new OrdersProvider();

  bool isUpdated;

  Future init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;
    user = User.fromJson(await _sharedPref.read('user'));

    _ordersProvider.init(context, user);
    refresh();
  }

  Future<List<Order>> getOrders(String status) async {
    return await _ordersProvider.getByClientAndStatus(user.id, status);
  }
/*
  Future<List<Order>> getOrders(String status) async {
    return await _ordersProvider.getByStatus(status);
  }*/
  void openBottomSheet(Order order) async {
    isUpdated = await showMaterialModalBottomSheet(
        context: context,
        builder: (context) => ClientOrdersDetailPage(order: order)
    );

    if (isUpdated) {
      refresh();
    }
  }

  void logout() {
    _sharedPref.logout(context, user.id);
  }

  void goToCategoryCreate() {
    Navigator.pushNamed(context, 'restaurant/categories/create');
  }

  void goToProductCreate() {
    Navigator.pushNamed(context, 'restaurant/products/create');
  }

  void openDrawer() {
    key.currentState.openDrawer();
  }

  void goToRoles() {
    Navigator.pushNamedAndRemoveUntil(context, 'roles', (route) => false);
  }

  void getTotal() {
    total = 0;
    order.products.forEach((product) {
      total = total + (product.price * product.quantity);
    });
    refresh();
  }

}