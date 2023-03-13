import 'package:flutter/material.dart';

import 'package:cafe_app/constraints/constants.dart';
import 'package:cafe_app/controllers/home_controller.dart';
import 'package:provider/provider.dart';
import '../api/apiFile.dart';
import '../services/api_response.dart';
import '../services/conference_service.dart';
import '../services/table_service.dart';
import '../services/user_service.dart';
import '../widgets/custom_widgets.dart';
import 'cartscreen.dart';
import 'package:badges/badges.dart';
import 'package:intl/intl.dart';
import 'login.dart';

class ConferenceScreen extends StatefulWidget {
  ConferenceScreen({super.key});
  @override
  State<ConferenceScreen> createState() => _ConferenceScreenState();
}

class _ConferenceScreenState extends State<ConferenceScreen> {
  
  TextEditingController _date = TextEditingController();
  TextEditingController _selectedtimeFrom = TextEditingController();
  TextEditingController _selectedtimeTo = TextEditingController();
  
  TimeOfDay? timeFrom, timeTo;

  

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
      // calculateHours(_selectedtimeFrom.text, formattedTime);
      // checkDateTimeAvailability(widget.table.id, _selectedtimeFrom.text, formattedTime);
    });
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
              SizedBox(height: size.height,
              child: Stack(
                children: [
                  Container(
                    padding: EdgeInsets.only(bottom: 20),
                    height: size.height *0.4,
                    color: Colors.white,
                    child:  Hero(
                      tag: '',
                      child: Image.asset(
                                   "Assets/Images/cafe3.jpg",
                                   fit: BoxFit.fill
                                  ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: size.height *0.3),
                    height: size.height ,
                    decoration: BoxDecoration(
                      color: Colors.grey[900],
                      borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(40), 
                              topRight: Radius.circular(40))
                    ),
                    child:               
                    Padding(
                          padding: EdgeInsets.only(left: 25, right: 40, top: 40),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                              "Conference Hall",
                                style: TextStyle(
                                  fontSize: 30,
                                  letterSpacing: 1,
                                  color: Colors.white
                                ),
                              ),
                              SizedBox(height: 10,),
                              Row(
                                children: [
                                  Icon(Icons.star, color: Colors.grey[600], size: 20,),
                                  Icon(Icons.star, color: Colors.grey[600], size: 20),
                                  Icon(Icons.star, color: Colors.grey[600], size: 20),
                                  Icon(Icons.star, color: Colors.grey[600], size: 20),
                                  Icon(Icons.star, color: Colors.grey[600], size: 20),
                                ],
                              ),
                              SizedBox(height: 20,),

                              Text("No of seats: ",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight : FontWeight.w500,
                                    color: Colors.white.withOpacity(0.8)
                                  )
                              ),
                              SizedBox(height: 20),
                              Text("PRICE: Rs. ",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                        color : Colors.white  
                                      )),

                              SizedBox(height: 50,),
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
                            
                              SizedBox(height: 70,),
                              Container(
                                width: MediaQuery.of(context).size.width,
                            
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
                                      decoration: BoxDecoration(
                                        color: Color.fromARGB(255, 50, 54, 56),
                                        borderRadius: BorderRadius.circular(18)
                                      ),
                                     
                                      child:
                                              TextButton(
                                                      child: Text('Book Conference Hall', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold, letterSpacing: 1)),
                                                      onPressed:  (){
                                                        // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx) => CartScreen()));
                                                        checkAvailability(_date.toString(),_selectedtimeFrom.toString(),_selectedtimeTo.toString());
                                                        }
                                                      )
                                    ),
                                    
                                    
                                  ],
                                ),
                              )
                            ],
                          ),
                        )
                  ),
                 
                ],
              ),
              )
            ],
          ),
        ),
     
    );
  }
}


  buildAppBar(context) {
    return AppBar(
          backgroundColor: Colors.black,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right:defaultPadding, left: defaultPadding),
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

          ],
        );
  }

void _loadUserInfo(context) async{
  String token = await getToken();

  if(token == ''  || token == null)
  {
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>Login()), (route) => false);
  }
  else{
    ApiResponse response = await getUserDetails();
    print(response.data);
    if(response.error == null)
    {
      
    }
    else if(response.error == ApiConstants.unauthorized)
    {
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>Login()), (route) => false);
    }
    else
    {
     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('${response.error}')
      ));
    }
  }
}

  void checkAvailability(String date, String timeFrom, String timeTo)  async {
   
    ApiResponse response = await getConferenceHallDetails(date, timeFrom, timeTo);
    
    if (response.error == null) {
      print(response.data);
      print("Hello");
      if(response.data != null)
      {
        print("Conference Hall available");
        //Show the add to cart button
      }
      else{
        showSnackBar(title: '',message: 'The Time slot is not available');
      }
    } else if (response.error == ApiConstants.unauthorized) {
      showSnackBar(title: '',message: 'An error occurred');
    } else {
     showSnackBar(title: '',message: 'An error occurred');
    }
  }
// void _showTimePicker(context)
// {
//   showTimePicker(
//     context: context, 
//     initialTime: TimeOfDay.now(),
//   );
// }
  
