import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  String? name;
  int? id;
  int? price;
  String? img;

  ProductModel({this.name, this.id, this.price, this.img});

  ProductModel.fromJson(Map<String, dynamic>?  json) {
    name = json?['name'] ;
    id = json?['id'];
    price = json?['price'];
    img = json?['img'];
  }


}
