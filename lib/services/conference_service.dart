import 'dart:convert';

import 'package:cafe_app/services/table_service.dart';
import 'package:cafe_app/services/user_service.dart';
import 'package:http/http.dart' as http;
import '../api/apiFile.dart';
import '../models/Order.dart';
import '../models/Conference.dart';
import 'api_response.dart';


Future<ApiResponse> getConference() async{
  
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
  
    final response = await http.post(Uri.parse(ApiConstants.getConferenceDetailsUrl),
                headers: {
                    'Accept' : 'application/json',
                    'Authorization' : 'Bearer $token'
                },
               );
              
    switch(response.statusCode)
    {
      case 200:
        apiResponse.data =  jsonDecode(response.body).map((p) => Conference.fromJson(p)).toList();
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



Future<ApiResponse> checkConferenceHallDetails(id, time_from, time_to, date) async{
  
  ApiResponse apiResponse = ApiResponse();
  try {
   
    String token = await getToken();
    int userId = await getUserId();
    String formattedDate=convertDateToPostgres(date);
    String timeFrom=convertTimeToPostgres(time_from,date);
     String timeTo=convertTimeToPostgres(time_to,date);
    print(userId);
    print(id);
    print(timeFrom);
    print(timeTo);
    print(formattedDate.toString());
    final response = await http.post(Uri.parse(ApiConstants.checkConferenceDetailsUrl),
                headers: {
                    'Accept' : 'application/json',
                    'Authorization' : 'Bearer $token'
                },
                body: {
                      'userId': userId.toString(),
                      'conference_id' : id,
                      'conference_time_from' : timeFrom,
                      'conference_time_to' : timeTo,
                      'conference_date' : formattedDate.toString()
                    },
               );
    print(response.statusCode);
    switch(response.statusCode)
    {
      case 200:
      print("Hello");
        apiResponse.data =  jsonDecode(response.body).map((p) => OrderModel.fromJson(p)).toList();
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
