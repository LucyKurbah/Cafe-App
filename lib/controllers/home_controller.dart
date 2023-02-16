
import 'package:cafe_app/models/Product.dart';
import 'package:cafe_app/models/ProductItem.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


enum HomeState { normal, cart }

class HomeController extends ChangeNotifier {

  HomeState homeState = HomeState.normal;

  int _counter = 0;

  int get counter => _counter;

  double _totalPrice = 0.0;

  double get totalPrice => _totalPrice;

  List<ProductItem> cart = [];

  void changeHomeState(HomeState state) {
    homeState = state;
    notifyListeners();
  }

  void addProductToCart(Product product) {
   
    for (ProductItem item in cart) {
      if (item.product.title == product.title) {
        item.increment();
    
        notifyListeners();
        return;
      }
    }
    // print(product);
    cart.add(ProductItem(product: product));
    notifyListeners();
  }

  int totalCartItems() => cart.fold(
      0, (previousValue, element) => previousValue + element.quantity);

  void _setPrefItems() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('cart_item', _counter);
    prefs.setDouble('total_price', _totalPrice);
    notifyListeners();
  }

  void _getPrefItems() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _counter = prefs.getInt('cart_item') ?? 0;
    _totalPrice = prefs.getDouble('total_price') ?? 0.0;
    notifyListeners();
  }

  void addCounter(){
    _counter++;
    _setPrefItems();
    notifyListeners();
  }

  void removeCounter(){
    _counter--;
    _setPrefItems();
    notifyListeners();
  }

  int getCounter(){
    _getPrefItems();
    return _counter;
  }

  void addTotalPrice(double productPrice){
    _totalPrice = _totalPrice+ productPrice;
    _setPrefItems();
    notifyListeners();
  }

  void removeTotalPrice(double productPrice){
     _totalPrice = _totalPrice - productPrice;
    _setPrefItems();
    notifyListeners();
  }

  double getTotalPrice(){
    _getPrefItems();
    return _totalPrice;
  }



}
