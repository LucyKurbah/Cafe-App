import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cafe_app/services/api_response.dart';
import '../services/user_service.dart';
import '../models/user_model.dart';
import 'package:cafe_app/widgets/custom_widgets.dart';
import '../screens/home/home.dart';

class RegisterController extends GetxController{

   TextEditingController  nameController = TextEditingController(),
                        emailController = TextEditingController(),
                        passwordController = TextEditingController(),
                        passwordConfirmController = TextEditingController();
  
  final Future<SharedPreferences> pref = SharedPreferences.getInstance();

  void registerUser() async{
    
    ApiResponse response = await register(nameController.text, emailController.text, passwordController.text);
     
    if(response.error == null){
      _saveAndRedirectToHome(response.data as UserModel);
    }
    else{
      // setState(() {
      //   loading = !loading;
      // });
     showSnackBar(title: 'Error', message: '${response.error}');
    }
  }

  void _saveAndRedirectToHome(UserModel user) async
  {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString('token', user.token );
    await pref.setInt('userId', user.id );
    nameController.clear();
    emailController.clear();
    passwordController.clear();
       Get.off(Home());
    // Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>Home()), (route) => false);
  }

}