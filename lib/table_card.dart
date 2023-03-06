import 'package:flutter/foundation.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';

import 'home.dart';

class TableCard extends StatefulWidget {
  const TableCard({super.key});

  @override
  State<TableCard> createState() => _TableCardState();
}

class _TableCardState extends State<TableCard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
     appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text("Tables", style: TextStyle(color: Colors.white),),
        elevation: 0.0,
        leading: IconButton(
            onPressed: (){
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx) => Home()));
            }, 
            icon: Icon(Icons.arrow_back), color: Colors.white,),
            actions: [
              IconButton(
                onPressed: (){

                }, 
                icon: Icon(Icons.notifications_none))
            ],
      ),
      body:   Container(
        child: Column(
          children: [
            // Container(
            //   height: MediaQuery.of(context).size.height *(0.25),
            //   child: Stack(
            //     children: [
            //       Container(
            //         height: MediaQuery.of(context).size.height *0.25 -27,
            //         decoration: BoxDecoration(
            //           color: Colors.grey[900],
            //           borderRadius: BorderRadius.only(
            //             bottomLeft: Radius.circular(36),
            //             bottomRight: Radius.circular(36)
                      
            //           )
            //         ),
            //       ),
            //       Positioned(
            //         bottom: 0,
            //         left: 0,
            //         right: 0,
            //         child: Container(
            //           alignment: Alignment.center,
            //           margin: EdgeInsets.symmetric(horizontal: 16.0 ),
            //           padding: EdgeInsets.symmetric(horizontal: 16.0 ),
            //           height: 54,
            //           decoration: BoxDecoration(
            //             color: Colors.white,
            //             borderRadius: BorderRadius.circular(20),
            //             boxShadow: [
            //               BoxShadow(
            //                   offset: Offset(0, 10),
            //                   blurRadius: 50,
            //                   color: Colors.grey,
            //               ),
            //             ],
            //           ),
            //           child: Material(
            //             child: TextField(
            //               decoration: InputDecoration(
            //                 hintText: "Seach",
            //                 hintStyle: TextStyle(
            //                   color: Colors.black.withOpacity(0.5),
            //                 ),
            //                 enabledBorder: InputBorder.none,
            //                 focusedBorder: InputBorder.none,
            //               ),
            //             ),
            //           ),
            //         )
            //       )
            //     ],
            //   ),
            // ),
           
          ],
        ),
      ),
    );
    
    
  }
}