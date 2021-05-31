import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:task/Bloc/offers_bloc.dart';
import 'package:task/Model/all_offers_model.dart';
import 'package:task/Model/item_model.dart';
import 'package:task/Utils/constants.dart';
import 'package:task/Utils/db_helper.dart';
import 'package:task/Views/Login/offer_view_page.dart';

class OffersPage extends StatefulWidget {
  @override
  _OffersPageState createState() => _OffersPageState();
}

class _OffersPageState extends State<OffersPage> {
  final TextEditingController search = TextEditingController();
  final ScrollController scrollController = ScrollController();
  DBHelper? dbHelper;
  Future<List<Items>>? items;
  bool isConnectionAvailable = true;
  checkConnectivity() async {
    try {
      final result = await InternetAddress.lookup("www.google.com/");
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        isConnectionAvailable = true;
        offersBloc.getOffers();
      }
    } on SocketException catch (_) {
      isConnectionAvailable = false;
      print('not connected');
      print(isConnectionAvailable);

      dbHelper = DBHelper();

      refreshItems();
    }
  }

  @override
  void initState() {
    super.initState();
    checkConnectivity();
  }

  refreshItems() {
    setState(() {
      items = dbHelper!.getItemss();
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          centerTitle: true,
          title: Text(
            "Products List",
            style: TextStyle(fontFamily: "Poiret", color: Colors.white),
          ),
        ),
        body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(children: [
                  Container(
                      width: double.infinity,
                      height: 60,
                      decoration: new BoxDecoration(
                        color: Color(0xffffffff),
                        borderRadius: BorderRadius.circular(38),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black12,
                              offset: Offset(2, 4),
                              blurRadius: 18,
                              spreadRadius: 4)
                        ],
                      ),
                      child: Row(
                        children: [
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: TextField(
                                  controller: search,
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.search,
                                      color: kPrimaryColor,
                                    ),
                                    border: InputBorder.none,
                                    hintText: "Search in offers",
                                    hintStyle: TextStyle(
                                      fontFamily: 'Josefin',
                                      color: Color(0x89000000).withOpacity(0.3),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      fontStyle: FontStyle.normal,
                                      letterSpacing: 0,
                                    ),
                                  )),
                            ),
                          ),
                        ],
                      )),
                  SizedBox(
                    height: 21,
                  ),
                  isConnectionAvailable
                      ? StreamBuilder<AllOffers>(
                          stream: offersBloc.responseData,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return GridView.builder(
                                  controller: scrollController,
                                  shrinkWrap: true,
                                  gridDelegate:
                                      SliverGridDelegateWithMaxCrossAxisExtent(
                                          maxCrossAxisExtent: 250,
                                          childAspectRatio: 0.8,
                                          crossAxisSpacing: 5,
                                          mainAxisSpacing: 5),
                                  itemCount: snapshot.data!.data!.length,
                                  itemBuilder: (context, index) {
                                    dbHelper!.add(Items(
                                      null,
                                      snapshot.data!.data![index].title!,
                                      snapshot.data!.data![index].offerMedia![0]
                                          .storageName!,
                                      snapshot
                                          .data!.data![index].estimatedPrice!
                                          .toString(),
                                    ));
                                    return GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    OfferViewPage(
                                                      address: snapshot.data!
                                                          .data![index].address,
                                                      estimatedPrice: snapshot
                                                          .data!
                                                          .data![index]
                                                          .estimatedPrice!,
                                                      id: snapshot.data!
                                                          .data![index].id!,
                                                      imageUrl: snapshot
                                                          .data!
                                                          .data![index]
                                                          .offerMedia![0]
                                                          .storageName!,
                                                      title: snapshot.data!
                                                          .data![index].title!,
                                                    )));
                                      },
                                      child: customCard(
                                        snapshot.data!.data![index]
                                            .offerMedia![0].storageName!,
                                        snapshot.data!.data![index].title!,
                                        snapshot
                                            .data!.data![index].estimatedPrice!,
                                      ),
                                    );
                                  });
                            } else {
                              return CircularProgressIndicator();
                            }
                          })
                      : FutureBuilder(
                          future: items,
                          builder:
                              (context, AsyncSnapshot<List<Items>> snapshot) {
                            if (snapshot.hasData) {
                              return Column(
                                  children: snapshot.data!
                                      .map((item) => GridView.builder(
                                          controller: scrollController,
                                          shrinkWrap: true,
                                          gridDelegate:
                                              SliverGridDelegateWithMaxCrossAxisExtent(
                                                  maxCrossAxisExtent: 250,
                                                  childAspectRatio: 0.8,
                                                  crossAxisSpacing: 5,
                                                  mainAxisSpacing: 5),
                                          itemCount: 4,
                                          itemBuilder: (context, index) {
                                            return GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            OfferViewPage(
                                                                address:
                                                                    item.name,
                                                                estimatedPrice:
                                                                    int.parse(item
                                                                        .price!),
                                                                id: item.id!,
                                                                imageUrl: item
                                                                    .imageUrl,
                                                                title: item
                                                                    .name)));
                                              },
                                              child: customCard(
                                                  item.imageUrl!,
                                                  item.name!,
                                                  int.parse(item.price!)),
                                            );
                                          }))
                                      .toList());
                            }
                            return CircularProgressIndicator();
                          })
                ]))));
  }

  Widget customCard(String imageUrl, String title, int estimatedPrice) {
    return Card(
        clipBehavior: Clip.antiAlias,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Image.network(
                  "https://refreeapp.com/dev/public/uploads/offer/" + imageUrl),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                child: Row(
                  children: [
                    Text(
                      title.toUpperCase(),
                      style: TextStyle(
                          color: kPrimaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                          fontFamily: "Quicksand"),
                    ),
                    Spacer(),
                    Text(
                      "\$" + estimatedPrice.toString(),
                      style: TextStyle(
                          color: Colors.black, fontFamily: "Quicksand"),
                    ),
                  ],
                ),
              )
            ]));
  }
}

class ConnectivityResult {}
