import 'package:badges/badges.dart';
import 'package:cafe_app/controllers/home_controller.dart';
import 'package:cafe_app/screens/home/components/product_card.dart';
import 'package:cafe_app/screens/login.dart';
import 'package:cafe_app/screens/home.dart';
import 'package:cafe_app/services/item_service.dart';
import 'package:cafe_app/services/cart_service.dart';
import 'package:cafe_app/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:cafe_app/models/user_model.dart';
import 'package:cafe_app/services/api_response.dart';
import 'package:provider/provider.dart';
import 'home/components/addOn_card.dart';
import 'home/components/cart_details_view.dart';
import 'home/components/cart_short_view.dart';
import 'package:cafe_app/api/apiFile.dart';
import 'package:cafe_app/models/AddOn.dart';
import 'package:cafe_app/screens/cartscreen.dart';
import 'package:get/get.dart';


class AddOnPage extends StatefulWidget {
  const AddOnPage({super.key});

  @override
  State<AddOnPage> createState() => _AddOnPageState();
}

class _AddOnPageState extends State<AddOnPage> with TickerProviderStateMixin{

  late List<UserModel>? _userModel = [];
  final controller = HomeController();
  
  String _cartTag = "";
  int userId = 0;
  bool _loading = true;

  List<dynamic> _productList = [].obs;

  String _cartMessage = '';
  
  @override
  void initState(){

    super.initState();
    retrieveItems();
  }


  @override
  void dispose(){
    super.dispose();
  }

  void _onVerticalGesture(DragUpdateDetails details) {
    setState(() {
        if (details.primaryDelta! < -0.7) {
      controller.changeHomeState(HomeState.cart);
    } else if (details.primaryDelta! > 12) {
      controller.changeHomeState(HomeState.normal);
    }
    });
    
  }

  Future<void> retrieveItems() async{

    ApiResponse response = await getItems();
    if(response.error == null)
    {
      setState(() {
        _productList = response.data as List<dynamic>;
        _loading = _loading ? !_loading : _loading;
      });
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
   
  Future<void> addCart(AddOn item) async{
    userId = await getUserId();

    ApiResponse response = await addItemToCart(item);
    if(response.error == null)
    {
      setState(() {
        //add the counter here
        //incrementCount();
        _cartMessage = response.data.toString();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("${_cartMessage}")));
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
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("${response.error}")));
    }
  }




  @override
  Widget build(BuildContext context) {
    final newCart = Provider.of<HomeController>(context);
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        backgroundColor: Colors.black,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right:20.0),
            child: Center(
              child: Badge(
                badgeStyle: BadgeStyle(
                  badgeColor: Color(0xffe57734)
                ),
                badgeContent: Consumer<HomeController>(
                  builder: (context, value,child) { 
                    return Text(value.getCounter().toString(), style: TextStyle(color: Colors.white));
                   },
                
                ),
                child:  IconButton(
                            icon: Icon(Icons.shopping_bag_outlined, size: 30,), 
                            color: Colors.white,
                            onPressed: () { 
                              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx) => CartScreen()));
                            },
                        ),
              ),
            ),
          )
          // IconBtnWithCounter(
          //   svgSrc: "Assets/Images/cart.svg",
          //   press:() {},
          //  ),
          //  IconBtnWithCounter(
          //   svgSrc: "Assets/Images/bell.svg",
          //   numOfItems: 3,
          //   press:() {},
          //  ),
        ],
      ),
     
      body: RefreshIndicator(
        onRefresh: (){
          return retrieveItems();
        },
        child:
            SafeArea(
              bottom: false,
              child: Container(
                color: Colors.black,
                child: AnimatedBuilder(
                    animation: controller,
                    builder: (context, _) {
                      return LayoutBuilder(
                        builder: (context, BoxConstraints constraints) {
                          return Stack(
                            children: [          
                                         
                              AnimatedPositioned(
                                duration: const Duration(milliseconds: 500),
                                  top: controller.homeState == HomeState.normal
                                    ? 85
                                    : -(constraints.maxHeight -
                                        100 * 2 -
                                        85),
                                  left: 0,
                                  right: 0,
                                  height: constraints.maxHeight -
                                    85 -
                                    100,
                                  
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 10),
                                  decoration: const BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.only(
                                      bottomLeft:
                                          Radius.circular(20 * 1.5),
                                      bottomRight:
                                          Radius.circular(20 * 1.5),
                                    ),
                                  ),
                                  child: GridView.builder(
                                    itemCount:  _productList.length,
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      childAspectRatio: 0.8,
                                      mainAxisSpacing: 10,
                                      crossAxisSpacing: 10,
                                    ),
                                    itemBuilder: (context, index) => AddOnCard(
                                      product: _productList[index],
                                      press: () {
                                        
                                              controller.addProductToCart(_productList[index]);
                                              addCart(_productList[index]);
                                              _cartTag = '_cartTag';

                                            
                                      }                                       
                                    ),
                                  ),
                                ),
                              ),
                              // Card Panel
                              AnimatedPositioned(
                                duration: const Duration(milliseconds: 500),
                                bottom: 0,
                                left: 0,
                                right: 0,
                                height: controller.homeState == HomeState.normal
                                    ? 100
                                    : (constraints.maxHeight - 100),
                                child: GestureDetector(
                                  onVerticalDragUpdate: _onVerticalGesture,
                                  child: Container(
                                    padding: const EdgeInsets.all(20),
                                  
                                    decoration: const BoxDecoration(
                                            color: Colors.white24,
                                            borderRadius: BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40))
                                    ),
                                    alignment: Alignment.topLeft,
                                    child: AnimatedSwitcher(
                                      duration: const Duration(milliseconds: 500),
                                      child: controller.homeState == HomeState.normal
                                          ? CardShortView(controller: controller)
                                          : CartDetailsView(controller: controller),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    }
                    ),
              ),
            )
    )
    );
  }
}