import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gullu_app/Services/models/history_model.dart';
import 'package:gullu_app/Views/history_detail.dart';
import 'package:gullu_app/bloc/history_cubit.dart';
import 'package:gullu_app/bloc/history_states.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class HistoryView extends StatefulWidget {
  const HistoryView({super.key});

  @override
  State<HistoryView> createState() => _HistoryViewState();
}

class _HistoryViewState extends State<HistoryView> {
  List<HistoryModel>? model;
  bool isloading=true;
  @override
  void initState() {
    // TODO: implement initState
    BlocProvider.of<HistoryCubit>(context).getHistory();
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(MediaQuery.of(context).size.width, 100),
        child: Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width,
            height: 100,
            decoration: BoxDecoration(
                color: Colors.red.shade300,
                borderRadius:
                    const BorderRadius.only(bottomLeft: Radius.circular(15), bottomRight: Radius.circular(15))),
            child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Row(mainAxisAlignment: MainAxisAlignment.center, children: const [
                  Text(
                    "Güllü App",
                    style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w400),
                  ),
                ]))),
      ),
      body: BlocListener<HistoryCubit, HistoryStates>(
        listener: (context, state) {
          if (state is HistoryLoadingState) {
             isloading=true;
          } else if (state is HistoryCompletedState) {
                setState(() {
                model = state.model;
                isloading=false;
             });   
          } else {
            state as HistoryErrorState;
              SnackBar(content: Text(state.errorMessage));
          }
        },
        child: isloading ? const Center(
          child: CircularProgressIndicator(color: Colors.red,),
        ) :
        Padding(
              padding: const EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 25),
              child: GridView.builder(
                gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,crossAxisSpacing: 8,mainAxisSpacing: 8),
                itemCount: model?.length ?? 0,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: (){
                      PersistentNavBarNavigator.pushNewScreen(context, screen:  HistoryDetail(data: model?[index].product ?? []),withNavBar: false);
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width *0.3,
                      height: MediaQuery.of(context).size.height * 0.2,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          width: 1,
                          color: Colors.black.withOpacity(0.2),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                    
                        children: [
                          const Text("Tarih",style:TextStyle(fontSize: 16,fontWeight: FontWeight.w400)),
                          Text((model?[index].createdDate.toString() ?? ""),style:const TextStyle(fontSize: 16,fontWeight: FontWeight.w400),),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Toplam :${model?[index].total.toString() ?? ""}",style:const TextStyle(fontSize: 16,fontWeight: FontWeight.w400),),
                            const  Icon(FontAwesomeIcons.turkishLiraSign,size: 16,)
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
        )
      ),
    );
  }
}
