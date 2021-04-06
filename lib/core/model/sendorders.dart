class SendOrders{
  final List<SendOrder> senOrders;

  SendOrders(this.senOrders);
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['oderItems'] = senOrders != null ?
    this.senOrders.map((v) => v.toJson()).toList()
        : null;
    return data;
  }
}

class SendOrder{
  final int product_id;
  final double product_quantity;

  SendOrder(this.product_id, this.product_quantity);
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_id'] = product_id;
    data['quantity'] = product_quantity;
    return data;
  }

}