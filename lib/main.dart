import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:cafe_app/screens/menu.dart';
import 'package:provider/provider.dart';
import 'controllers/home_controller.dart';
import 'screens/table_page.dart';
import 'screens/cartscreen.dart';
import 'screens/conference_screen.dart';
import 'screens/loading.dart';
import 'package:get/get.dart';
import 'screens/login.dart';
import 'screens/register.dart';

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel', //id
  'High Importance Notifications', //title
  // 'This channel is used fro important notifications', //desc
  importance: Importance.high,
  playSound: true
);

// final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//     // await Firebase.initializeApp();
//     print("Message : ${message.messageId}");
// }


Future main() async{
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  
  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  // await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.createNotificationChannel(channel);
  // await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
  //   alert: true,
  //   badge: true,
  //   sound: true
  // );

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  
  @override
  void initState(){
    super.initState();


    // FirebaseMessaging.instance.getInitialMessage();

    // //Foreground
    // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    //   RemoteNotification? notification = message.notification;
    //   AndroidNotification? android = message.notification?.android;
    //   if(notification != null && android != null)
    //   {
    //     print(message.notification!.body);
    //     print(message.notification!.title);
        
    //   }
      
    // });
  }

  @override
  Widget build(BuildContext context) {
     return ChangeNotifierProvider(
      create: (_) =>HomeController(),
      child: Builder(builder: (BuildContext context) {
        return GetMaterialApp(
          
                      title: 'Cafe App',
                      // theme: ThemeData.dark(),
                      
                      home: const Loading(),
                      routes: {
                          '/table': (context) => TablePage(),
                          '/conference': (context) => ConferenceScreen(),
                          '/coffee': (context) => MenuPage(),
                          '/floor': (context) => TablePage(),
                          '/cart': (context) => CartScreen(),
                          '/checkout': (context) => CartScreen(),
                          '/profile': (context) => CartScreen(),
                          '/login': (context) => Login(),
                          '/signup': (context) => Register(),
                        
                      
                      },
                    );
      }),
    );
   
  }
}
