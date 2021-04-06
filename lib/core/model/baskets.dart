import 'package:coflowcase/core/model/basket.dart';

class Baskets {

  final String result_code;
  final List<Basket> baskets;

	Baskets.fromJsonMap(Map<String, dynamic> map): 
		result_code = map["result_code"],
		baskets = List<Basket>.from(map["baskets"].map((it) => Basket.fromJsonMap(it)));

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['result_code'] = result_code;
		data['baskets'] = baskets != null ? 
			this.baskets.map((v) => v.toJson()).toList()
			: null;
		return data;
	}
}
