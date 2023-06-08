import 'package:equatable/equatable.dart';
import 'package:gullu_app/Services/models/history_model.dart';

abstract class HistoryStates extends Equatable{

  const HistoryStates();
}



class HistoryLoadingState extends HistoryStates{
  
  const HistoryLoadingState();
  @override 
  List<Object?> get props => [];
}


class HistoryCompletedState extends HistoryStates{
  
  final List<HistoryModel> model;

 const HistoryCompletedState(this.model);
  
  @override
  List<Object?> get props => [model];
}


class HistoryErrorState extends HistoryStates{
  
  final String errorMessage;

  const HistoryErrorState(this.errorMessage);
  
  @override
  List<Object?> get props => [errorMessage];
}