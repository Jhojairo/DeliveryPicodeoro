import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:pico_de_oro/src/pages/restaurant/categories/create/restaurant_categories_create_controller.dart';
import 'package:pico_de_oro/src/utils/my_snackbar.dart';
import 'package:pico_de_oro/src/utils/my_theme.dart';

class RestaurantCategoriesCreatePage extends StatefulWidget {
  const RestaurantCategoriesCreatePage({Key key}) : super(key: key);

  @override
  _RestaurantCategoriesCreatePageState createState() => _RestaurantCategoriesCreatePageState();
}

class _RestaurantCategoriesCreatePageState extends State<RestaurantCategoriesCreatePage> {
  RestaurantCategoriesCreateController _con = new RestaurantCategoriesCreateController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _con.init(context, refresh);
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar (
        title: Text('Nueva categoria',style: TextStyle(color: Colors.yellow),),
        backgroundColor: Colors.red[800],

      ),
      body: Column(
        children: [
          SizedBox(
            height: 30,
          ),
          _textfieldcategory(),
          _textfielddescription(),
          _buutonCreate()
        ],
      ),
    );
  }
  Widget _buutonCreate() {
    return Container(
        width: double.infinity,
        margin: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
        child: ElevatedButton(
          onPressed:_con.createCategory,
          child: Text('Crear Categoria '),
          style: ElevatedButton.styleFrom(
              primary: MyColors.primaryColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              padding: EdgeInsets.symmetric(vertical: 15)),
        )
    );
  }

  Widget _textfieldcategory() {
    return Container(
      padding: EdgeInsets.all(2),
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacityColor,
          borderRadius: BorderRadius.circular(30)),
      child: TextField(
        controller: _con.nameController,
        maxLines: 2,
        maxLength: 20,
        decoration: InputDecoration(
            hintText: 'Nombre de la Categoria',
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(15),
            hintStyle: TextStyle(color: MyColors.secundaryColordark),
            suffixIcon: Icon(
              Icons.list_alt,
              color: MyColors.primaryColor,
            )),
      ),
    );
  }

  Widget _textfielddescription() {
    return Container(
      padding: EdgeInsets.all(10) ,
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacityColor,
          borderRadius: BorderRadius.circular(30)),
      child: TextField(
        controller: _con.descriptionController,
        maxLength: 255,
        maxLines: 4,
        decoration: InputDecoration(
            hintText: 'Descripcion',
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(15),
            hintStyle: TextStyle(color: MyColors.secundaryColordark),
            suffixIcon: Icon(
              Icons.description,
              color: MyColors.primaryColor,
            )
        ),
      ),
    );
  }
  void refresh(){
    setState(() {

    });
  }
}
