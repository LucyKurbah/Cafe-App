import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';
import 'home.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> with TickerProviderStateMixin{
 
 
  late TabController _tabController;
  
  @override
  void initState(){
    _tabController = TabController(length: 7, vsync: this);
  }
  
  categoriesContainer({required String name})
  {
    return  Column(
           children: [
            SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    name, style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                )
              ],
          );
  }

  bottomContainer({required String image, required String name, required int price}){
      return Container(
            height: 40,
            width: 40,
            padding: EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
                  color: Color(0xff3a3e3e),
                  borderRadius: BorderRadius.circular(20)
            ),
            child: Column(
              children: [
              CircleAvatar(
                backgroundImage: AssetImage(image),
                radius: 70,
              ),
              ListTile(
                leading: Text(name, style: TextStyle(fontSize: 17, color: Colors.white),),
                trailing: Text("₹ $price", style: TextStyle(fontSize: 17,color: Colors.white),),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 12,top: 10),
                child: Row(
                  children: [
                    Icon(Icons.star, color: Colors.white,size: 15,),
                    Icon(Icons.star, color: Colors.white,size: 15,),
                    Icon(Icons.star, color: Colors.white,size: 15,),
                    Icon(Icons.star, color: Colors.white,size: 15,),
                    Icon(Icons.star, color: Colors.white,size: 15,),

                  ],
                ),
              )
              ],
            ),
          );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 0.0,
        leading: IconButton(onPressed: (){
           Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx) => Home()));
        }, icon: Icon(Icons.arrow_back), color: Colors.white,),
        backgroundColor: Colors.black,
        actions: [
          Padding(
            padding: const EdgeInsets.all(9.0),
            child: CircleAvatar(
              backgroundImage: AssetImage("Assets/food/one.jpg"),
            ),
          )
        ],
      ),
      body: 
      ListView(
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search,color: Colors.white,),
                hintText: "Search  Food",
                hintStyle: TextStyle(color: Colors.white),
                fillColor: Color(0xff3a3b3e),
                filled: true,
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(10)
                )
              ),
            ),
          ),
  
          TabBar(
            padding: EdgeInsets.only(left:13, right: 10),
            controller: _tabController,
            isScrollable: true,
            indicator: CircleTabIndicator(color: Color(0xffd17842), radius: 4),
            labelColor: Color(0xffd17842),
            labelStyle: TextStyle(fontWeight: FontWeight.bold),
            unselectedLabelColor: Color(0xff7a4846),
              tabs:[
                Tab(text: "All",),
                Tab(text: "Starters",),
                Tab(text: "Main Course",),
                Tab(text: "Desserts",),
                Tab(text: "Beverages",),
                Tab(text: "Desserts",),
                Tab(text: "Beverages",),
              ]),
         
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
            height: MediaQuery.of(context).size.height -200,
            child: GridView.count(
              // shrinkWrap: false,
              crossAxisCount: 2,
              childAspectRatio: 0.7,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
              padding: EdgeInsets.only(top: 10, bottom: 10),
              scrollDirection: Axis.vertical,
              children: [
                bottomContainer(
                  image: "Assets/food/one.jpg", 
                  name: "Test1", 
                  price: 12),
                bottomContainer(
                  image: "Assets/food/two.jpg", 
                  name: "Test 2 3", 
                  price: 12),
                bottomContainer(
                  image: "Assets/food/three.jpg", 
                  name: "Test 4", 
                  price: 12),
                bottomContainer(
                  image: "Assets/food/four.jpg", 
                  name: "Testing", 
                  price: 12),
                bottomContainer(
                  image: "Assets/food/one.jpg", 
                  name: "Food Item", 
                  price: 12),
                bottomContainer(
                  image: "Assets/food/two.jpg", 
                  name: "Noodles", 
                  price: 12),
                bottomContainer(
                  image: "Assets/food/one.jpg", 
                  name: "Food Item", 
                  price: 12),
                bottomContainer(
                  image: "Assets/food/two.jpg", 
                  name: "Noodles", 
                  price: 12),
                   bottomContainer(
                  image: "Assets/food/two.jpg", 
                  name: "Noodles", 
                  price: 12),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class CircleTabIndicator extends Decoration{
  
  final BoxPainter _painter; 

  CircleTabIndicator({required Color color, required double radius}):  
      _painter = _CirclePainter(color, radius);

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) => _painter;
}

class _CirclePainter extends BoxPainter{
    final Paint _paint;
    final double radius;

    _CirclePainter(Color color, this.radius): _paint = Paint();

    @override
    void paint(Canvas canvas, Offset offset, ImageConfiguration configuration){
        final Offset circleOffset = offset + Offset(configuration.size!.width/2, configuration.size!.height - radius);
        canvas.drawCircle(circleOffset, radius, _paint);
    }
}
