import 'package:cafe_app/components/colors.dart';
import 'package:cafe_app/widgets/custom_widgets.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';

import '../../components/dimensions.dart';

class EventBody extends StatefulWidget {
  const EventBody({super.key});

  @override
  State<EventBody> createState() => _EventBodyState();
}

class _EventBodyState extends State<EventBody> {
  PageController pageController = PageController(viewportFraction: 0.89);
  var _currPageValue = 0.0;
  double _scaleFactor = 0.8;
  double _height = Dimensions.pageViewContainer;
  
  @override
  void initState() {
    super.initState();
    pageController.addListener(() { 
      setState(() {
        _currPageValue = pageController.page!;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            height: Dimensions.pageView,
            child: PageView.builder(
              controller: pageController,
              itemCount: 5,
              itemBuilder: ((context, index) {
                return _buildPageItem(index);
              }
              ),
        )),
        DotsIndicator(
          dotsCount: 5,
          position: _currPageValue,
          decorator: DotsDecorator(
            activeColor: iconColors1,
            size: const Size.square(10.0),
            activeSize: const Size(15.0, 9.0),
            activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
          ),
        )
      ],
    );
  }
  
  _buildPageItem(index) {
      Matrix4 matrix = new Matrix4.identity();
      if(index == _currPageValue.floor()){
          var currScale = 1-(_currPageValue-index)*(1-_scaleFactor);
          var currTrans = _height * (1-currScale)/2;
          matrix = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, currTrans, 0);

      }else if(index == _currPageValue.floor()+1){
          var currScale = _scaleFactor+(_currPageValue-index+1)*(1-_scaleFactor);
          var currTrans = _height * (1-currScale)/2;
          //matrix = Matrix4.diagonal3Values(1, currScale, 1);
          matrix = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, currTrans, 0);

      }else if(index == _currPageValue.floor()-1){
          var currScale = 1-(_currPageValue-index)*(1-_scaleFactor);
          var currTrans = _height * (1-currScale)/2;
          //matrix = Matrix4.diagonal3Values(1, currScale, 1);
          matrix = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, currTrans, 0);
      }
      else{
          var currScale = 0.8;
          matrix = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, _height*(1-_scaleFactor)/2, 1);
      }

  return Transform(
    transform: matrix,
    child: Stack(
      children: [
        Container(
            height: Dimensions.pageViewContainer,
            margin: EdgeInsets.only(left: 5, right: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Color(0xFF69c5df),
              image: DecorationImage(
                image: AssetImage("Assets/Images/cafe3.jpg"),
                fit: BoxFit.cover
              )
            )
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
              height: Dimensions.pageViewTextContainer,
              margin: EdgeInsets.only(left: 30, right: 30, bottom: 30),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: textColor,
              ),
              child: Container(
                padding: EdgeInsets.only(top: Dimensions.height15, left: Dimensions.height15, right: Dimensions.height15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                      BigText("Event 1",mainColor),
                      SizedBox(height: Dimensions.height10,),
                      Row(
                        children: [
                          Wrap(
                            children: List.generate(5, (index) => Icon(Icons.star, color: mainColor,size: 15,)),
                          ),
                          SizedBox(width: 10,),
                          SmallText("text", mainColor),
                          SizedBox(width: 10,),
                          SmallText("1245", mainColor),
                        ],
                      ),
                      SizedBox(height: Dimensions.height20,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                            IconText(Icons.circle_sharp, iconColors1, "Normal" ),
                            
                            IconText(Icons.location_on, iconColors3, "Location"),
                            
                            IconText(Icons.access_time_rounded, iconColors2, "Normal" ),
                        ],
                      )
                ]),
              ),
          ),
        ),
      ]
    ),
  );
 }
}