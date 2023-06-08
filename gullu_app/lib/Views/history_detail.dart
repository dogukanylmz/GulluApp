import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gullu_app/Services/models/cart_product_model.dart';

class HistoryDetail extends StatefulWidget {
  const HistoryDetail({
    super.key,
    required this.data,
  });
  final List<CartProductModel> data;

  @override
  State<HistoryDetail> createState() => _HistoryDetailState();
}

class _HistoryDetailState extends State<HistoryDetail> {
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
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      FontAwesomeIcons.arrowLeft,
                      color: Colors.white,
                    ),
                  ),
                  const Text(
                    "Geçmiş",
                    style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w400),
                  ),
                  const Icon(
                    FontAwesomeIcons.arrowLeft,
                    color: Colors.transparent,
                  ),
                ]))),
      ),
      body: ListView.builder(
          itemCount: widget.data.length,
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
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: CachedNetworkImage(
                      width: 100,
                      height: 100,
                      fit: BoxFit.fitHeight,
                      imageUrl: widget.data[index].img.toString(),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(widget.data[index].name.toString(),style:const TextStyle(fontSize: 20, fontWeight: FontWeight.w400) ,),
                      Text("Adet :${widget.data[index].amount}",style:const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),),
                  
                    ],
                  ),
                  const SizedBox(width: 1,)
                ],
              ),
            );
          }),
    );
  }
}
