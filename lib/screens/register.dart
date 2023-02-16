import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constraints/constants.dart';
import '../models/user_model.dart';
import '../services/api_response.dart';
import '../services/user_service.dart';
import 'home.dart';
import 'login.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool loading = false;

  TextEditingController  nameController = TextEditingController(),
                        emailController = TextEditingController(),
                        passwordController = TextEditingController(),
                        passwordConfirmController = TextEditingController();
  
  void _registerUser() async{
    
    ApiResponse response = await register(nameController.text, emailController.text, passwordController.text);
     
    if(response.error == null){
      _saveAndRedirectToHome(response.data as UserModel);
    }
    else{
      setState(() {
        loading = !loading;
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
        title: Text('Register'),
        centerTitle: true,
      ),
      body: Form(
        key: formKey,
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 32, vertical: 32),
          children: [
            TextFormField(
              controller: nameController,
              validator: (value) => value!.isEmpty ? 'Invalid Name' : null,
              decoration: kInputDecoration('Name'),
            ),
            SizedBox(height: 10),
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              controller: emailController,
              validator: (value) => value!.isEmpty ? 'Invalid Email Address' : null,
              decoration: kInputDecoration('Email'),
            ),
            SizedBox(height: 10),
            TextFormField(
            obscureText: true,
              controller: passwordController,
              validator: (value) => value!.length < 6 ? 'Required at least 6 characters' : null,
              decoration: kInputDecoration('Password'),
            ),
            SizedBox(height: 10),
            TextFormField(
            obscureText: true,
              controller: passwordConfirmController,
              validator: (value) => value!= passwordController.text  ? 'Confirm password does not match' : null,
              decoration: kInputDecoration('Confirm Password'),
            ),
            SizedBox(height: 10),
            loading? Center(child: CircularProgressIndicator(),):
            kTextButton('Register', (){
                 if(formKey.currentState!.validate()){
                    setState(() {
                      loading = !loading;
                      _registerUser();
                    });
                }
            }),
            SizedBox(height: 10,),
            kLoginRegisterHint('Already have an account? ','Login',(){
              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>Login()), (route) => false);
            })
          ],
        )),
    );
  }
}