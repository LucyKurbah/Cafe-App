
import 'dart:convert';

import 'package:cafe_app/services/user_service.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import '../api/apiFile.dart';
import '../models/Table.dart';
import '../models/Order.dart';
import 'api_response.dart';


Future<ApiResponse> getTables() async{
  
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http.post(Uri.parse(ApiConstants.tableUrl),
                headers: {
                    'Accept' : 'application/json',
                    'Authorization' : 'Bearer $token'
                },
               );
  
    switch(response.statusCode)
    {
      case 200:
      print(response.body);
        apiResponse.data =  jsonDecode(response.body).map((p) => TableModel.fromJson(p)).toList();
        print(apiResponse.data);
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
  convertDateToPostgres(bookDate){
    DateTime date = DateFormat('dd-MM-yyyy').parse(bookDate);
    String formattedDate = '${date.year.toString()}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
    return formattedDate;
  }
Future<ApiResponse> getTableDetails(table_id, timeFrom, timeTo, bookDate) async{
  
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    int userId = await getUserId();
    String formattedDate=convertDateToPostgres(bookDate);
  
    final response = await http.post(Uri.parse(ApiConstants.getTableDetailsUrl),
                headers: {
                    'Accept' : 'application/json',
                    'Authorization' : 'Bearer $token'
                },
                body: {
                      'userId': userId.toString(),
                      'table_id': table_id.toString(),
                      'timeFrom' : timeFrom,
                      'timeTo' : timeTo,
                      'bookDate' : formattedDate.toString()
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

