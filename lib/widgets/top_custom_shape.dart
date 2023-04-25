import 'package:flutter/material.dart';
import 'package:cafe_app/components/colors.dart';
import 'package:cafe_app/components/size_config.dart';
import 'package:cafe_app/components/custom_shape.dart';

class TopCustomShape extends StatefulWidget {
  const TopCustomShape({Key? key}) : super(key: key);

  @override
  _TopCustomShapeState createState() => _TopCustomShapeState();
}

class _TopCustomShapeState extends State<TopCustomShape> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 240,//SizeConfig.screenHeight,               /// 240.0
      child: Stack(
        children: [
          ClipPath(
            clipper: CustomShape(),
            child: Container(
              height: 150,//SizeConfig.screenHeight!/4.56,       /// 150.0
              color: Colors.black,
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  height: 140.0,
                  width: 140.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2.0),
                    color: Colors.white,
                  ),
                  child: Image.asset(
                    "assets/home/coffee.png",
                    fit: BoxFit.contain,
                  ),
                ),
                Text("Name Surname", style: TextStyle(fontSize: 22,color: Colors.white),),
                SizedBox(height: 5,),//SizeConfig.screenHeight!/136.6,),              /// 5.0
                Text("test@gmail.com", style: TextStyle(fontWeight: FontWeight.w400, color: Colors.white),)
              ],
            ),
          )
        ],
      ),
    );
  }
}
