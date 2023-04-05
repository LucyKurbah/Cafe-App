import 'package:cafe_app/models/Table.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../api/apiFile.dart';
import '../models/AddOn.dart';
import '../models/Product.dart';
import '../models/Cart.dart';
import 'api_response.dart';
import 'user_service.dart';


Future<ApiResponse> getCart() async{
  ApiResponse apiResponse = ApiResponse();

 try {
    String token = await getToken();
    int userId = await getUserId();
    final response = await http.post(Uri.parse(ApiConstants.cartUrl),
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
          apiResponse.data = '';//User not logged in
        }
        else{
          apiResponse.data =  jsonDecode(response.body).map((p) => Cart.fromJson(p)).toList();
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


Future<ApiResponse> addToCart(Product product) async{
    ApiResponse apiResponse = ApiResponse();
    String token = await getToken();
    int userId = await getUserId();
    if(userId==0 || userId == null)
    {
       apiResponse.error ="Please log in first";
    } 
    else
    {
        try {
        
          final response = await http.post(Uri.parse(ApiConstants.addCartUrl),
                      headers: {
                          'Accept' : 'application/json',
                          'Authorization' : 'Bearer $token'
                      },
                      body:{
                              'user_id': userId.toString(),
                              'food_id' : product.id.toString(),
                              'food_price' : product.price.toString(),
                              'food_quantity' : "1",
                              'flag' : 'F'
                          },   
                    );
          switch(response.statusCode)
          {
            case 200:
              apiResponse.data =  "Added to cart";
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
    }
  return apiResponse;
}

Future<ApiResponse> addItemToCart(AddOn item) async{
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    int userId = await getUserId();
  
    final response = await http.post(Uri.parse(ApiConstants.addCartUrl),
                headers: {
                    'Accept' : 'application/json',
                    'Authorization' : 'Bearer $token'
                },
                body:{
                        'user_id': userId.toString(),
                       
                        'item_id' : item.id.toString(),
                        'item_price' : item.price.toString(),
                        'item_quantity' : "1",
                        'flag' : 'I'
                    },   
               );
    switch(response.statusCode)
    {
      case 200:
        apiResponse.data =  "Added to cart";
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

Future<ApiResponse> removeItemFromCart(AddOn item) async{
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    int userId = await getUserId();
  
    final response = await http.post(Uri.parse(ApiConstants.removeCartUrl),
                headers: {
                    'Accept' : 'application/json',
                    'Authorization' : 'Bearer $token'
                },
                body:{
                        'user_id': userId.toString(),
                        'item_id' : item.id.toString(),
                        'item_quantity' : "1",
                        'flag' : 'I'
                    },   
               );
    switch(response.statusCode)
    {
      case 200:
        apiResponse.data =  "Removed From cart";
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

Future<ApiResponse> addTableToCart(TableModel table, String totalPrice, String date, String timeFrom, String timeTo) async{
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    int userId = await getUserId();
   
    final response = await http.post(Uri.parse(ApiConstants.addCartUrl),
                headers: {
                    'Accept' : 'application/json',
                    'Authorization' : 'Bearer $token'
                },
                body:{
                        'user_id': userId.toString(),
                        'table_id' : table.id.toString(),
                        'table_price' : (totalPrice),
                        'table_date' : date,
                        'table_time_from' : timeFrom,
                        'table_time_to' : timeTo,
                        'flag': 'T'
                    },   
               );
    print(response.statusCode);
    switch(response.statusCode)
    {
      case 200:
       apiResponse.data =  jsonDecode(response.body);
        // apiResponse.data =  "Added to cart";
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

Future<ApiResponse> addConferenceToCart(String totalPrice, String date, String timeFrom, String timeTo) async{
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    int userId = await getUserId();
   
    final response = await http.post(Uri.parse(ApiConstants.addCartUrl),
                headers: {
                    'Accept' : 'application/json',
                    'Authorization' : 'Bearer $token'
                },
                body:{
                        'user_id': userId.toString(),
                        'table_price' : (totalPrice),
                        'table_date' : date,
                        'table_time_from' : timeFrom,
                        'table_time_to' : timeTo,
                        'flag': 'C'
                    },   
               );
    print(response.statusCode);
    switch(response.statusCode)
    {
      case 200:
       apiResponse.data =  jsonDecode(response.body);
        // apiResponse.data =  "Added to cart";
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

Future<ApiResponse> incrementCart(Cart cart) async{
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    int userId = await getUserId();
    String id='';
    if(cart.flag.toString()=='F')
    {
      id='food_id';
    }else if(cart.flag.toString()=='T')
    {
      id='table_id';
    }
    else
    {
      id='item_id';
    }
    final response = await http.post(Uri.parse(ApiConstants.addCartUrl),
                headers: {
                    'Accept' : 'application/json',
                    'Authorization' : 'Bearer $token'
                },
                body:{
                       'user_id': userId.toString(),
                        id : cart.item_id.toString(),
                        'item_price' : cart.item_price.toString(),
                        'quantity' : "1",
                        'flag': cart.flag.toString(),
                    },   
               );
    switch(response.statusCode)
    {
      case 200:
      apiResponse.data =  "Added to cart";
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

Future<ApiResponse> decrementCart(Cart cart) async{
  ApiResponse apiResponse = ApiResponse();
 try {
    String token = await getToken();
    int userId = await getUserId();
    String id='';
    if(cart.flag.toString()=='F')
    {
      id='food_id';
    }else if(cart.flag.toString()=='T')
    {
      id='table_id';
    }
    else
    {
      id='item_id';
    }

    final response = await http.post(Uri.parse(ApiConstants.removeCartUrl),
                headers: {
                    'Accept' : 'application/json',
                    'Authorization' : 'Bearer $token'
                },
                body:{
                        'user_id': userId.toString(),
                        id : cart.item_id.toString(),
                        'item_price' : cart.item_price.toString(),
                        'quantity' : "1",
                        'flag' : cart.flag
                        
                    },   
               );
    switch(response.statusCode)
    {
      case 200:
        apiResponse.data =  "Removed from cart";
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

Future<ApiResponse> getTotal() async{
  ApiResponse apiResponse = ApiResponse();
 try {
    String token = await getToken();
    int userId = await getUserId();

    final response = await http.post(Uri.parse(ApiConstants.getTotalUrl),
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
        apiResponse.data = (jsonDecode(response.body)) ;
        
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


Future<ApiResponse> saveOrder(_cartList, totalPrice) async{
  ApiResponse apiResponse = ApiResponse();
 try {
    String token = await getToken();
    int userId = await getUserId();

    final response = await http.post(Uri.parse(ApiConstants.saveOrder),
                headers: {
                    'Accept' : 'application/json',
                    'Authorization' : 'Bearer $token'
                },
                body:{
                        'user_id': userId.toString(),
                    },   
               );
    print(response.statusCode);
    switch(response.statusCode)
    {
      case 200:
        apiResponse.data = (jsonDecode(response.body)) ;
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

