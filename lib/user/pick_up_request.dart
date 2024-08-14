

import 'package:colorful_circular_progress_indicator/colorful_circular_progress_indicator.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_clean_bangladesh/widgets/nav_bar.dart';
import 'package:intl/intl.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../utils/common_methods.dart';
import '../utils/strings.dart';

class Pickup_Request extends StatefulWidget {
  const Pickup_Request({super.key});

  @override
  State<Pickup_Request> createState() => _Pickup_RequestState();
}

class _Pickup_RequestState extends State<Pickup_Request> {

  late TextEditingController? _date;
  late TextEditingController? note;
  var hour = 0;
  var minute = 0;
  String date = 'Not Date Selected yet!';
  String time = 'Not Time Selected yet!';
  bool is_available = false;
  final DatabaseReference _database = FirebaseDatabase(
      databaseURL: Strings.database_url
  ).reference();
  String? location;
  String? mobile;
  String? area;
  String? name;
  String? time_value;
  bool is_clicled = true;
  String date_value = 'loading..';
  String times_value = 'loading..';
  String note_value = 'loading..';
  String status_value = 'loading..';
  bool is_loaded = true;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get_profile_info();
    _date = TextEditingController();
    note = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _date!.dispose();
    note!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SafeArea(
        child: Scaffold(
          bottomNavigationBar: Navbar(),
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: size.height*0.02,),

                Row(
                  children: [
                    InkWell(
                      onTap: () {

                        Get.back();
                      },
                      child: Container(
                        height: size.height * 0.04,
                        width: size.width * 0.1,
                        //color: Colors.green,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Icon(Icons.arrow_back_sharp, size: size.height * 0.045,),
                        ),
                      ),
                    ),
                  ],
                ),

                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Container(
                        width: size.width*0.8,
                        child: Row(
                          children: [
                            Text("Pickup ", style: TextStyle(fontSize: size.width*0.8*0.10, fontWeight: FontWeight.bold, color: Colors.black),),
                            Text("Request", style: TextStyle(fontSize: size.width*0.8*0.10, fontWeight: FontWeight.bold, color: Color(0xFF00A669),),)
                          ],
                        ),
                      ),
                    ),
                  ],
                ),


                SizedBox(height: size.height*0.07,),

                Container(
                  width: size.width * 0.8,
                  height: size.height*0.1, // 80% of the screen width
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(color: Colors.black), // Customize border color if needed
                  ),
                  child: TextField(
                    controller: note,
                    decoration: InputDecoration(
                      hintText: 'Note',
                      contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                      border: InputBorder.none,
                    ),
                  ),
                ),

                SizedBox(height: size.height*0.03,),


                Container(
                  width: size.width * 0.8,
                  height: size.height * 0.05,
                  //color: Colors.green,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      TextButton(
                          style: TextButton.styleFrom(
                            primary: Colors.white, // Text color
                            backgroundColor: Color(0xFF00A669), // Background color
                          ),
                          onPressed: () async {
                            DateTime? pickeddate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2000),
                                lastDate: DateTime(2101)
                            );


                            if(pickeddate != null){
                              setState(() {
                                _date!.text = DateFormat('dd-MM-yy').format(pickeddate);
                                print(_date!.text);
                                date = 'Pickup Date: '+_date!.text;
                              });
                            }


                          },
                          child: Text(' Select Date ')
                      ),
                      Text(date,
                        style: TextStyle(fontSize: size.height * 0.022),
                      ),

                    ],
                  ),

                ),


                SizedBox(height: size.height*0.03,),


                Container(
                  width: size.width * 0.8,
                  height: size.height * 0.05,
                  //color: Colors.green,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      TextButton(
                          style: TextButton.styleFrom(
                            primary: Colors.white, // Text color
                            backgroundColor: Color(0xFF00A669), // Background color
                          ),
                          onPressed: () async {
                            final TimeOfDay? picked = await showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.now(),
                            );


                            if(picked != null){
                              setState(() {
                                print('Selected Time: ${picked.hour}:${picked.minute}');
                                if(picked.hour>12) {
                                  time = 'Pickup Time: ${picked.hour-12}:${picked.minute} pm';
                                  time_value = '${picked.hour-12}:${picked.minute} pm';
                                }
                                else {
                                  time = 'Pickup Time: ${picked.hour}:${picked.minute} am';
                                  time_value = '${picked.hour}:${picked.minute} am';
                                }
                                //time = picked.toString();
                              });
                            }


                          },
                          child: Text(' Select Time ')
                      ),
                      Text(time,
                        style: TextStyle(fontSize: size.height * 0.022),
                      ),

                    ],
                  ),

                ),



                SizedBox(height: size.height*0.05,),

                Container(
                  width: size.width*0.8,
                  decoration: BoxDecoration(
                    color: Color(0xFF00A669), // Green color
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: TextButton(
                      onPressed:  () {

                        showConfirmationDialog(context);

                        setState(() {
                          is_clicled = false;
                        });

                         submit_request();

                      },
                      child: Text("Submit Request", style: TextStyle(color: Colors.white, fontSize: size.width*0.8*0.06),)
                  ),
                  //     :
                  // const Center(
                  //   child: CircularProgressIndicator(color: Colors.white,),
                  // ),
                ),


                SizedBox(height: size.height*0.05,),


                Card(
                  elevation: 20,
                  child: Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Skeletonizer(
                      enabled: is_loaded,
                      child: Container(
                        width: size.width*0.8,
                        height: size.height*0.17,
                        child: is_available ? Column(
                          children: [
                            Row(
                                children: [
                                  Expanded(child: Text("Previous Request: \n", style: TextStyle(
                                    fontSize: size.height * 0.03,
                                    fontWeight: FontWeight.w700
                                  ),)), ]
                            ),
                            Row(
                                children: [
                                  Text("Requested for: ", style: TextStyle(fontWeight: FontWeight.w700,
                                  fontSize: size.height * 0.02),), Text("$date_value at "), Text(times_value)]
                            ),
                            Row(
                                children: [
                                  Text("Note:", style: TextStyle(fontWeight: FontWeight.w700),),
                                  Expanded(child: Text(" $note_value")),
                                ]
                            ),
                            Row(
                                children: [
                                  Text("Status: ", style: TextStyle(fontWeight: FontWeight.w700),),
                                  Text(status_value, style: TextStyle(fontWeight: FontWeight.w700,
                                      color: (status_value=='Pending') ? Colors.deepOrange : Color(0xFF00A669),
                                  ),)
                                ]
                            ),
                          ],
                        ) :
                        Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('No Request yet!', style: TextStyle(fontSize: size.height * 0.03),),
                                Text('Request a Pickup from above!', style: TextStyle(fontSize: size.height * 0.02),),
                              ],
                            ),
                        ),
                      ),
                    ),
                  ),
                ),



              ],
            ),
          ),

        ),
    );
  }


  void get_profile_info() {

    _database.child('Users/${Common_Methods().get_uid()}/').onValue.listen((DatabaseEvent event) {
      final data = event.snapshot.value;
      print(Common_Methods().get_uid());
      if(data != null) {
        setState(() {
          location = event.snapshot.child('Location').value.toString();
          mobile = event.snapshot.child('Mobile').value.toString();
          area = event.snapshot.child('Area').value.toString();
          name = event.snapshot.child('Name').value.toString();
          print(location);
          print(mobile);
          get_req_info();
          //is_picture_loaded = true;
        });
        print(data.toString());
        //get_schedule();
      }
      else {
        print('else:   ');
        print(data.toString());
      }

    });
  }

  void get_req_info() {

    _database.child('Pick_Up_Request/$area/${Common_Methods().get_uid()}/').onValue.listen((DatabaseEvent event) {
      final data = event.snapshot.value;
      print(Common_Methods().get_uid());
      if(data != null) {
        setState(() {
          is_available = true;
          is_loaded = false;
          date_value = event.snapshot.child('Req_Date').value.toString();
          status_value = event.snapshot.child('Status').value.toString();
          times_value = event.snapshot.child('Time').value.toString();
          note_value = event.snapshot.child('Note').value.toString();
          print(location);
          print(mobile);
          //is_picture_loaded = true;
        });
        print(data.toString());
        //get_schedule();
      }
      else {
        is_loaded = false;
        print('else:   ');
        print(data.toString());
        setState(() {
          is_available = false;
        });
      }

    });
  }

  void submit_request() {

    _database.child('Pick_Up_Request/$area/${Common_Methods().get_uid()}/').set(
        {
          'Location': location,
          'Mobile': mobile,
          'Req_Date': _date!.text,
          'Time': time_value,
          'Status': 'Pending',
          'U_ID': Common_Methods().get_uid(),
          'Note': note!.text,
          'Name': name,

        }).then((value) {
          setState(() {
            is_clicled = true;

            Navigator.of(context).pop();


          });
    });
  }

  Future<void> showConfirmationDialog(BuildContext context) async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Submitting Request'),
          content: Text('Please wait for a moment.'),
          actions: <Widget>[
            SizedBox(height: 10,),
            Center(
                child: ColorfulCircularProgressIndicator(
                  colors: [Color(0xFF00A669)],
                  strokeWidth: 5,
                  indicatorHeight: 40,
                  indicatorWidth: 40,
                )),
          ],
        );
      },
    );
  }



}
