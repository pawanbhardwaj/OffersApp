import 'package:rxdart/rxdart.dart';
import 'package:task/Model/all_offers_model.dart';

import 'package:task/webservices/repository.dart';

class OffersBloc {
  final Repository repository = Repository();

  var serviceFetcher = PublishSubject<AllOffers>();

  Stream<AllOffers> get responseData => serviceFetcher.stream;

  getOffers() async {
    var response = await repository.getOffers();
    serviceFetcher.sink.add(response);
    if (response.status == 200) {
    } else {
      print(response.data);
    }
  }

  void dispose() async {
    await serviceFetcher.drain();
    serviceFetcher.close();
  }
}

final offersBloc = OffersBloc();
