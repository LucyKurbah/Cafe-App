import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';

class HomeCard extends StatelessWidget {



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

  @override
  Widget build(BuildContext context) {
    return 
    
    Flexible(
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: images.length,
       
       
        itemBuilder: (context, index) {
          return Row(
            children: [
              Container(
                height: 250,
                width: 160,
                child: Column(
                  children: [
                    SizedBox(height: 10,),
                    Container(
                      height: 130,
                      width: 140,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                          image: AssetImage(images[index]),
                          fit: BoxFit.cover,
                        )
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Chowmein",style: TextStyle(color: Colors.white),),
                          SizedBox(
                            height: 3,
                          ),
                          Text(
                            description[index],
                            style: TextStyle(
                              color: Color(0xff919293),
                              fontSize: 11
                            ),
                          ),
                          SizedBox(height: 5,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                   Text('Rs. ',
                                      style: TextStyle(
                                      color: Color(0xffd17842),
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold
                                    ),),
                                    Text(price[index], style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                    ),),
                                ],
                              ),
                               Container(
                                  height: 20,
                                  width: 20,
                                  child: Icon(Icons.add, color: Colors.white, size: 15,),
                                  decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 22, 14, 9),
                                    borderRadius: BorderRadius.circular(10)
                                  ),
                                )
                            ],
                          ),
                         
                        ],
                      ),
                      )
                  ],
                ),
                decoration: BoxDecoration(
                  color: Color(0xff242931),
                  borderRadius: BorderRadius.circular(20)
                ),
              ),
              SizedBox(width: 20,),
            ],
          );
        },
       ),
    );
  }
}