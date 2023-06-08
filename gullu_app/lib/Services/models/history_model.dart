import 'package:gullu_app/Services/models/cart_product_model.dart';

class HistoryModel {
  String? createdDate;
  int? total;
  List<CartProductModel>? product;

  HistoryModel({this.createdDate, this.total, this.product});

  HistoryModel.fromJson(Map<String, dynamic> json) {
    createdDate = json['createdDate'];
    total = json['total'];
    if (json['product'] != null) {
      product = <CartProductModel>[];
      json['product'].forEach((v) {
        product!.add( CartProductModel.fromJson(v));
      });
    }
    else{
      product=[];
    }
  }


}



  

