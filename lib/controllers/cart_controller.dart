


//Not USED . Instear CARD_SERVICE.DART is used

import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../api/apiFile.dart';
import '../models/Product.dart';
import '../services/api_response.dart';
import '../services/product_service.dart';
import '../services/user_service.dart';

class CartController extends GetxController{

  CartController()
  {
    print("CartController");
    getCart();
  }

 
Future<ApiResponse> getCart() async{
  
  
  ApiResponse apiResponse = ApiResponse();
  print("Text");
  // try {
  //   String token = await getToken();
  //   int userId = await getUserId();

  //   final response = await http.post(Uri.parse(ApiConstants.cartUrl),
  //               headers: {
  //                   'Accept' : 'application/json',
  //                   'Authorization' : 'Bearer $token'
  //               },
  //               // body:{
  //               //        'user_id': userId,
  //               //     },   
  //              );
  //   print(response.body.toString());
  //   print("Result");
  //   switch(response.statusCode)
  //   {
  //     case 200:
  //       apiResponse.data =  jsonDecode(response.body).map((p) => Product.fromJson(p)).toList();
  //       break;
  //     case 401:
  //       apiResponse.error = ApiConstants.unauthorized;
  //       break;
  //     default:
  //        apiResponse.error = response.statusCode.toString();
  //       break;
  //   }
  // } catch (e) {
  //    apiResponse.error =e.toString();
  // }

    return apiResponse;
}

 
}