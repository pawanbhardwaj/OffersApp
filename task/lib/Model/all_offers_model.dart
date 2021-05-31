// To parse this JSON data, do
//
//     final allOffers = allOffersFromJson(jsonString);

import 'dart:convert';

AllOffers allOffersFromJson(String str) => AllOffers.fromJson(json.decode(str));

String allOffersToJson(AllOffers data) => json.encode(data.toJson());

class AllOffers {
  AllOffers({
    this.status,
    this.message,
    this.totalCount,
    this.data,
  });

  int? status;
  String? message;
  int? totalCount;
  List<Datum>? data;

  factory AllOffers.fromJson(Map<String, dynamic> json) => AllOffers(
        status: json["status"],
        message: json["message"],
        totalCount: json["total_count"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "total_count": totalCount,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  Datum(
      {this.id,
      this.title,
      this.estimatedPrice,
      this.offerMedia,
      this.address});

  int? id;

  String? title;

  int? estimatedPrice;
  String? address;
  List<OfferMedia>? offerMedia;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        title: json["title"],
        estimatedPrice: json["estimated_price"],
        address: json['address'],
        offerMedia: List<OfferMedia>.from(
            json["offer_media"].map((x) => OfferMedia.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "address": address,
        "estimated_price": estimatedPrice,
        "offer_media": List<dynamic>.from(offerMedia!.map((x) => x.toJson())),
      };
}

class OfferMedia {
  OfferMedia({
    this.id,
    this.offerId,
    this.file,
    this.storageName,
  });

  int? id;
  int? offerId;
  String? file;
  String? storageName;

  factory OfferMedia.fromJson(Map<String, dynamic> json) => OfferMedia(
        id: json["id"],
        offerId: json["offer_id"],
        file: json["file"],
        storageName: json["storage_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "offer_id": offerId,
        "file": file,
        "storage_name": storageName,
      };
}
