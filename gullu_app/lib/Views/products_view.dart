import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gullu_app/Services/firebase_services.dart';
import 'package:gullu_app/Services/models/product_model.dart';
import 'package:gullu_app/Views/cart_view.dart';
import 'package:gullu_app/bloc/product_cubit.dart';
import 'package:gullu_app/bloc/product_states.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class Products extends StatefulWidget {
  const Products({super.key});

  @override
  State<Products> createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  List<ProductModel> data = [];
  List<int> productCounter = [0, 0, 0, 0, 0, 0, 0];
  int totalProductCounter = 0;
  @override
  void initState() {
    super.initState();
    BlocProvider.of<ProductCubit>(context).getProductList();
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
                    const Icon(
                      FontAwesomeIcons.cartShopping,
                      color: Colors.transparent,
                    ),
                    const Text(
                      "Güllü App",
                      style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w400),
                    ),
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        InkWell(
                          onTap: () {
                            FirebaseServices().addProductstoCart(data, productCounter);
                            PersistentNavBarNavigator.pushNewScreen(context,
                                screen: const CartView(), withNavBar: false);
                          },
                          child: const Icon(
                            FontAwesomeIcons.cartShopping,
                            color: Colors.white,
                          ),
                        ),
                        Positioned(
                            right: -11,
                            top: -6,
                            child: totalProductCounter >= 10
                                ? Text(
                                    "9+",
                                    style: TextStyle(
                                        color: Colors.brown.shade600, fontSize: 14, fontWeight: FontWeight.w600),
                                  )
                                : totalProductCounter > 0
                                    ? Text(
                                        totalProductCounter.toString(),
                                        style: TextStyle(
                                            color: Colors.brown.shade600, fontSize: 14, fontWeight: FontWeight.w600),
                                      )
                                    : const Text(""))
                      ],
                    )
                  ],
                ),
              )),
        ),
        body: BlocBuilder<ProductCubit, ProductsStates>(
          builder: (context, state) {
            if (state is ProductLoadingState) {
              return Center(
                child: CircularProgressIndicator(
                  color: Colors.red.shade400,
                ),
              );
            } else if (state is ProductCompletedState) {
              data = state.modelList;
              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return Container(
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
                                            size: 15,
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  InkWell(
                                      onTap: () {
                                        if (productCounter[data[index].id! - 1] > 0) {
                                          setState(() {
                                            productCounter[((data[index].id! - 1))]--;
                                            totalProductCounter--;
                                          });
                                        }
                                      },
                                      child: const Icon(FontAwesomeIcons.minus)),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(productCounter[data[index].id! - 1].toString()),
                                  ),
                                  InkWell(
                                      onTap: () {
                                        setState(() {
                                          productCounter[((data[index].id! - 1))]++;
                                          totalProductCounter++;
                                        });
                                      },
                                      child: const Icon(FontAwesomeIcons.plus)),
                                  const SizedBox(
                                    width: 5,
                                  )
                                ],
                              )
                            ],
                          ));
                    }),
              );
            } else {
              state as ProductFailedState;
              return Scaffold(
                body: Center(child: Text(state.errorMessage)),
              );
            }
          },
        ));
  }
}
