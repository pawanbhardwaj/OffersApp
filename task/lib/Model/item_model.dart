class Items {
  int? id;
  String? name;
  String? imageUrl;
  String? price;
  Items(this.id, this.name, this.imageUrl, this.price);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'name': name,
      'imageUrl': imageUrl,
      'price': price
    };
    return map;
  }

  Items.fromMap(Map<dynamic, dynamic> map) {
    id = map['id'];
    name = map['name'];
    imageUrl = map['imageUrl'];
    price = map['price'];
  }
}
