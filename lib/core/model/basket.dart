
class Basket {

  final int id;
  final List<String> images;
  final String title;
  final double price;
  final int count;

  Basket.fromJsonMap(Map<String, dynamic> map):
        id = map["id"],
        images = List<String>.from(map["images"]),
        title = map["title"],
        price = map["price"],
        count = map["count"];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['images'] = images;
    data['title'] = title;
    data['price'] = price;
    return data;
  }
}
