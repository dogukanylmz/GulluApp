import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gullu_app/Services/firebase_services.dart';
import 'package:gullu_app/Services/models/product_model.dart';
import 'package:gullu_app/bloc/cart_cubit.dart';
import 'package:gullu_app/bloc/cart_states.dart';

import '../Services/models/cart_product_model.dart';


class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  List<CartProductModel> data=[];
  int total=0;

  @override
  void initState() {
    context.read<CartCubit>().getAddedProducts();
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                     InkWell(
                      onTap: (){
                        FirebaseServices().clearCart();
                          Navigator.pop(context);
                      },
                       child:const Icon(
                        FontAwesomeIcons.arrowLeft,
                        color: Colors.white,
                                         ),
                     ),
                     const Text(
                      "Güllü App",
                      style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w400),
                    ),
                   const Icon(FontAwesomeIcons.trash,color: Colors.transparent,)
                  ],
                ),
              )),
        ),
        body: BlocBuilder<CartCubit, CartStates>(
          builder: (context, state) {
            if(state is CartLoadingState){
              return  Center(
                child: CircularProgressIndicator(color: Colors.red.shade400,),
              );
            }
            else if(state is CartCompletedState){
              data=state.model;
              for(int i =0;i<data.length;i++){
                total=total+(data[i].price! * data[i].amount!);
              }
              return Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 90),
                    child: ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return  Container(
                            margin: const EdgeInsets.all(10),
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * 0.1,
                            decoration: BoxDecoration(
                              border: Border.all(width: 1, color: Colors.black.withOpacity(0.1)),
                              color: Colors.white,
                              boxShadow: [BoxShadow(blurRadius: 10, color: Colors.black.withOpacity(0.4))],
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child: CachedNetworkImage(
                                        width: 100,
                                        height: 100,
                                        fit: BoxFit.fitHeight,
                                        imageUrl: data[index].img.toString(),
                                        progressIndicatorBuilder: (context, url, progress) {
                                          return Center(
                                            child: CircularProgressIndicator(
                                              color: Colors.red.shade400,
                                            ),
                                          );
                                        },
                                        errorWidget: (context, url, error) {
                                          return const Center(
                                            child: Text("Bir hata oluştu"),
                                          );
                                        },
                                      ),
                                    ),
                                    const SizedBox(width: 15),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          data[index].name.toString(),
                                          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                                        ),
                                        Row(
                                          children: [
                                            Text(data[index].price.toString(),
                                                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400)),
                                            const Icon(
                                              FontAwesomeIcons.turkishLiraSign,
                                              size: 10,
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                 
                                  ],
                                ),
                                  Row(
                                    children: [
                                      Text("Adet :${data[index].amount}", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400)),
                                      const SizedBox(width: 10,),
                                      Text("Toplam :${(data[index].amount!) * (data[index].price!)}",style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                                  ),
                                  const SizedBox(width: 5,)
                                  ],
                                  )
                              ],
                            ));
                      },
                    ),
                  ),
                  Container(
                    
                    margin:const EdgeInsets.all(10),
                    height: 70,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.red.shade400,
              
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Toplam:$total",style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w400,color: Colors.white)),
                        const Icon(FontAwesomeIcons.turkishLiraSign,color: Colors.white,size: 20,),
                        const Text("Onayla", style:  TextStyle(fontSize: 20, fontWeight: FontWeight.w400,color: Colors.white))
                      ],
                    ),
                  )
                ],
              );           
            }
            else{
              state as CartErrorState;
              return Center(
                child: Text(state.errorMessage),
              );
            }
          },
        )
    );
  }
}