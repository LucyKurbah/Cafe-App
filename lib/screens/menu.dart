import 'package:flutter/material.dart';

class MenuItems extends StatefulWidget {
  const MenuItems({super.key});

  @override
  State<MenuItems> createState() => _MenuItemsState();
}

class _MenuItemsState extends State<MenuItems>  with SingleTickerProviderStateMixin{
    
 late TabController _tabController;
  @override
  void initState(){
      super.initState();
      _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pickup',
                    style: TextStyle(
                      fontFamily: 'Varela',
                      fontSize: 20.0,
                      color: Color(0xFF545068)
                    ),
        ),
        actions: [
          IconButton(
          onPressed: (){}, 
          icon: Icon(Icons.notifications_none, color: Color(0xFF545068))
        ),
        ],
        backgroundColor: Colors.black,
        centerTitle: true,
        leading: IconButton(
          onPressed: (){}, 
          icon: Icon(Icons.arrow_back, color: Color(0xFF545D68))
        ),
    ),
    body: ListView(
      padding: EdgeInsets.only(left: 20.0),
      children: [
        SizedBox(height: 15.0),
        Text('Menu',
            style: TextStyle(
              fontFamily: 'Varela',
              fontSize: 42.0,
              fontWeight: FontWeight.bold
            ),
        ),
        SizedBox(height: 15.0,),
        TabBar(
          controller: _tabController,
          indicatorColor: Colors.transparent,
          labelColor: Color(0xFFC88D67),
          isScrollable: true,
          labelPadding: EdgeInsets.only(right: 45.0),
          unselectedLabelColor: Color(0xFFCDCDCD),
          tabs: [
            Tab(
              child: Text('Coffee',
                    style: TextStyle(
                      fontFamily: 'Varela',fontSize: 21.0
                    ),),
            ),
            Tab(
              child: Text('Tea',
                    style: TextStyle(
                      fontFamily: 'Varela',fontSize: 21.0
                    ),),
            ),
            Tab(
              child: Text('Cookies',
                    style: TextStyle(
                      fontFamily: 'Varela',fontSize: 21.0
                    ),),
            ),
          ],
        )

      ],
    ),
    floatingActionButton: FloatingActionButton(
          onPressed: (){},
          backgroundColor: Color(0xFF17532),
          child: Icon(Icons.fastfood),
          ),
          floatingActionButtonLocation: FloatingActionButton.centerTitle,
    );
  }
}