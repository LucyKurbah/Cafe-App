import 'package:cafe_app/constraints/constants.dart';
import 'package:flutter/material.dart';
import 'package:cafe_app/models/Table.dart';
import 'package:cafe_app/controllers/home_controller.dart';
import 'package:cafe_app/widgets/custom_widgets.dart';
import 'package:provider/provider.dart';
import '../api/apiFile.dart';
import '../services/api_response.dart';
import '../services/cart_service.dart';
import '../services/user_service.dart';
import '../services/table_service.dart';
import 'cartscreen.dart';
import 'package:badges/badges.dart';
import 'package:intl/intl.dart';

import 'home.dart';
import 'login.dart';

class DateTimeScreen extends StatefulWidget {
  DateTimeScreen(this.table, {super.key});

  TableModel table;

  @override
  State<DateTimeScreen> createState() => _DateTimeScreenState();
}

class _DateTimeScreenState extends State<DateTimeScreen> {
  TextEditingController _date = TextEditingController();
  TextEditingController _selectedtimeFrom = TextEditingController();
  TextEditingController _selectedtimeTo = TextEditingController();
  TextEditingController noOfHours = TextEditingController();
  int hours=0,minutes =0;

  TimeOfDay? timeFrom, timeTo;
  
  String _cartTag = "";
  int userId = 0;
  bool _loading = true;
  String _cartMessage = '';


  void _updateSecondTimePicker(TimeOfDay newTime) {
    if (timeFrom != null && newTime != null && newTime.hour < timeFrom!.hour) {
      showSnackBar(
          title: 'Invalid Time',
          message: 'Please enter a time after ${timeFrom!.format(context)}');
      newTime = TimeOfDay(hour: timeFrom!.hour, minute: newTime.minute);
    }
    if (timeFrom != null &&
        newTime != null &&
        newTime.hour == timeFrom!.hour &&
        newTime.minute < timeFrom!.minute) {
      newTime = TimeOfDay(hour: timeFrom!.hour, minute: timeFrom!.minute);
    }
    DateTime parsedTime =
        DateFormat.Hm().parse(newTime.format(context).toString());

    String formattedTime = DateFormat('h:mm a').format(parsedTime);

    setState(() {
      _selectedtimeTo.text = formattedTime;
      calculateHours(_selectedtimeFrom.text, formattedTime);
      checkDateTimeAvailability(widget.table.id, _selectedtimeFrom.text, formattedTime);
    });
  }

  
  Future<void> addCart(TableModel table, String totalPrice, String date, String timeFrom, String timeTo) async{
    userId = await getUserId();

    ApiResponse response = await addTableToCart(table, totalPrice, date, timeFrom, timeTo);
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
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: buildAppBar(context),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: size.height,
              child: Stack(
                children: [
                  Container(
                    padding: EdgeInsets.only(bottom: 20),
                    height: size.height * 0.4,
                    color: Colors.white,
                    child: Hero(
                      tag: '${widget.table.id}',
                      child: Image.network(
                        widget.table.image,
                         fit: BoxFit.fill
                      ),
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.only(top: size.height * 0.3),
                      height: size.height,
                      decoration: BoxDecoration(
                          color: Colors.grey[900],
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(40),
                              topRight: Radius.circular(40))),
                      child: Padding(
                        padding: EdgeInsets.only(left: 25, right: 40, top: 40),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.table.table_name,
                              style: TextStyle(
                                  fontSize: 30,
                                  letterSpacing: 1,
                                  color: Colors.white),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text("No of seats: ${widget.table.table_seats}",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white.withOpacity(0.8))),
                            SizedBox(height: 30),
                            Text("PRICE: Rs. ${widget.table.price} /hr",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white)),
                            SizedBox(
                              height: 10,
                            ),
                            Divider(
                              color: Colors.white.withOpacity(0.5),
                            ),
                            Container(
                              height: 110,
                              child: Column(
                                children: [
                                  Flexible(
                                    child: TextField(
                                      controller: _date,
                                      style: TextStyle(color: Colors.white),
                                      decoration: InputDecoration(
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.white),
                                        ),
                                        icon: Icon(Icons.calendar_month_sharp,
                                            color: Colors.white),
                                        labelText: "Select Date",
                                        labelStyle:
                                            TextStyle(color: Colors.white),
                                      ),
                                      readOnly: true,
                                      onTap: () async {
                                        DateTime? pickeddate =
                                            await showDatePicker(
                                                context: context,
                                                initialDate: DateTime.now(),
                                                firstDate: DateTime.now(),
                                                lastDate: DateTime(2024));
                                        if (pickeddate != null) {
                                          setState(() {
                                            _date.text =
                                                DateFormat('dd-MM-yyyy')
                                                    .format(pickeddate);
                                          });
                                        }
                                      },
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Flexible(
                                        child: TextField(
                                            controller: _selectedtimeFrom,
                                            style:
                                                TextStyle(color: Colors.white),
                                            decoration: InputDecoration(
                                              enabledBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.white),
                                              ),
                                              icon: Icon(
                                                  Icons.calendar_month_sharp,
                                                  color: Colors.white),
                                              labelText: "Select Time",
                                              labelStyle: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            readOnly: true,
                                            onTap: () async {
                                              timeFrom = (await showTimePicker(
                                                initialEntryMode:
                                                    TimePickerEntryMode.dial,
                                                context: context,
                                                initialTime: TimeOfDay.now(),
                                                builder:
                                                    (context, Widget? child) {
                                                  return MediaQuery(
                                                    data: MediaQuery.of(context)
                                                        .copyWith(
                                                            alwaysUse24HourFormat:
                                                                false),
                                                    child: child!,
                                                  );
                                                },
                                              ))!;
                                              if (timeFrom != null) {
                                                try {
                                                  DateTime parsedTime =
                                                      DateFormat.Hm().parse(
                                                          timeFrom!
                                                              .format(context)
                                                              .toString());
                                                  String formattedTime =
                                                      DateFormat('h:mm a')
                                                          .format(parsedTime);

                                                  setState(() {
                                                    _selectedtimeFrom.text =
                                                        formattedTime;
                                                  });
                                                } on FormatException catch (_, e) {
                                                  print(
                                                      "Error parsing timeFrom string: ${e.toString()}");
                                                }
                                              }
                                            }),
                                      ),
                                      Flexible(
                                        child: TextField(
                                            controller: _selectedtimeTo,
                                            style:
                                                TextStyle(color: Colors.white),
                                            decoration: InputDecoration(
                                              enabledBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.white),
                                              ),
                                              icon: Icon(
                                                  Icons.calendar_month_sharp,
                                                  color: Colors.white),
                                              labelText: "Select Time",
                                              labelStyle: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            readOnly: true,
                                            onTap: () async {
                                              timeTo = (await showTimePicker(
                                                initialEntryMode:
                                                    TimePickerEntryMode.dial,
                                                context: context,
                                                initialTime: TimeOfDay.now(),
                                                builder:
                                                    (context, Widget? child) {
                                                  return MediaQuery(
                                                    data: MediaQuery.of(context)
                                                        .copyWith(
                                                            alwaysUse24HourFormat:
                                                                false),
                                                    child: child!,
                                                  );
                                                },
                                              ))!;
                                              if (timeTo != null) {
                                                try {
                                                  setState(() {
                                                    _updateSecondTimePicker(
                                                        timeTo!);
                                                  });
                                                } on FormatException catch (_, e) {
                                                  print(
                                                      "Error parsing timeTo string: ${e.toString()}");
                                                }
                                              }
                                            }),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            SizedBox(height: 30,),
                            noOfHours.text.isNotEmpty ?Container(
                                  width: double.infinity,
                                  margin: EdgeInsets.all(16.0),
                                  padding: EdgeInsets.all(16.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                     Text("No of hours: $hours",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w300,
                                          color: Colors.white)),
                                            SizedBox(height: 8.0),
                                       
                                      Text("TOTAL PRICE: Rs."+ noOfHours.text,
                                          style: TextStyle(
                                              fontSize: 25,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.white))
                                              ],
                                            ),
                                          ) 
                              : SizedBox.shrink(),
                              SizedBox(height:10),
                              noOfHours.text.isNotEmpty ?Center(
                                child: Container(
                                      padding: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
                                      decoration: BoxDecoration(
                                        color: Color.fromARGB(255, 50, 54, 56),
                                        borderRadius: BorderRadius.circular(18)
                                      ),
                                     
                                      child:
                                              TextButton(
                                                      child: Text('Add to Cart', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold, letterSpacing: 1)),
                                                      onPressed:  (){
                                                        // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx) => CartScreen()));
                                                         addCart(widget.table, noOfHours.text, _date.toString(), _selectedtimeFrom.toString(), _selectedtimeTo.toString());
                                                        }
                                                      )
                                    ),
                              ):SizedBox.shrink(),
                           
                          ],
                        ),
                      )),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  buildAppBar(context) {
    return AppBar(
      backgroundColor: Colors.black,
      actions: [
        Padding(
          padding: const EdgeInsets.only(
              right: defaultPadding, left: defaultPadding),
          child: Center(
            child: Badge(
              badgeStyle: BadgeStyle(badgeColor: Color(0xffe57734)),
              badgeContent: Consumer<HomeController>(
                builder: (context, value, child) {
                  return Text(value.getCounter().toString(),
                      style: TextStyle(color: Colors.white));
                },
              ),
              child: IconButton(
                icon: Icon(
                  Icons.shopping_bag_outlined,
                  size: 30,
                ),
                color: Colors.white,
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (ctx) => CartScreen()));
                },
              ),
            ),
          ),
        )
      ],
    );
  }

  void checkDateTimeAvailability(table_id, String timeFrom, String timeTo)  async {
   
    ApiResponse response = await getTableDetails(table_id, timeFrom, timeTo, _date.text);
    
    if (response.error == null) {
      print(response.data);
      print("Hello");
      if(response.data != null)
      {
        print("Time and date available");
        //Show the add to cart button
      }
      else{
        showSnackBar(title: '',message: 'The Time slot is not available');
      }
    } else if (response.error == ApiConstants.unauthorized) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => Login()), (route) => false);
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${response.error}')));
    }
  }

   void calculateHours(String timeString1, String timeString2) {
      // Parse the time strings into DateTime objects
      DateTime time1 = DateFormat('h:mm a').parse(timeString1);
      DateTime time2 = DateFormat('h:mm a').parse(timeString2);

      // Calculate the duration between the two DateTime objects
      Duration difference = time2.difference(time1);

      // Get the difference in hours
      hours = difference.inHours;

      // Get the difference in hours
      minutes = difference.inMinutes.remainder(60);
      print('The difference between $timeString1 and $timeString2 is $hours hours and $minutes minutes');
      if (minutes > 0) {
        hours += 1;
      }
      else if(hours == 0)
      {
        hours = 1;
      }
      noOfHours.text = (hours* widget.table.price).toString();
      // print('The difference between $timeString1 and $timeString2 is $hours hours and $minutes minutes');
   }
}
