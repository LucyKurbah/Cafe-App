
import 'dart:convert';

import 'package:cafe_app/services/table_service.dart';
import 'package:cafe_app/services/user_service.dart';
import 'package:http/http.dart' as http;
import '../api/apiFile.dart';
import '../models/Order.dart';
import 'api_response.dart';


Future<ApiResponse> getConferenceHallDetails(date, timeFrom, timeTo) async{
  
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    int userId = await getUserId();
    String formattedDate=convertDateToPostgres(date);
  
    final response = await http.post(Uri.parse(ApiConstants.getConferenceDetailsUrl),
                headers: {
                    'Accept' : 'application/json',
                    'Authorization' : 'Bearer $token'
                },
                body: {
                      'userId': userId.toString(),
                      'timeFrom' : timeFrom,
                      'timeTo' : timeTo,
                      'date' : formattedDate.toString()
                    },
               );
              
    switch(response.statusCode)
    {
      case 200:
        apiResponse.data =  jsonDecode(response.body).map((p) => OrderModel.fromJson(p)).toList();
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

