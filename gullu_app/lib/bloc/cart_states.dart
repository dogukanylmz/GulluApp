import 'package:equatable/equatable.dart';
import 'package:gullu_app/Services/models/product_model.dart';

import '../Services/models/cart_product_model.dart';

abstract class CartStates extends Equatable{
  const CartStates();
}




class CartLoadingState extends CartStates{
  const CartLoadingState();
  
  
  @override
  List<Object?> get props =>[];
}



class CartErrorState extends CartStates{

  final String errorMessage;

  const CartErrorState(this.errorMessage);
  @override
  List<Object?> get props => [errorMessage];
}


class CartCompletedState extends CartStates{

  final List<CartProductModel> model;

  const CartCompletedState(this.model);

  @override
  List<Object?> get props => [model];
}