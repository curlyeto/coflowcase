import 'package:coflowcase/core/model/order.dart';

class OrderList {

	final String result_code;
	final List<Orders> orders;

	OrderList.fromJsonMap(Map<String, dynamic> map):
				result_code = map["result_code"],
				orders = List<Orders>.from(map["orders"].map((it) => Orders.fromJsonMap(it)));

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['result_code'] = result_code;
		data['baskets'] = orders != null ?
		this.orders.map((v) => v.toJson()).toList()
				: null;
		return data;
	}
}

class Orders {
	final int id;
	final List<String> product_images;
	final String order_date;
	final double order_quantity;
	final int order_count;
	final List<Order> order_products;

	Orders.fromJsonMap(Map<String, dynamic> map):
				id = map["id"],
				product_images = List<String>.from(map["product_images"]),
				order_date = map["order_date"],
				order_quantity = map["order_quantity"],
				order_count = map["order_count"],
				order_products = List<Order>.from(map["order_products"].map((it) => Order.fromJsonMap(it)));

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['id'] = id;
		data['product_images'] = product_images;
		data['order_date'] = order_date;
		data['order_quantity'] = order_quantity;
		data['order_count'] = order_count;
		data['baskets'] = order_products != null ?
		this.order_products.map((v) => v.toJson()).toList()
				: null;
		return data;
	}
}

