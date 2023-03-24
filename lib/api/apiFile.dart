class ApiConstants {
  static String aws_ip= "13.231.134.208";
  static String office_ip="10.179.2.187:8000";
  static String home_ip="";

  static String right_now_ip=aws_ip;

  static String baseUrl = 'http://'+right_now_ip+'/api';
  static String ipUrl = 'http://10.179.2.187';
  static String loginUrl = '$baseUrl/login';
  static String registerUrl = '$baseUrl/register';
  static String forgotPasswordUrl = '$baseUrl/forgotPassword';
  static String logoutUrl = '$baseUrl/logout';
  static String userUrl = '$baseUrl/user';
  static String itemUrl = '$baseUrl/getFoodItems';
  static String getAddOnUrl = '$baseUrl/getAddOnItems';
  static String tableUrl = '$baseUrl/getTables';
  static String getTableDetailsUrl = '$baseUrl/order/getTableOrderDetails';
  static String getConferenceDetailsUrl = '$baseUrl/getConferenceDetails';
  static String cartUrl = '$baseUrl/cart/getCart';
  static String addCartUrl = '$baseUrl/cart/add';
  static String removeCartUrl = '$baseUrl/cart/remove';
  static String getTotalUrl = '$baseUrl/cart/getTotal';
  static String imagePath = "http://"+right_now_ip+"/";
  static String imageUrl = "$baseUrl/$imagePath";
  static String serverError = 'Servor Error';
  static String unauthorized = 'Unauthorized';
  static String somethingWentWrong = 'Something went wrong';
}