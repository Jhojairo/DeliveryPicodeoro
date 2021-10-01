import 'package:meta/meta.dart';
import 'dart:convert';
/*
metodowue recive un strin y retorna un objeto tipoo user
 */
User userFromJson(String str) => User.fromJson(json.decode(str));

/*
metodo que recive un objeto user y retorna un string
 */
String userToJson(User data) => json.encode(data.toJson());
/* * aqui se defienen variables de la tabla usuario usando quicktype para comvertir a json  */
class User {
  String id;
  String name;
  String lastname;
  String email;
  String phone;
  String password;
  String sessionToken;
  String image;


    /* *este es el constructor del la tabla user */
  User({
    @required this.id,
    @required this.name,
    @required this.lastname,
    @required this.email,
    @required this.phone,
    @required this.password,
    @required this.sessionToken,
    @required this.image,
  });

/* * metodo que recive un mapa de valores un json que retorna objeto  tipo user
* */

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    name: json["name"],
    lastname: json["lastname"],
    email: json["email"],
    phone: json["phone"],
    password: json["password"],
    sessionToken: json["session_token"],
    image: json["image"],
  );
/*
transforma el objeto ...objeto tojson q toma el objeto user y lo transforma en json
 */
  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "lastname": lastname,
    "email": email,
    "phone": phone,
    "password": password,
    "session_token": sessionToken,
    "image": image,
  };
}