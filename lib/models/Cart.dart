import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class Cart {
    
    int user_id,  item_id, quantity; 
    double item_price;
    String image, item_name;

  Cart({ required this.item_id, required this.user_id, required this.item_price, required this.quantity, required this.image, required this.item_name});

   @override
  String toString() {
    return 'Cart: {item_name: ${item_name}, item_id: ${item_id},item_price: ${item_price}, quantity: ${quantity}, user_id: ${user_id}, image: ${image},}';
  }

  factory Cart.fromJson(Map<String, dynamic> json){
    return Cart(
      item_id : json['food_id'],
      user_id : json['user_id'],
      item_price : double.parse(json['food_price']),
      quantity : json['food_quantity'],
      image : json['path_file'],
      item_name : json['food_name'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'item_id': item_id,
      'user_id' : user_id,
      'item_price' : item_price,
      'quantity' :quantity,
      'image' :image,
      'item_name' :item_name
    };
  }
}
