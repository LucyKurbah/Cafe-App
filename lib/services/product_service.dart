
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../api/apiFile.dart';
import '../models/Product.dart';
import 'api_response.dart';

Future<ApiResponse> getProducts() async{
  
  ApiResponse apiResponse = ApiResponse();
  try {
        final response = await http.post(Uri.parse(ApiConstants.itemUrl),headers: {'Accept' : 'application/json',});
        switch(response.statusCode)
        {
          case 200:
           print(response.body);
            apiResponse.data =  jsonDecode(response.body).map((p) => Product.fromJson(p)).toList();
           
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

