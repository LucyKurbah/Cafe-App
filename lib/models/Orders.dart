class Order {

  int id, user_id,  item_id, quantity; 
  double item_price;
  String image, item_name;

  Order({required this.item_name, required this.id, required this.user_id, required this.item_id, required this.quantity, required this.item_price,
  required this.image});

  factory Order.fromJson(Map<String, dynamic> json) {
    print(json);
    return Order(
      item_name :  json['item_name'],
      id: json['id'],
      image: json['image'],
      item_id: json['item_id'], 
      item_price: json['item_price'], 
      quantity: json['quantity'], 
      user_id: json['user_id'],
    );
  }

  Map<String, dynamic> toJson() => {
      'item_name' : item_name,
      'id': id,
      'image': image,        
      'item_id': item_id,
      'item_price': item_price, 
      'quantity': quantity, 
      'user_id': user_id,
  };
}