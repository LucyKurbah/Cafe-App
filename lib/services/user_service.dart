
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:cafe_app/services/api_response.dart';
import 'package:cafe_app/api/apiFile.dart';
import 'package:cafe_app/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';


Future<ApiResponse> login(String email, String password) async {
  
  ApiResponse apiResponse = ApiResponse();
  try {
    
   
    final response = await http.post(
            Uri.parse(ApiConstants.loginUrl),
            headers: {'Accept': 'application/json',
                      'Content-type': 'application/json'
                      },
            body: jsonEncode({"email": email, "password": password}),
    );
    print(response.statusCode);
    switch(response.statusCode)
    {
      case 200:
        print(response.body.toString());
        apiResponse.data =  UserModel.fromJson(jsonDecode(response.body));
       
        break;
      case 422:
        final errors = jsonDecode(response.body)['errors'];
        apiResponse.error = errors[errors.keys.elementAt(0)][0];
        break;
      case 403:
        apiResponse.error = jsonDecode(response.body)['message'];
        break;
      default:
         apiResponse.error = response.statusCode.toString();//ApiConstants.somethingWentWrong;
        break;
    }
  } catch (e) {
     apiResponse.error = e.toString();
  }

  return apiResponse;
}

Future<ApiResponse> register(String name, String email, String password) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    final response = await http.post(
      Uri.parse(ApiConstants.registerUrl),
      headers: {'Accept':'application/json'},
      body:{
        'name': name, 
        'email': email, 
        'password' : password,
        'password_confirmation' : password}
    );
      
    switch(response.statusCode)
    {
      case 200:
        apiResponse.data =  UserModel.fromJson(jsonDecode(response.body));
        break;
      case 422:
        final errors = jsonDecode(response.body)['errors'];
        apiResponse.error = errors[errors.keys.elementAt(0)][0];
        break;
      case 403:
        apiResponse.error = jsonDecode(response.body)['message'];
        break;
      default:
         apiResponse.error = ApiConstants.somethingWentWrong;
        break;
    }
  } catch (e) {
     apiResponse.error = ApiConstants.serverError;
  }

  return apiResponse;
}

Future<ApiResponse> getUserDetails() async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http.get(
      Uri.parse(ApiConstants.userUrl),
      headers: {
        'Accept':'application/json',
        'Authorization' : 'Bearer $token'
        });
      
    switch(response.statusCode)
    {
      case 200:
        apiResponse.data =  UserModel.fromJson(jsonDecode(response.body));
        break;
      case 401:
        apiResponse.error = ApiConstants.unauthorized;
        break;
      default:
         apiResponse.error = ApiConstants.somethingWentWrong;
        break;
    }
  } catch (e) {
     apiResponse.error = ApiConstants.serverError;
  }

  return apiResponse;
}

Future<String> getToken() async{
  SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.getString('') ?? '';
}

Future<int> getUserId() async{
  SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.getInt('userId') ?? 0;
}

Future<bool> logout() async{
  SharedPreferences pref = await SharedPreferences.getInstance();
  return await pref.remove('token');
}

String? getStringImage(File? file){
  if(file == null) return null;
  return base64Encode(file.readAsBytesSync());
}