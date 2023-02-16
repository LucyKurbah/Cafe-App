import 'package:cafe_app/controllers/login_controller.dart';
import 'package:cafe_app/services/api_response.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cafe_app/constraints/constants.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';
import '../services/user_service.dart';
import 'package:get/get.dart';
import 'home.dart';
import 'register.dart';

class Login extends StatefulWidget {
 
  const Login({super.key});
  
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController  txtEmail = TextEditingController();
  TextEditingController  txtPassword = TextEditingController();

   final controller = Get.put(LoginController());
  bool loading = false;

  void _loginUser() async{
    
    ApiResponse response = await login(txtEmail.text, txtPassword.text);
     
    if(response.error == null){
      _saveAndRedirectToHome(response.data as UserModel);
    }
    else{
      setState(() {
        loading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('${response.error}'),
      ));
    }
  }

  void _saveAndRedirectToHome(UserModel user) async
  {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString('token', user.token );
    await pref.setInt('userId', user.id );
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>Home()), (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('login'),
        centerTitle: true,
      ),
      body: Form(
        key: formKey,
        child: ListView(
          padding: EdgeInsets.all((30)),
          children: [
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              controller: txtEmail,
              validator: (value) => value!.isEmpty ? 'Invalid Email Address' : null,
              decoration: kInputDecoration('Email'),
            ),
            SizedBox(height: 10),
            TextFormField(
            obscureText: true,
              controller: txtPassword,
              validator: (value) => value!.length < 6 ? 'Required at least 6 characters' : null,
              decoration: kInputDecoration('Password'),
            ),
            SizedBox(height: 10),
            loading? Center(child: CircularProgressIndicator(),):
            kTextButton('Login', (){
                 if(formKey.currentState!.validate()){
                    setState(() {
                      loading = true;
                      _loginUser();
                    });
                }
            }),
            SizedBox(height: 5,),
            kLoginRegisterHint('Dont have an account? ','Register',(){
              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>Register()), (route) => false);
            }),
            SizedBox(height: 20,),
            Center(child: Text("Or"),),
             SizedBox(height: 10,),
            Center(
              child:  buildLoginButton(),
            )
          ],
        )),
    );
  }

  FloatingActionButton buildLoginButton() {
    return FloatingActionButton.extended(
              onPressed:signIn,
               
              label: Text("Sign in with Google"),
              foregroundColor: Colors.black,
              backgroundColor: Colors.white,
              icon: Image.asset(
                'Assets/Images/google_logo.png',
                height: 32,
                width: 32,
              ),
            );
  }

  Future signIn() async{
    await LoginController.login();
  }
}




