import 'package:badges/badges.dart';
import 'package:cafe_app/screens/cartscreen.dart';
import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../services/api_response.dart';
import '../widgets/custom_widgets.dart';
import 'home_card.dart';
import 'cartscreen.dart';
import 'login.dart';
import 'settings.dart';
import 'profile.dart';
import 'dart:math';
import 'package:cafe_app/services/user_service.dart';
import 'package:get/get.dart';

 class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin{

  late TabController tabController;
  double value = 0;
  String username ='';
  bool isLoggedIn = false;


  @override
  void initState() {
    // TODO: implement initState
    tabController = TabController(length: 4, vsync: this);
    getUserDetail();
    super.initState();
  }


  void getUserDetail() async{
    
    ApiResponse response = await getUserDetails();
     
    if(response.error == null){
      UserModel user = response.data as UserModel;
      username = user.name;
      isLoggedIn = true;
    }
    else{
    //  showSnackBar(title: 'Error', message: '${response.error}');
      isLoggedIn = false;
      username ='';
    }
  }

  void login()
  {
     Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>Login()), (route) => false);
  }

  void logout()
  {
    logoutUser();
    getUserDetail();
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => Home()));
    showSnackBar(title: '', message: 'Logged Out');
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
           Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.grey,
                   Colors.black,
                  Colors.black
                ],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter
              )
            ),
           ),
           SafeArea(
            child: Container(
              width: 200.0,
              padding: EdgeInsets.all(8.0),
              child: Column(
                children: [
                  DrawerHeader(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 40.0,
                          backgroundColor: Colors.white,
                          child: Container(
                              child: Icon(
                                Icons.person,
                                size: 80,
                                color: Colors.grey,
                              ),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                              ),
                            ),
                            
                          // backgroundImage: Icon(Icons.person),
                        ),
                        SizedBox(height: 10.0,),
                        Text(username,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0
                            ),
                        ),
                      ],
                    )
                  ),
                  Expanded(
                      child: ListView(
                          children: [
                                ListTile(
                                  onTap: (){
                                    //  Navigator.of(context).push(MaterialPageRoute(builder: (context) =>Home()));
                                     Get.to(Home(), transition: Transition.rightToLeftWithFade);
                                  },
                                  leading: Icon(Icons.home, color: Colors.white,),
                                  title: Text("Home", style: TextStyle(color: Colors.white),),
                                ),
                                ListTile(
                                  onTap: (){
                                    //  Navigator.of(context).push(MaterialPageRoute(builder: (context) =>Profile()));
                                      Get.to(Profile(), transition: Transition.rightToLeftWithFade);
                                  },
                                  leading: Icon(
                                    Icons.person, 
                                    color: Colors.white,),
                                  title: Text(
                                    "Profile", 
                                    style: TextStyle(
                                      color: Colors.white),),
                                ),
                                ListTile(
                                  onTap: (){
                                    //  Navigator.of(context).push(MaterialPageRoute(builder: (context) =>Setting()));
                                     Get.to(Setting(), transition: Transition.rightToLeftWithFade);
                                  },
                                  leading: Icon(
                                        Icons.settings, 
                                        color: Colors.white,),
                                  title: Text(
                                            "Settings", 
                                            style: TextStyle(
                                                color: Colors.white),),
                                ),
                                ListTile(
                                
                                  leading: Icon(isLoggedIn?
                                        Icons.logout : Icons.login, 
                                        color: Colors.white,),
                                 
                                  title: Text(isLoggedIn ? 'Logout' : 'Login/ Sign Up',  style: TextStyle(
                                                 color: Colors.white),),
                                  onTap: () {
                                    if (isLoggedIn) {
                                      logout();
                                    } else {
                                      // Handle login
                                      login();
                                    }
                                  },
                                )
                              ],
                            )
                      ),
                  ]
                ),
            )
            ),

            TweenAnimationBuilder(
              tween: Tween<double>(begin: 0,end: value), 
              duration: Duration(milliseconds: 300), 
              curve: Curves.easeIn,
              builder: (_, double val,__){
                return (Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.001)
                  ..setEntry(0, 3 , 200 * val)
                  ..rotateY((pi / 6) * val),
                  child: buildHome(context)
                ));
              }
              ),
              GestureDetector(
                onHorizontalDragUpdate: (e){
                             if (e.delta.dx >0) {
                               setState(() {
                                 value = 1;
                               });
                             }
                             else{
                               setState(() {
                                 value = 0;
                               });
                             }
                          },
              )
        ],
      ),
    );
    // buildHome(context);
  }

  Scaffold buildHome(BuildContext context) {
    return Scaffold(
    backgroundColor: Colors.black,
 
    body: SafeArea(
      child: SingleChildScrollView(
        child: ListView(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          padding: EdgeInsets.only(top: 20,),
          children: [
            Container(
             
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: EdgeInsets.all(20),
                        child: 
                        GestureDetector(
                         
                          child: Icon(Icons.menu,color: Colors.white, size: 40,),
                          onTap: (() {
                            setState(() {
                              value == 0 ? value = 1 : value = 0;
                            });
                          })
                        )
                       
                      ),
                      Container(
                        padding: EdgeInsets.all(20),
                        child: 
                         Row(
                           children: [
                             Center(
                               child: Badge(
                                  badgeContent: Text('0', style: TextStyle(color: Colors.white)),
                                  badgeAnimation: BadgeAnimation.fade(),
                                  badgeStyle: BadgeStyle(
                                    badgeColor: Color(0xffE57734)
                                  ),
                                  child: IconButton(
                                    icon: Icon(Icons.shopping_bag_outlined, size: 30,), 
                                    color: Colors.white,
                                    onPressed: () { 
                                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx) => CartScreen()));
                                     },
                                    ),
                               ),
                             ),
                              // IconButton(
                              //   icon: Icon(Icons.login_outlined, size: 30,), 
                              //   color: Colors.white,
                              //   onPressed: () { 
                              //     Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (ctx) => Login()), (route) => false);
                              //    },
                              //   ),
                              
                              
                           ],
                         )                          
                      ),                   
                    ],
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Text(" App", 
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                
                              ),),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                       Align(
                          alignment: Alignment.center,
                          child: Text("Your needs", 
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                               
                              ),),
                       ),
                        SizedBox(
                        height: 50,
                      ),
                    ],
                  ),
                  HomeCard(),
                         
                ],
              ),
            )
          ],
        ),
      )),
  );
  }
}

class CircleTabIndicator extends Decoration{
  late final BoxPainter _painter;

  // ignore: non_constant_identifier_names
  CircleTabIndicator({required Color color, required double radius}):
            _painter= _CirclePainter(color,radius);

  
  @override
  BoxPainter createBoxPainter([ VoidCallback? onChanged]) => _painter;

}

class _CirclePainter extends BoxPainter{
    late final Paint _paint;
    late double radius;

    _CirclePainter(Color color, this.radius): _paint = Paint()
          ..color = color
          ..isAntiAlias = true;

    @override
    void paint(Canvas canvas, Offset offset, ImageConfiguration configuration){
          final Offset circleOffset = offset + Offset(configuration.size!.width / 2, configuration.size!.height - radius);
          canvas.drawCircle(circleOffset, radius, _paint);
    }
}