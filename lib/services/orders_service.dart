import 'dart:convert';

import 'package:cafe_app/models/Orders.dart';
import 'package:cafe_app/services/user_service.dart';
import 'package:http/http.dart' as http;
import '../api/apiFile.dart';
import 'api_response.dart'; // replace with the name of your order model

// class OrderService {
//   static Future<List<Order>> getOrders() async {
//     // Here you can make a network request to your server to fetch orders
//     // For the sake of simplicity, let's return some mock data
//     return [
//       Order(id: 1, total: 20.0),
//       Order(id: 2, total: 15.0),
//       Order(id: 3, total: 10.0),
//     ];
//   }

  
Future<ApiResponse> getOrders() async{
  ApiResponse apiResponse = ApiResponse();

 try {
    String token = await getToken();
    int userId = await getUserId();
  
    final response = await http.post(Uri.parse(ApiConstants.getOrdersUrl),
                headers: {
                    'Accept' : 'application/json',
                    'Authorization' : 'Bearer $token'
                },
                body:{
                       'user_id': userId.toString(),
                    },   
               );

    switch(response.statusCode)
    {
      case 200:
           print(response.statusCode);
        if(response.body =='305'){
          apiResponse.data = '';
        }
        else{
          print(response.body);
          apiResponse.data =  jsonDecode(response.body).map((p) => Order.fromJson(p)).toList();
        } 
        break;
      case 401:
        apiResponse.error = ApiConstants.unauthorized;
        break;
      default:
         apiResponse.error = response.statusCode.toString();
        break;
    }
  } catch (e) {
     apiResponse.error =e.toString();
  }
  return apiResponse;
}
