

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:green_clean_bangladesh/utils/pickup_model.dart';
import 'package:green_clean_bangladesh/utils/strings.dart';
import 'package:green_clean_bangladesh/widgets/admin_nav_bar.dart';

import '../utils/common_methods.dart';

class Manage_Request extends StatefulWidget {
  const Manage_Request({super.key});

  @override
  State<Manage_Request> createState() => _Manage_RequestState();
}

class _Manage_RequestState extends State<Manage_Request> {

  String? selectedLocation;
  String name = 'loading..';
  String mobile = 'loading..';
  String date = 'loading..';
  String time = 'loading..';
  String location = 'loading..';
  String note = 'loading..';
  bool is_avialable = false;
  final DatabaseReference _database = FirebaseDatabase(
      databaseURL: Strings.database_url
  ).reference();
  List<Pickup_Model> items = [];
  bool is_empty = false;

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;


    return SafeArea(
        child: Scaffold(
          bottomNavigationBar: Admin_Navbar(),
          body: Column(
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
                          Text("Manage ", style: TextStyle(fontSize: size.width*0.8*0.10, fontWeight: FontWeight.bold, color: Colors.black),),
                          Text("Request", style: TextStyle(fontSize: size.width*0.8*0.10, fontWeight: FontWeight.bold, color: Color(0xFF00A669),),)
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: size.height*0.05,),

// Container for Dropdown List
              Container(
                //color: Colors.green,
                width: size.width*0.9,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    Container(
                      width: size.width*1 * 0.5,
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      decoration: BoxDecoration(
                        //color: Colors.green,
                        border: Border.all(color: Color(0xFF00A669)),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(top: 4, bottom: 4),
                        child: DropdownButton<String>(
                          isExpanded: true,
                          value: selectedLocation,
                          iconSize: 30,
                          hint: Text('Select Area'),
                          items: Strings.locations
                              .map((String item) =>
                              DropdownMenuItem<String>(child: Text(item), value: item))
                              .toList(),
                          onChanged: (value2) => setState(() {
                            this.selectedLocation = value2.toString();
                            //mn = get_project_code(value.toString());
                          }),
                          underline: Container(  // Set underline to Container with zero height
                            height: 0,
                            color: Colors.transparent,
                          ),
                        ),
                      ),
                    ),


                    SizedBox(width: size.width*0.8*0.08,),



                    Container(
                      width: size.width*0.8*0.4,
                      decoration: BoxDecoration(
                        color: Colors.green, // Green color
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: TextButton(
                          onPressed: () {
                            items.clear();
                            get_req_info();
                          },
                          child: Text("Search", style: TextStyle(color: Colors.white, fontSize: size.width*0.8*0.06),)
                      ),
                    ),


                  ],    ),
              ),

              SizedBox(height: size.height*0.03,),

              is_avialable ? Container(
                //width: size.width*0.8*0.4,
                child: Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: items.length,
                    itemBuilder: (context, index) {

                      return get_list(size,
                          items[index].name,
                          items[index].mobile,
                          items[index].location,
                          items[index].date,
                          items[index].time,
                          items[index].note,
                           index

                      );

                    }
                  ),
                ),
              ) :
              Column(
                //mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  Center(child: Image.asset('assets/images/empty-box.png', height: size.height* 0.5,)),

                  Container(
                    alignment: Alignment.center,
                    child: Center(
                      child: Text('There are no requests for now.',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                        ),),

                    ),
                  ),


                ],
              ),


              SizedBox(height: size.height*0.04,),





            ],
          ),

        ),
    );
  }

  Widget get_list(Size size, String name, String mobile, String location, String date, String time,String note,
      int index) {

    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15, bottom: 10),
      child: Card(
        elevation: 20,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: Container(
          width: size.width*0.8,
          decoration: BoxDecoration(
            color: Color(0xFF00A669),
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [

                Row(
                  children: [
                    Text("Request by: ", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                    Text('$name', style: TextStyle(color: Colors.white),)
                  ],
                ),

                Row(
                  children: [
                    Text("Request on: ", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                    Text('$date at $time', style: TextStyle(color: Colors.white),)
                  ],
                ),

                Row(
                  children: [
                    Text("Mobile: ", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                    Text('$mobile', style: TextStyle(color: Colors.white),)
                  ],
                ),

                Row(
                  children: [
                    Text("Location: ", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                    Text('$location', style: TextStyle(color: Colors.white),)
                  ],
                ),

                Row(
                  children: [
                    //Text("Note: ", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                    Expanded(child: Text('Note: $note', style: TextStyle(color: Colors.white),))
                  ],
                ),

                SizedBox(height: size.height*0.03),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      SizedBox(width: size.width*0.8*0.05,),
                      ElevatedButton(
                        onPressed: (){
                          showConfirmationDialog(context, items[index].uid);
                          //set_status(items[index].uid);
                        },
                        style: ElevatedButton.styleFrom(
                          fixedSize: Size(size.width*0.8*0.4, size.height*0.0005), // Set your desired width and height
                        ),
                        child: Text("Done"),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> showConfirmationDialog(BuildContext context, String uid) async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmation'),
          content: Text('The request has been completed?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                // Close the dialog and perform the action

                print('Yes Clicked!!');
                set_status(uid);
                Navigator.of(context).pop();
              },
              child: Text('Yes'),
            ),
            TextButton(
              onPressed: () {
                // Close the dialog
                print('No Clicked!!');
                Navigator.of(context).pop();
              },
              child: Text('No'),
            ),
          ],
        );
      },
    );
  }



  void get_req_info() {

    // _database.child('Pick_Up_Request/$selectedLocation/').once().
    // then((value) {
    //
    //   Map<dynamic, dynamic> values = value as Map;
    //
    //
    // });

    items.clear();
    _database.child('Pick_Up_Request/$selectedLocation/').onValue.listen((DatabaseEvent event) {
     final data1 = event.snapshot.value;

      print(Common_Methods().get_uid());
      if(event.snapshot.value != null) {

        Map data = data1 as Map;

        items.clear();
        for (var value in data.values) {
          if(value['Status'] == 'Pending') {
            items.add(Pickup_Model.fromJson(Map.from(value)));
          }
        }

        setState(() {
          is_avialable = true;
          print(location);
          print(mobile);
          //is_picture_loaded = true;
        });
        print(data.toString());

      }
      else {
        print('else:   ');
        //print(data.toString());
        setState(() {
          is_avialable = false;
        });

      }



    });
  }

  void set_status(String uid) {

    _database.child('Pick_Up_Request/$selectedLocation/$uid/').update({
      'Status': 'Done'
    });
  }





}
