import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:task/Utils/constants.dart';

class OfferViewPage extends StatefulWidget {
  late final String? title, imageUrl, address;
  late final int? estimatedPrice, id;
  OfferViewPage(
      {this.title, this.address, this.id, this.estimatedPrice, this.imageUrl});
  @override
  _OfferViewPageState createState() => _OfferViewPageState();
}

class _OfferViewPageState extends State<OfferViewPage> {
  String category = '';
  getCategory() async {
    var dio = Dio();
    var response = await dio.get(baseUrl + "/offer-details/${widget.id}");
    print(response.data);

    category = jsonDecode(response.data["data"][0]["category"]["title"]);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getCategory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          centerTitle: true,
          title: Text(
            "Details",
            style: TextStyle(fontFamily: "Poiret", color: Colors.white),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: MediaQuery.of(context).size.height / 2,
                width: double.infinity,
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 7,
                          color: Colors.black12,
                          spreadRadius: 5,
                          offset: Offset(0, 3))
                    ],
                    image: DecorationImage(
                        fit: BoxFit.fitWidth,
                        image: NetworkImage(
                            "https://refreeapp.com/dev/public/uploads/offer/" +
                                '${widget.imageUrl}'))),
              ),
              SizedBox(
                height: 11,
              ),
              Text(
                "${widget.title!.toUpperCase()}",
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: "Josefin",
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 11,
              ),
              Text(
                "Address: ${widget.address}",
                style: TextStyle(
                    fontSize: 21,
                    color: kPrimaryColor,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 11,
              ),
              Text(
                "Estimated Price: ${widget.estimatedPrice.toString()}",
                style: TextStyle(
                    fontSize: 21,
                    color: kPrimaryColor,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 11,
              ),
              Text(
                "Cateogory=> $category",
                style: TextStyle(
                    fontSize: 21,
                    color: kPrimaryColor,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ));
  }
}
