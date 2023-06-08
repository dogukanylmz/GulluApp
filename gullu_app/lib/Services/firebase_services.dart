


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gullu_app/Services/models/history_model.dart';
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

Future<void> addToHistory(List<CartProductModel> listModel,int total)async{

     FirebaseFirestore firestore=FirebaseFirestore.instance;
     final CollectionReference colref =firestore.collection("History");

     String day="";
     String month="";
     String year="";
     DateTime now=DateTime.now().toUtc();
     DateTime localdate=now.toLocal();

     year=localdate.year.toString();
     if(localdate.day<10){
      day="0${localdate.day}";
     }
     else{
      day=localdate.day.toString();
     }
     if(localdate.month<10){
      month="0${localdate.month}";
     }
     else{
      month=localdate.month.toString();
     }

     colref.add({
      "createdDate":"$day/$month/$year",
      "total":total,
     }).then((value) {
      final CollectionReference colref=value.collection("product");
      for(int i =0;i<listModel.length;i++){
        colref.add({
          "price":listModel[i].price,
          "name":listModel[i].name,
          "img":listModel[i].img,
          "id":listModel[i].id,
          "amount":listModel[i].amount
        });
      }
     });

}

Future<List<HistoryModel>> getHistory()async{

    List<HistoryModel> historyList=[];
      FirebaseFirestore firestore=FirebaseFirestore.instance;
     final CollectionReference maincolref =firestore.collection("History");

     var res=await maincolref.get();
     
     
    for(int i=0;i<res.docs.length;i++){
      
      historyList.add(HistoryModel.fromJson(res.docs[i].data() as Map<String,dynamic>));
      var subcol=await maincolref.doc(res.docs[i].id).collection("product").get();
      for(int j=0;j<subcol.docs.length;j++){
        historyList[i].product!.add(CartProductModel.fromJson(subcol.docs[j].data()));
      }
      
    }

    return historyList;
}

Future<List<CartProductModel>> getHistoryDetail(String docid)async{

  List<CartProductModel> model=[];
   FirebaseFirestore firestore=FirebaseFirestore.instance;
     final CollectionReference maincolref =firestore.collection("History");
     var res=await maincolref.doc(docid).collection("product").get();

     for(int i=0;i<res.docs.length;i++){

      model.add(CartProductModel.fromJson(res.docs[i].data())) ;

     }
     return model;
}
 
}