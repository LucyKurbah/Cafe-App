import 'package:cafe_app/services/api_response.dart';
import 'package:flutter/material.dart';
import 'package:cafe_app/services/orders_service.dart';
import 'package:cafe_app/models/Orders.dart';
import 'package:get/get.dart';

import '../api/apiFile.dart';
import '../services/user_service.dart';

class MyOrders extends StatefulWidget {
  const MyOrders({super.key});

  @override
  State<MyOrders> createState() => _MyOrdersState();
}
class _MyOrdersState extends State<MyOrders> {
 List<dynamic> _orderList = [].obs;
  bool _isLoading = true; // flag to track loading state

  @override
  void initState() {
    super.initState();
    _loadOrders(); // load orders when the widget is initialized
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // set background color to black
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('My Orders'),
      ),
      body: _isLoading // show loading spinner if data is loading
          ? Center(child: CircularProgressIndicator(color:Colors.white),)
          : ListView.builder(
              itemCount: _orderList.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text('Order #${_orderList[index].id}'),
                  subtitle: Text('Total: ${_orderList[index].total}'),
                );
              },
            ),
    );
  }

  Future<void> _loadOrders() async{
    ApiResponse response  = await getOrders(); // call order service to get orders
    if(response.error == null)
    {
       setState(() {
        _orderList = response.data as List<dynamic>;
        _isLoading = false;
      });
    }
    else{
      print(response.error);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("${response.error}")));
    }
   
  }
}