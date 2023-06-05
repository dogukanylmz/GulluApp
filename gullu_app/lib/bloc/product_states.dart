
import 'package:equatable/equatable.dart';
import 'package:gullu_app/Services/models/product_model.dart';

abstract class ProductsStates extends Equatable{
  const ProductsStates();
}



class ProductLoadingState extends ProductsStates{

  const ProductLoadingState();
  
  @override
  List<Object?> get props => [];
}

class ProductCompletedState extends ProductsStates{
final List<ProductModel> modelList;
  const ProductCompletedState(this.modelList);
  
  @override
  List<Object?> get props => [modelList];
}

class ProductFailedState extends ProductsStates{
  final String errorMessage;
  const ProductFailedState(this.errorMessage);
  
  @override
  List<Object?> get props => [errorMessage];
}