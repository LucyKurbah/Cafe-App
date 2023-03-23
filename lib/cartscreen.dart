import 'package:flutter/material.dart';
import 'home.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {


  
  int count  = 1;

  _buildSingleCartProduct(){
    return Container(
            
            height: 150,
            width: double.infinity,
      
            child: Card(
              color: Colors.grey[900],
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        height: 130,
                        width: 140,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("Assets/Images/cafe1.jfif"),
                            fit: BoxFit.fill
                          )
                        ),
                      ),
                      Container(
                        height: 140,
                        width: 200,
                        child: ListTile(
                            title: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("data", style: TextStyle(color: Colors.white),),
                                Text("Ingredients data", style: TextStyle(color: Colors.white),),
                                Text("30.00", style: TextStyle(
                                  color: Color(0xff9b96d6),
                                  fontWeight: FontWeight.bold
                                ),),
                                Container(
                                  height: 35,
                                  width: 120,
                                  color: Color(0xff2f2f2),
                                  
                                  // decoration: BoxDecoration(
                                  //   color: Colors.blue[200],
                                  //   borderRadius: BorderRadius.circular(20),
                                  // ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      GestureDetector(
                                        child: Icon(Icons.remove),
                                        onTap: () {
                                          setState((){
                                            if (count >1){
                                              count--;
                                            }
                                          });
                                        },
                                      ),
                                      Text(
                                        count.toString(),
                                        style: TextStyle(
                                          fontSize: 16
                                        ),
                                      ),
                                       GestureDetector(
                                        child: Icon(Icons.add),
                                        onTap: () {
                                          setState((){
                                           count++;
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                        ),
                      )
                    ],
                  ),
                 
                ],
              ),
            ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: 
      AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text("Cart", style: TextStyle(color: Colors.white),),
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
      body: 
      
        Column(
          children: [
            _buildSingleCartProduct(),
            _buildSingleCartProduct(),
            _buildSingleCartProduct()
          ],
        ),
    );
  }
}