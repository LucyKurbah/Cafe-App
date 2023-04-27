import 'package:cafe_app/screens/table/table_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../conference/conference_screen.dart';
import '../menu/menu.dart';

class HomeCard extends StatefulWidget {
  @override
  State<HomeCard> createState() => _HomeCardState();
}

class _HomeCardState extends State<HomeCard> {
  List<String> images = [
    'food/one.jpg',
    'food/two.jpg',
    'food/three.jpg',
    'food/four.jpg',
  ];

  List<String> description = [
    'Table',
    'Conference',
    'Coffee & Convo',
    'Entire Floor',
  ];

   List<String> price = [
    '220.0',
    '190.0',
    '250.0',
    '300.0',
  ];

  List<String> pages = [
    'table',
    'conference',
    'coffee',
    'floor',
  ];

  List<Widget> myWidgets  = [
    TablePage(),
    ConferenceScreen(),
    MenuPage(),
    ConferenceScreen(),
  ];

  List<Map<String,dynamic>> gridMap = [

    {
      "title": "Tables",
      "price" : "1",
      "images": "Assets/home/table.png"
    },
    {
      "title": "Conference",
      "price" : "1",
      "images": "Assets/home/conference.png"
    },
    {
      "title": "Coffee & Convo",
      "price" : "1",
      "images": "Assets/home/coffee.png"
    },
    {
      "title": "Entire Floor",
      "price" : "1",
      "images": "Assets/home/room.png"
    }
    
  ];

  @override
  Widget build(BuildContext context) {
    return 
    
    Expanded(
      child: Container(
        height:MediaQuery.of(context).size.height * 2 ,
        // color: Colors.grey[800],
        padding: EdgeInsets.all(30),
        decoration: BoxDecoration(
                      color: Colors.grey[850],
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50)
                      )
        ),
        
        child: GridView.builder(
          shrinkWrap: true,
          // physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, 
              crossAxisSpacing: 30.0,
              mainAxisSpacing: 50.0,
              mainAxisExtent: 230
              ),
          itemCount: gridMap.length, 
          itemBuilder: ((context, index) {
                return InkWell(
                     onTap: (){                        
                        // Navigator.pushNamed(context, '/${pages[index]}');
                        Get.to(() => myWidgets[index], transition: Transition.rightToLeftWithFade, duration: Duration(milliseconds: 300));
                      },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.0),
                      color: Colors.white,
                    ),
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(16.0), topRight: Radius.circular(16.0)),
                          child: Transform.scale(
                            scale: 0.4,
                            child: Image.asset(
                              "${gridMap.elementAt(index)['images']}",
                              height: MediaQuery.of(context).size.height*0.2,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          )
                        ),
                        Padding(padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text("${gridMap.elementAt(index)['title']}", 
                                      style: TextStyle(color: Colors.black,
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.bold)),
                              const SizedBox(height: 8.0,),
                              Icon(Icons.arrow_right_alt_sharp, color: Colors.black)
                            ],
                          ),
                        )
                      ],
                    ),
                              
                  ),
                );
          })
          ),
      ),
    ); 
  }
}