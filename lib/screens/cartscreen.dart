
import 'package:cafe_app/screens/home/components/cart_card.dart';
import 'package:flutter/material.dart';
import 'home.dart';
import 'package:cafe_app/services/api_response.dart';
import 'package:cafe_app/api/apiFile.dart';
import 'package:cafe_app/services/user_service.dart';
import 'package:cafe_app/services/cart_service.dart';
import 'package:cafe_app/screens/login.dart';
import '../models/Cart.dart';
import 'package:get/get.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  int count  = 1;
  int userId = 0;
  bool _loading = true;
  String _cartMessage = '';
  List<dynamic> _cartList = [].obs;

  double totalPrice = 0.0;
  // RxDouble _totalCartAmount = 0.00.obs;
  // final CartController cartController = CartController();

   Future<void>  goToPayment(_cartList, totalPrice) async{
    ApiResponse response = await saveOrder(_cartList, totalPrice);
    if(response.error == null)
    {
      print("Payment Done");
    }
    else if(response.error == ApiConstants.unauthorized){
            logoutUser();
            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
                                                      builder: (context) => Home()
                                                                ), 
                                                (route) => false);
     
    }
    else{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("${response.error}")));
    }
  }
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
                        decoration: const BoxDecoration(
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
                                const Text("data", style: TextStyle(color: Colors.white),),
                                const Text("Ingredients data", style: TextStyle(color: Colors.white),),
                                const Text("30.00", style: TextStyle(
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
  void initState() {
    // TODO: implement initState
    super.initState();
    retrieveCart();
    // retrieveTotal();
  }

  Future<void> retrieveCart() async{
    userId = await getUserId();
    ApiResponse response = await getCart();
    if(response.error == null)
    {
      print(response.data);
      setState(() {
        _cartList = response.data as List<dynamic>;
        // print(_cartList);
        // Map<String, List<Cart>> groupedCarts = {};
        // _cartList.forEach((cart) {
        //   String flag = cart.flag;
        //   if(flag=="F")
        //   print("Food");
        //   else
        //   print("Table");
        // });
        _loading = _loading ? !_loading : _loading;
        retrieveTotal();
      });
    }
    else if(response.error == ApiConstants.unauthorized){
      logoutUser();
             Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
                                                      builder: (context) => Login()
                                                                ), 
                                                (route) => false);
    }
    else{
      print(response.error);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("${response.error}")));
    }
  }

  Future<void> retrieveTotal() async{
    userId = await getUserId();
    ApiResponse response = await getTotal();
    if(response.error == null)
    {
     
      setState(() {
        totalPrice = response.data as double;
        _loading = _loading ? !_loading : _loading;
      });
    }
    else if(response.error == ApiConstants.unauthorized){
      logoutUser();
             Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
                                                      builder: (context) => Login()
                                                                ), 
                                                (route) => false);     
    }
    else{
      print("Retrieve Total error");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("${response.error}")));
    }
  }

  Future<void> addCart(Cart cart) async{
    userId = await getUserId();

    ApiResponse response = await incrementCart(cart);
    if(response.error == null)
    {
        retrieveCart();
        _cartMessage = response.data.toString();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("${_cartMessage}")));
        _loading = _loading ? !_loading : _loading;
    }
    else if(response.error == ApiConstants.unauthorized){
      logoutUser();
             Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
                                                      builder: (context) => Login()
                                                                ), 
                                                (route) => false);
      
    }
    else{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("${response.error}")));
    }
  }

  Future<void> removeCart(Cart cart) async{
    userId = await getUserId();
  
    ApiResponse response = await decrementCart(cart);
    if(response.error == null)
    {
         retrieveCart();
        _cartMessage = response.data.toString();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("${_cartMessage}")));
        _loading = _loading ? !_loading : _loading;
    }
    else if(response.error == ApiConstants.unauthorized){
      logoutUser();
             Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
                                                      builder: (context) => Login()
                                                                ), 
                                                (route) => false);
     
    }
    else{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("${response.error}")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: _buildAppBar(),      
      body: Stack(
        children: [
          
            Container(),
            Positioned(
              child:ListView.separated(
                padding: EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 115),   
                itemCount: _cartList.length,
                itemBuilder: (context, index) {
                  final currentFlag = _cartList[index].flag;
                  // Check if the current flag is different from the previous flag
                  if (_cartList[index].flag == "I" && index == _cartList.indexWhere((item) => item.flag == "I")) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Divider(),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text(
                            "Add On ",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white
                            ),
                          ),
                        ),
                        Divider(),
                        CartCard(
                          cart: _cartList[index],
                          addItem: () {
                            addCart(_cartList[index]);
                          },
                          removeItem: () {
                            removeCart(_cartList[index]);
                          },
                        ),
                      ],
                    );
                  }
                  else  if (_cartList[index].flag == "T" && index == _cartList.indexWhere((item) => item.flag == "T"))
                  {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Divider(),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text(
                            "Table",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white
                            ),
                          ),
                        ),
                        Divider(),
                        CartCard(
                          cart: _cartList[index],
                          addItem: () {
                            addCart(_cartList[index]);
                          },
                          removeItem: () {
                            removeCart(_cartList[index]);
                          },
                        ),
                      ],
                    );
                  }
                  else  if (_cartList[index].flag == "F" && index == _cartList.indexWhere((item) => item.flag == "F"))
                  {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Divider(),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text(
                            "Food Items",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white
                            ),
                          ),
                        ),
                        Divider(),
                        CartCard(
                          cart: _cartList[index],
                          addItem: () {
                            addCart(_cartList[index]);
                          },
                          removeItem: () {
                            removeCart(_cartList[index]);
                          },
                        ),
                      ],
                    );
                  }

                   else {
                    // If not, just display the CartCard
                    return CartCard(
                      cart: _cartList[index],
                      addItem: () {
                        addCart(_cartList[index]);
                      },
                      removeItem: () {
                        removeCart(_cartList[index]);
                      },
                    );
                  }
                },
                separatorBuilder: (context, index) => Divider(),
              ) ,
               
              // child: ListView.builder(
                
              //   itemCount: _cartList.length,
              //   shrinkWrap: true,
              //   padding: EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 115),   
                            
              //   itemBuilder: ((context, index) => 
              //      CartCard(
              //         cart: _cartList[index], 
              //         addItem: (){
              //             addCart(_cartList[index]);
              //         }, 
              //         removeItem: (){
              //             removeCart(_cartList[index]);
              //         })
              //   ),
              //  )
            ),
            _buildBottom(),
        ],
      )       
    );
  }

  _buildAppBar(){
    return AppBar(
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
      );
  }

  _buildCartItem()
  {
     return Container(
                  height: 100,
                  width: 100,
                  color: Colors.grey[900],
                  margin: EdgeInsets.all(4.0),
                  child: Row(
                    children: [
                      Container(
                        width: 100,
                        color: Colors.grey[600],
                      ),
                      SizedBox(width: 16,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Title",style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold)),
                          Expanded(
                            child: Text("Description",style: TextStyle(
                                            color: Colors.white,)),
                          ),
                          Text("\999",style: TextStyle(
                                          color: Colors.white,
                                         )),
                        ],
                      ),
                      Spacer(),
                      Row(
                        children: [
                          Container(
                            child: Icon(Icons.remove, color: Colors.white,),
                          ),
                           Container(
                            padding: EdgeInsets.all(8.0),
                            child: Text("2", style: TextStyle(color: Colors.white,),),
                          ),
                           Container(
                             
                            child: Icon(Icons.add, color: Colors.white,),
                          )
                        ],
                      )
                    ],
                  ),
                );
  }

  Positioned _buildBottom(){
    return  Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              color: Colors.grey[700],
              padding: const EdgeInsets.only(left: 30, right: 30, bottom: 10, top: 5),
              child: Column(
                      children: [
                       Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children:[
                            Text("Subtotal",style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold)),
                            Text("₹ ${totalPrice}" ,style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18.0
                                          )),
                            
                        ]
                       ),
                       SizedBox(height: 16,),
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                                    primary: Color(0xffE57734),
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                     
                                    ),
                                  ),
                              
                                onPressed: (){
                                  goToPayment(_cartList, totalPrice);
                                }, 
                                child: Text("Checkout", style: TextStyle(fontSize: 16),),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 9,),
                        // Row(
                        //   children: [
                        //     Expanded(
                        //       child: ElevatedButton(
                        //         style: ElevatedButton.styleFrom(
                        //           padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                        //           primary: Colors.transparent,
                        //           elevation: 0,
                        //           shape: RoundedRectangleBorder(
                        //             borderRadius: BorderRadius.circular(8),
                        //             side: BorderSide(
                        //               color: Colors.white
                        //             )
                        //           ),
                        //         ),
                        //         onPressed: (){}, 
                        //         child: Text("Checkout with Paypal", 
                        //           style: TextStyle(
                        //             color: Colors.white,
                        //           )),
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        SizedBox(height: 16,),
                        // Text("Continue Shopping", style: TextStyle(color: Colors.white),)
                      ],
                    ),
            ),
                  
            );
          
  }
}