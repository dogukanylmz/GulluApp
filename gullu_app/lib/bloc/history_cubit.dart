


import 'package:bloc/bloc.dart';
import 'package:gullu_app/Services/models/history_model.dart';
import 'package:gullu_app/bloc/history_states.dart';

import '../Services/firebase_services.dart';

class HistoryCubit extends Cubit<HistoryStates>{

  final FirebaseServices _firebaseServices;

  HistoryCubit(this._firebaseServices) : super(const HistoryLoadingState());



  Future<void> getHistory()async{

    try {
      emit(const HistoryLoadingState()); 

      List<HistoryModel> data=await _firebaseServices.getHistory();

      emit(HistoryCompletedState(data));

    } catch (e) {
      emit(const HistoryErrorState("Bir hata oluştu"));
    }

  }
}