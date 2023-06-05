

import 'package:bloc/bloc.dart';
import 'package:gullu_app/Services/firebase_services.dart';
import 'package:gullu_app/Services/models/product_model.dart';
import 'package:gullu_app/bloc/cart_states.dart';

import '../Services/models/cart_product_model.dart';

class CartCubit extends Cubit<CartStates>{

  final FirebaseServices _firebaseServices;
  CartCubit(this._firebaseServices): super(const CartLoadingState());
  




  Future<void> getAddedProducts()async{


    try {
        emit(const CartLoadingState());
        List<CartProductModel> model=await _firebaseServices.getCartProducts(); 
        emit(CartCompletedState(model));
    } catch (e) {
      emit(const CartErrorState("Bir hata Oluştu")); 
    } 
  }

}