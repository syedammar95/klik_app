class TrackOrderModel {
  bool? success;
  Order? order;

  TrackOrderModel({this.success, this.order});

  TrackOrderModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    order = json['order'] != null ? Order.fromJson(json['order']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (order != null) {
      data['order'] = order!.toJson();
    }
    return data;
  }
}

class Order {
  String? orderId;
  int? productId;
  int? quantity;
  String? firstName;
  String? lastName;
  String? email;
  String? phone;
  String? address;
  String? city;
  String? state;
  String? orderStatus;
  String? orderDate;
  String? productName;

  Order(
      {this.orderId,
      this.productId,
      this.quantity,
      this.firstName,
      this.lastName,
      this.email,
      this.phone,
      this.address,
      this.city,
      this.state,
      this.orderStatus,
      this.orderDate,
      this.productName});

  Order.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    productId = json['product_id'];
    quantity = json['quantity'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    phone = json['phone'];
    address = json['address'];
    city = json['city'];
    state = json['state'];
    orderStatus = json['order_status'];
    orderDate = json['order_date'];
    productName = json['product_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['order_id'] = orderId;
    data['product_id'] = productId;
    data['quantity'] = quantity;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['email'] = email;
    data['phone'] = phone;
    data['address'] = address;
    data['city'] = city;
    data['state'] = state;
    data['order_status'] = orderStatus;
    data['order_date'] = orderDate;
    data['product_name'] = productName;
    return data;
  }
}
