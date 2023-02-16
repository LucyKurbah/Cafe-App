import 'package:get/get.dart';

import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginController extends GetxController{
  static final _googleSignIn = GoogleSignIn(); 

  static Future<GoogleSignInAccount?> login() => _googleSignIn.signIn();
}