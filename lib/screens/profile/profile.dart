import 'package:cafe_app/components/size_config.dart';
import 'package:cafe_app/widgets/top_custom_shape.dart';
import 'package:cafe_app/widgets/user_section.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../components/profile_skelton.dart';

import '../../services/api_response.dart';
import '../../services/orders_service.dart';
import '../../widgets/custom_widgets.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  List<dynamic> _profileInfo = [].obs;
  bool _isLoading = true; 

  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 10),(){
        setState(() {
          _isLoading = true;
          _loadProfile(); 
        });
    });
    super.initState();
    // load orders when the widget is initialized
  }

  Future<void> _loadProfile() async{
    ApiResponse response  = await getOrders(); // call order service to get orders
    if(response.error == null)
    {
       setState(() {
        _profileInfo = response.data as List<dynamic>;
        _isLoading = false;
      });
    }
    else{
       setState(() {
        _isLoading = true;
        showSnackBar(title: '${response.error}', message: '');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.black,
        title: Text("My Profile",style: TextStyle(color: Colors.white),),
        leading: IconButton(
            onPressed: (){
              Navigator.of(context).pop();
            }, 
            icon: Icon(Icons.arrow_back), color: Colors.white,)
            
      ),
      body:
            _isLoading // show loading spinner if data is loading
                  ?
                  
                  ListView.separated(
                      itemCount: 1,
                      itemBuilder: (context, index) => const ProfileSkelton(),
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 20),
                    )
                  : 
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TopCustomShape(),
                    SizedBox(height: 20,),//SizeConfig.screenHeight!/34.15,),                              /// 20.0
                    UserSection(icon_name: Icons.account_circle, section_text: "My information"),
                    UserSection(icon_name: Icons.credit_card, section_text: "Credit Card"),
                    UserSection(icon_name: Icons.shopping_basket, section_text: "Past orders"),
                    UserSection(icon_name: Icons.location_city, section_text: "Address information"),
                    UserSection(icon_name: Icons.wallet_giftcard, section_text: "Coupons"),
                  ],
                ),
    );
  }
}