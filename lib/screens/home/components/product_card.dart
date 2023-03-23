

import 'package:cafe_app/components/fav_btn.dart';
import 'package:cafe_app/models/Product.dart';
import 'package:flutter/material.dart';
import '../../../constraints/constants.dart';

class ProductCard extends StatelessWidget {


  ProductCard({
    Key? key,
    required this.product,
    required this.press,
  }) : super(key: key);

  final Product product;

  final VoidCallback press;

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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
                      onTap: () {
                        
                      },
                      child: 
                      Container(
                        margin: const EdgeInsets.only(top: 10),
                        height: 120,
                        width: MediaQuery.of(context).size.width,
                        child:
                              Image.network(
                                 product.image,
                                  fit: BoxFit.contain,
                                  scale: 0.4,
                                )
                             
                      ),
              ),
            const SizedBox(height: 10,),
            Text(
              product.title,
              style: Theme.of(context)
                  .textTheme
                  .subtitle1!
                  .copyWith(fontWeight: FontWeight.w600, fontSize: 18,color: Colors.white),
            ),
            Text(
               product.desc,
              style: Theme.of(context).textTheme.caption?.copyWith(color: Colors.white),
            ),
            const SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("₹ ${product.price}",
                 style: Theme.of(context)
                  .textTheme
                  .subtitle1!
                  .copyWith(fontWeight: FontWeight.w600, color: Colors.white),),
                const FavBtn(),
              ],
            )
          ],
        ),
      ),
    );
  }
}
