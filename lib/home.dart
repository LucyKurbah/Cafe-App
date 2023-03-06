import 'package:cafe_app/cartscreen.dart';
import 'package:flutter/material.dart';
import 'home_card.dart';
import 'cartscreen.dart';

 class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin{

  late TabController tabController;

  @override
  void initState() {
    // TODO: implement initState
    tabController = TabController(length: 4, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
   
      body: SafeArea(
        child: SingleChildScrollView(
          child: ListView(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            padding: EdgeInsets.only(top: 20,),
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: EdgeInsets.all(20),
                          child: 
                          Icon(Icons.menu,color: Colors.white, size: 30,),
                        ),
                        Container(
                          padding: EdgeInsets.all(20),
                          child: 
                           IconButton(
                              icon: Icon(Icons.shopping_basket_outlined, size: 30,), 
                              color: Colors.white,
                              onPressed: () { 
                                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx) => CartScreen()));
                               },
                              ) 
                                                    
                        ),                   
                      ],
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Text(" App", 
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  
                                ),),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                         Align(
                            alignment: Alignment.center,
                            child: Text("Your needs", 
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                 
                                ),),
                         ),
                          SizedBox(
                          height: 50,
                        ),
                      ],
                    ),
                    HomeCard(),
                           
                  ],
                ),
              )
            ],
          ),
        )),
    );
  }
}

class CircleTabIndicator extends Decoration{
  late final BoxPainter _painter;

  // ignore: non_constant_identifier_names
  CircleTabIndicator({required Color color, required double radius}):
            _painter= _CirclePainter(color,radius);

  
  @override
  BoxPainter createBoxPainter([ VoidCallback? onChanged]) => _painter;

}

class _CirclePainter extends BoxPainter{
    late final Paint _paint;
    late double radius;

    _CirclePainter(Color color, this.radius): _paint = Paint()
          ..color = color
          ..isAntiAlias = true;

    @override
    void paint(Canvas canvas, Offset offset, ImageConfiguration configuration){
          final Offset circleOffset = offset + Offset(configuration.size!.width / 2, configuration.size!.height - radius);
          canvas.drawCircle(circleOffset, radius, _paint);
    }
}