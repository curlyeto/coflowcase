class Order {

  final int id;
  final String image;
  final String title;
  final double price;

  Order.fromJsonMap(Map<String, dynamic> map):
        id = map["id"],
        image = map['image'],
        title = map["title"],
        price = map["price"];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['image'] = image;
    data['title'] = title;
    data['price'] = price;
    return data;
  }
}