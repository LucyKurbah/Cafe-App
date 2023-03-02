import 'package:cafe_app/controllers/login_controller.dart';
import 'package:cafe_app/services/api_response.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cafe_app/constraints/constants.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';
import '../services/user_service.dart';
import 'package:get/get.dart';
import 'register.dart';
import 'package:cafe_app/widgets/custom_widgets.dart';
import 'package:cafe_app/controllers/login_controller.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  LoginController loginController = Get.put(LoginController());
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // buildLogin(context),
      resizeToAvoidBottomInset: false,
      body:
       Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(begin: Alignment.topCenter, colors: [
          Colors.black,
          // Colors.black,
          Colors.grey
        ])),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 150,
            ),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Login",
                    style: TextStyle(color: Colors.white, fontSize: 40),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
            Expanded(
                child: Form(
              key: formKey,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(60),
                        topRight: Radius.circular(60))),
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 60,
                      ),
                      Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey,
                                  blurRadius: 20,
                                  offset: Offset(0, 10))
                            ]),
                        child: Column(
                          children: [
                            Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom:
                                            BorderSide(color: Colors.grey))),
                                child: TextFormField(
                                  keyboardType: TextInputType.emailAddress,
                                  controller: loginController.txtEmail,
                                  style: TextStyle(fontSize: 18.0),
                                  validator: (value) => value!.isEmpty
                                      ? 'Invalid Email Address'
                                      : null,
                                  decoration: InputDecoration(
                                      hintText: "Email",
                                      hintStyle: TextStyle(color: Colors.grey),
                                      border: InputBorder.none),
                                )),
                            Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(color: Colors.grey))),
                              child: TextFormField(
                                obscureText: true,
                                controller: loginController.txtPassword,
                                style: TextStyle(fontSize: 18.0),
                                validator: (value) => value!.length < 6
                                    ? 'Required at least 6 characters'
                                    : null,
                                decoration: InputDecoration(
                                    hintText: "Password",
                                    hintStyle: TextStyle(color: Colors.grey),
                                    border: InputBorder.none),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      kLoginRegisterHint('Dont have an account? ', 'Register',
                          () {
                       
                        Get.to(Register(), transition: Transition.rightToLeftWithFade);
                      }),
                      SizedBox(
                        height: 40,
                      ),
                      Container(
                        height: 50,
                        margin: EdgeInsets.symmetric(horizontal: 50),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Colors.grey[700],
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 3,
                                blurRadius: 7,
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ]),
                        child: Center(
                          child: TextButton(
                              child: Text(
                                'Login',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  setState(() {
                                    loading = true;
                                    loginController.loginUser();
                                     
                                  });
                                }
                              }),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Center(
                        child: Text("Or"),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Center(
                        child: buildLoginButton(),
                      )
                    ],
                  ),
                ),
              ),
            ))
          ],
        ),
      ),
    );
  }

  // Form buildLogin(BuildContext context) {
  //   return Form(
  //       key: formKey,
  //       child: ListView(
  //         padding: EdgeInsets.all((30)),
  //         children: [
  //           TextFormField(
  //             keyboardType: TextInputType.emailAddress,
  //             controller: loginController.txtEmail,
  //             validator: (value) =>
  //                 value!.isEmpty ? 'Invalid Email Address' : null,
  //             decoration: kInputDecoration('Email'),
  //           ),
  //           SizedBox(height: 10),
  //           TextFormField(
  //             obscureText: true,
  //             controller: loginController.txtPassword,
  //             validator: (value) =>
  //                 value!.length < 6 ? 'Required at least 6 characters' : null,
  //             decoration: kInputDecoration('Password'),
  //           ),
  //           SizedBox(height: 10),
  //           loading
  //               ? Center(
  //                   child: CircularProgressIndicator(),
  //                 )
  //               : kTextButton('Login', () {
  //                   if (formKey.currentState!.validate()) {
  //                     setState(() {
  //                       loading = true;
  //                       loginController.loginUser();
  //                     });
  //                   }
  //                 }),
  //           SizedBox(
  //             height: 5,
  //           ),
  //           kLoginRegisterHint('Dont have an account? ', 'Register', () {
  //             Navigator.of(context).pushAndRemoveUntil(
  //                 MaterialPageRoute(builder: (context) => Register()),
  //                 (route) => false);
  //           }),
  //           SizedBox(
  //             height: 20,
  //           ),
  //           Center(
  //             child: Text("Or"),
  //           ),
  //           SizedBox(
  //             height: 10,
  //           ),
  //           Center(
  //             child: buildLoginButton(),
  //           )
  //         ],
  //       ));
  // }

  FloatingActionButton buildLoginButton() {
    return FloatingActionButton.extended(
      onPressed: loginController.loginUser,
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
}
