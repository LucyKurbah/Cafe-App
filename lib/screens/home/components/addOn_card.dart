

import 'package:cafe_app/components/fav_check.dart';
import 'package:cafe_app/models/AddOn.dart';
import 'package:flutter/material.dart';
import '../../../api/apiFile.dart';
import '../../../constraints/constants.dart';
import '../../../services/api_response.dart';
import '../../../services/cart_service.dart';
import '../../../services/user_service.dart';

class AddOnCard extends StatefulWidget {

  AddOnCard({
    Key? key,
    required this.product,
    required this.press,
  }) : super(key: key);

  final AddOn product;
  final VoidCallback press;


  @override
  State<AddOnCard> createState() => _AddOnCardState();
}

class _AddOnCardState extends State<AddOnCard> {
  bool rememberMe = false;
  bool checkedValue = false;
  int userId = 0;
 
  Future<void> addCart(AddOn item) async{
    userId = await getUserId();

    ApiResponse response = await addItemToCart(item);
    if(response.error == null)
    {
      setState(() {

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Success")));

      });
    }
    else if(response.error == ApiConstants.unauthorized){
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error occurred")));
                                          
    }
    else{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("${response.error}")));
    }
  }


  @override
  Widget build(BuildContext context) {
    return
     GestureDetector(
      onTap: (){
         setState(() {
          checkedValue = !checkedValue;
          addCart(widget.product);
        });
      },
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
            Container(
              margin: const EdgeInsets.all(10),
              height: 100,
              width: 100,
              child:
                    Image.network(
                       widget.product.image,
                        fit: BoxFit.contain,
                        scale: 0.4,
                      )
            ),
            const SizedBox(width: 10,),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [              
                Text(
                  widget.product.title,
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1!
                      .copyWith(fontWeight: FontWeight.w600, fontSize: 18,color: Colors.white),
                ),
               SizedBox(height: 5,),
                Text("₹ ${widget.product.price}",
                 style: Theme.of(context)
                  .textTheme
                  .subtitle1!
                  .copyWith(fontSize: 13, color: Colors.white),),
                  
              ],
            ),
            Expanded(child: Container()), 
            if(checkedValue)
                  SizedBox(width: 50,),
            if(checkedValue)
                  Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              GestureDetector(
                                                child: Text('- ',style: TextStyle(fontSize: 30, color: Colors.white),),
                                                onTap:(){
                                                  // addItemToCart(widget.product.id);
                                                }
                                              ),
                                              SizedBox(width: 5,),
                                              Text("1",
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.white
                                                ),
                                              ),
                                              SizedBox(width: 5,),
                                              GestureDetector(
                                                child: Icon(Icons.add, color: Colors.white),
                                                onTap: (){
                                                  // removeItemsFromCart(widget.product.id);
                                                },
                    ), ],),
            
            Expanded(child: Container()), 
          // this will fill up any remaining space
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                        child: 
                        Transform.scale(
                          scale: 1.5,
                          child: Theme(
                            data: ThemeData(
                                checkboxTheme: CheckboxThemeData(
                                  shape: CircleBorder(),
                                  checkColor: MaterialStateProperty.all<Color>(Colors.white),
                                    fillColor: MaterialStateProperty.resolveWith<Color?>(
                                        (Set<MaterialState> states) {
                                          if (states.contains(MaterialState.selected)) {
                                            return Colors.grey[800];
                                          } else {
                                            return Colors.grey;
                                      } }, ),
                                  splashRadius: 10.0,
                                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                  visualDensity: VisualDensity.compact,
                                ),                          
                              ),                          
                            child: Checkbox(
                              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              tristate: false,
                                value: checkedValue, 
                                onChanged:(bool? newValue) {   
                                setState(() {
                                  checkedValue = newValue ?? false;
                                  if (checkedValue) {
                                    // addItemToCart();
                                    addCart(widget.product);
                                    print("Click");
                                  }
                                  else
                                  {
                                    //RemoveAllFrom Cart
                                    print("object");
                                  }
                                });                                   
                                }),
                          ),
                        ),
                      )
            ),
          ],
        ),
         ),
     );   
  }
}
