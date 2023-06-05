


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gullu_app/Services/models/product_model.dart';

import 'models/cart_product_model.dart';

class FirebaseServices{




Future<List<ProductModel>> getProducts()async {
List<ProductModel>? products=[];
FirebaseFirestore firestore=FirebaseFirestore.instance;

final CollectionReference colref =firestore.collection("Categories");

var res=await colref.get();

for(int i=0;i<res.docs.length;i++){
  products.add(ProductModel.fromJson(res.docs[i].data() as Map<String,dynamic>?));
}

  return products;

}

Future<void> addProductstoCart(List<ProductModel>products ,List<int> productCount)async{

  List<ProductModel>addedProduct=[];
  FirebaseFirestore firestore=FirebaseFirestore.instance;
  final CollectionReference colref =firestore.collection("OrderCart"); 

  for(int i =0;i<productCount.length;i++){
    if(productCount[i]==0){
      continue;
    }
    else{
      for (int j = 0; j < products.length; j++) {
        
        if(products[j].id==i+1){
          addedProduct.add(products[j]);
        }
      }
    }
  }

for (int i = 0; i < addedProduct.length; i++) {
  
      colref.add({

        "id":addedProduct[i].id,
        "name":addedProduct[i].name,
        "amount":productCount[addedProduct[i].id!-1],
        "img":addedProduct[i].img,
        "price":addedProduct[i].price
      }
    );
}

}
Future<List<CartProductModel>> getCartProducts()async{
  
  List<CartProductModel>? products=[];
   FirebaseFirestore firestore=FirebaseFirestore.instance;
  final CollectionReference colref =firestore.collection("OrderCart");
  var res=await colref.get();

for(int i=0;i<res.docs.length;i++){
  products.add(CartProductModel.fromJson(res.docs[i].data() as Map<String,dynamic>?));
}

  return products;
}

Future<void> clearCart()async{


   FirebaseFirestore firestore=FirebaseFirestore.instance;
  final CollectionReference colref =firestore.collection("OrderCart");
  
    var res=await colref.get();
    for(int i =0;i<res.docs.length;i++){
      
       colref.doc(res.docs[i].id).delete();
    }
}

}