class Products{
	final String result_code;
	final List<Product> products;

	Products.fromJsonMap(Map<String, dynamic> map):
				result_code = map["result_code"],
				products = List<Product>.from(map["products"].map((it) => Product.fromJsonMap(it)));

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['sonuc_kodu'] = result_code;
		data['products'] = products != null ?
		this.products.map((v) => v.toJson()).toList()
				: null;
		return data;
	}
}

class Product {

  final int id;
  final List<String> images;
  final String title;
  final double price;

	Product.fromJsonMap(Map<String, dynamic> map):
		id = map["id"],
		images = List<String>.from(map["images"]),
		title = map["title"],
		price = map["price"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['id'] = id;
		data['images'] = images;
		data['title'] = title;
		data['price'] = price;
		return data;
	}
}
