class CartProductModel {
  String? name;
  int? id;
  int? price;
  String? img;
  int? amount;

  CartProductModel({this.name, this.id, this.price, this.img,});

  CartProductModel.fromJson(Map<String, dynamic>?  json) {
    name = json?['name'] ;
    id = json?['id'];
    price = json?['price'];
    img = json?['img'];
    amount=json?["amount"];
  }
}
