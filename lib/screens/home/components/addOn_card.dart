

import 'package:cafe_app/components/fav_btn.dart';
import 'package:cafe_app/components/fav_check.dart';
import 'package:cafe_app/models/AddOn.dart';
import 'package:cafe_app/models/Product.dart';
import 'package:flutter/material.dart';
import '../../../constraints/constants.dart';

class AddOnCard extends StatelessWidget {
 bool rememberMe = false;

  AddOnCard({
    Key? key,
    required this.product,
    required this.press,
  }) : super(key: key);

  final AddOn product;

  final VoidCallback press;

  bool checkedValue = false;
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
        decoration: BoxDecoration(
          color: Colors.grey[900],
          borderRadius: const BorderRadius.all(
            Radius.circular(defaultPadding * 1.25),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            InkWell(
                      onTap: () {
                      },
                      child: 
                      Container(
                        margin: const EdgeInsets.all(10),
                        height: 100,
                        width: 100,
                        child:
                              Image.network(
                                 product.image,
                                  fit: BoxFit.contain,
                                  scale: 0.4,
                                )
                             
                      ),
              ),
            const SizedBox(width: 10,),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [              
                Text(
                  product.title,
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1!
                      .copyWith(fontWeight: FontWeight.w600, fontSize: 18,color: Colors.white),
                ),
               SizedBox(height: 5,),
                Text("₹ ${product.price}",
                 style: Theme.of(context)
                  .textTheme
                  .subtitle1!
                  .copyWith(fontSize: 13, color: Colors.white),),
                  
              ],
            ),
            Expanded(child: Container()), // this will fill up any remaining space
            Align(
              alignment: Alignment.centerRight,
              child: const FavCheck(),// the widget you want to align to the bottom right corner
            ),
            
          ],
        ),
      ),
    );
    
  }
  
}
