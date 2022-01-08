import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:pico_de_oro/src/models/category.dart';
import 'package:pico_de_oro/src/pages/restaurant/products/create/restaurant_products_create_controller.dart';
import 'package:pico_de_oro/src/utils/my_theme.dart';
import 'package:flutter/cupertino.dart';


class RestaurantProductsCreatePage extends StatefulWidget {
  const RestaurantProductsCreatePage({Key key}) : super(key: key);

  @override
  _RestaurantProductsCreatePageState createState() => _RestaurantProductsCreatePageState();
}

class _RestaurantProductsCreatePageState extends State<RestaurantProductsCreatePage> {
  RestaurantProductsCreateController _con = new RestaurantProductsCreateController();

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
        title: Text('Nuevo Producto'),

      ),
      body: ListView(
        children: [
          SizedBox(
            height: 30,
          ),
          _textfieldcategory(),
          _textfielddescription(),
          _textfieldprice(),
          Container(
            height: 100,
            margin: EdgeInsets.symmetric(horizontal: 30,vertical: 20),
            child: Row(

              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _cardImage(_con.imageFile1, 1),
                _cardImage(_con.imageFile2, 2),
                _cardImage(_con.imageFile3, 3)
              ],

            ),
          ),
          _dropDownCategories(_con.categories),
          _buttonCreate()
        ],
      ),
    );
  }
  Widget _buttonCreate() {
    return Container(
        width: double.infinity,
        margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        child: ElevatedButton(
          onPressed:_con.createProduct,
          child: Text('Ingresar Producto '),
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
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacityColor,
          borderRadius: BorderRadius.circular(30)),
      child: TextField(
        controller: _con.nameController,
        decoration: InputDecoration(
            hintText: 'Nombre del Producto',
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


  Widget _textfieldprice() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacityColor,
          borderRadius: BorderRadius.circular(30)),
      child: TextField(
        controller: _con.priceController,
        keyboardType: TextInputType.phone ,
        maxLines: 1,
        decoration: InputDecoration(
            hintText: 'Precio',
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(15),
            hintStyle: TextStyle(color: MyColors.secundaryColordark),
            suffixIcon: Icon(
              Icons.monetization_on,
              color: MyColors.primaryColor,
            )),
      ),
    );
  }

  Widget _cardImage(File imageFile, int numberFile) {
    return GestureDetector(
      onTap: (){
        _con.showAlertDialog(numberFile);

      },
      child: imageFile != null

          ? Card(
        elevation: 3.0,
        child: Container(
          height: 100,
          width: MediaQuery.of(context).size.width *  0.26,
          child: Image.file(
            imageFile,
            fit: BoxFit.cover,
          ),
          ),
      )
          :
      Card(
        elevation: 3.0,
        child: Container(
          height: 140,
          width: MediaQuery.of(context).size.width *  0.26,
          child: Image(
            image: AssetImage('assets/img/add_image.png'),
          ),
        ),
      ),
    );
  }

  Widget _dropDownCategories(List<Category> categories) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 33),
      child: Material(
        elevation: 2.0,
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(5)),
        child: Container(
          padding: EdgeInsets.all(10),
         child: Column(
           children: [
             Row(
               children: [
                 Icon(
                   Icons.search,
                   color: MyColors.primaryColor,
                 ),
                 SizedBox(width: 15,),
                 Text(
                   'Categorias',
                   style: TextStyle(
                     color: Colors.grey,
                     fontSize: 16
                   ),
                 )
               ],
             ),
             Container(
               padding: EdgeInsets.symmetric(horizontal: 20),
               child: DropdownButton (
                 underline: Container(
                   alignment: Alignment.centerRight,
                   child: Icon(
                     Icons.arrow_drop_down_circle,
                     color: MyColors.primaryColor,

                   ),
                 ),
                 elevation: 3,
                 isExpanded: true,
                 hint: Text(
                   'Selecciona Categoria',
                   style:TextStyle(
                     color: Colors.grey,
                     fontSize: 16
                   )
                 ),
                 items: _dropDownItems(categories),
                 value: _con.idCategory,
                 onChanged: (option){
                   setState(() {
                     print('Categoria seleccionada $option');
                     _con.idCategory=option;// establecioendo el valor de idCategori

                   });
                 },

               ),
             )

           ],
         ),

        ),
      ),
    );
  }
  List<DropdownMenuItem<String>> _dropDownItems(List<Category> categories) {
    List<DropdownMenuItem<String>> list = [];
    categories.forEach((category) {
      list.add(DropdownMenuItem(
        child: Text(category.name),
        value: category.id,
      ));
    });
    return list;

  }
  Widget _textfielddescription() {
    return Container(
      padding: EdgeInsets.all(10) ,
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacityColor,
          borderRadius: BorderRadius.circular(30)),
      child: TextField(
        controller: _con.descriptionController,
        maxLength: 50,
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
