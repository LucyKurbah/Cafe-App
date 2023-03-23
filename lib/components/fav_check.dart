import 'package:flutter/material.dart';

class FavCheck extends StatelessWidget {
  const FavCheck({
    Key? key,
    this.radius = 13,
  }) : super(key: key);

  final double radius;

  @override
  Widget build(BuildContext context) {
    bool value=false;
    return Transform.scale(
      scale: 1.5,
      child: Theme(
        
        data: ThemeData(
            checkboxTheme: CheckboxThemeData(
              shape: CircleBorder(),
               
            ),
            
          ),
        child: Checkbox(
          visualDensity: VisualDensity.adaptivePlatformDensity,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          tristate: false,
          // transform: Matrix4.identity()..scale(1.5),
            value: value, 
            onChanged: (bool){   
              value =!value;          
            }),
      ),
    );
  }
}
