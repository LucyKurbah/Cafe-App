class ApiConstants {
  //ip= "10.179.2.187"
  static String baseUrl = 'http://10.179.2.187:8000/api';
  static String ipUrl = 'http://10.179.2.187:8000';
  static String loginUrl = '$baseUrl/login';
  static String registerUrl = '$baseUrl/register';
  static String logoutUrl = '$baseUrl/logout';
  static String userUrl = '$baseUrl/user';
  static String itemUrl = '$baseUrl/getItems';
  static String tableUrl = '$baseUrl/getTables';
  static String getTableDetailsUrl = '$baseUrl/getTableDetails';
  static String cartUrl = '$baseUrl/cart/getCart';
  static String addCartUrl = '$baseUrl/cart/add';
  static String removeCartUrl = '$baseUrl/cart/remove';
  static String getTotalUrl = '$baseUrl/cart/getTotal';


  static String imagePath = "http://10.179.2.187:8000";
  static String imageUrl = "$baseUrl/$imagePath";

  static String serverError = 'Servor Error';
  static String unauthorized = 'Unauthorized';
  static String somethingWentWrong = 'Something went wrong';
}