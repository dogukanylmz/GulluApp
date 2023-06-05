
import 'package:gullu_app/Services/firebase_services.dart';
import 'package:gullu_app/Services/models/product_model.dart';
import 'package:gullu_app/bloc/product_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class ProductCubit extends Cubit<ProductsStates>{

  final FirebaseServices _firebaseServices;

  ProductCubit(this._firebaseServices): super(const ProductLoadingState());


  Future<void> getProductList()async{

    try {
      emit(const ProductLoadingState());
      List<ProductModel> res=await _firebaseServices.getProducts(); 
      emit(ProductCompletedState(res));
    } catch (e) {
      emit(const ProductFailedState("Bir hata oluştu"));
       
    }
  }

}