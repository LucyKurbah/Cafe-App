import 'package:cafe_app/services/api_response.dart';
import 'package:cafe_app/services/user_service.dart';
import 'package:flutter/material.dart';
import '../api/apiFile.dart';
import 'home.dart';
import 'login.dart';

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {

void _loadUserInfo() async{
  String token = await getToken();
  if(token == '')
  {
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>Login()), (route) => false);
    // print('Hello world');
  }
  else{
    ApiResponse response = await getUserDetails();
    if(response.error == null)
    {
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>      Home()), (route) => false);
    }
    else if(response.error == ApiConstants.unauthorized)
    {
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>      Login()), (route) => false);
    }
    else
    {
     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('$response.error')
      ));
    }
  }
}

  @override
  void initState() {
    // TODO: implement initState
    _loadUserInfo();
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}