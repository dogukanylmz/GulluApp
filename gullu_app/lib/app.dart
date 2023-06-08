import 'package:flutter/Material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gullu_app/Constants/widget_constants.dart';
import 'package:gullu_app/Services/firebase_services.dart';
import 'package:gullu_app/bloc/history_cubit.dart';
import 'package:gullu_app/bloc/product_cubit.dart';

import 'bloc/cart_cubit.dart';


class App extends StatefulWidget {

  final FirebaseServices firebaseServices;
  const App({super.key, required this.firebaseServices});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return 
    MultiBlocProvider(providers: [
     BlocProvider(create: (context)=>ProductCubit(widget.firebaseServices)),
     BlocProvider(create: (context) =>CartCubit(widget.firebaseServices)),
     BlocProvider(create: (context) =>HistoryCubit(widget.firebaseServices))
    ],
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      home: NavBar(),
    )
    );
  }
}