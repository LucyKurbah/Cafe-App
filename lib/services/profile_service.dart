import 'dart:convert';
import 'package:cafe_app/models/Orders.dart';
import 'package:cafe_app/services/user_service.dart';
import 'package:http/http.dart' as http;
import '../api/apiFile.dart';
import '../models/ProfileModel.dart';
import '../screens/profile/profile.dart';
import 'api_response.dart';

Future<ApiResponse> getProfile() async{
  ApiResponse apiResponse = ApiResponse();
  String token = await getToken();
  int userId = await getUserId();
  try {
    final response = await http.post(Uri.parse(ApiConstants.getProfileUrl),
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
        if(response.body =='305'){
          apiResponse.data = '';
        }
        else if(response.body == 'X'){
  
          apiResponse.error = ApiConstants.notLoggedIn;
        }
        else{
          print(response.body);
            apiResponse.data =  jsonDecode(response.body).map((p) => ProfileModel.fromJson(p)).toList();
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