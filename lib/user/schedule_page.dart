
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:green_clean_bangladesh/widgets/nav_bar.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../utils/common_methods.dart';
import '../utils/strings.dart';

class Schedule_Page extends StatefulWidget {
  const Schedule_Page({super.key});

  @override
  State<Schedule_Page> createState() => _Schedule_PageState();
}

class _Schedule_PageState extends State<Schedule_Page> {

  String sat = 'loading..';
  String sun = 'loading..';
  String mon = 'loading..';
  String tue = 'loading..';
  String wed = 'loading..';
  String thu = 'loading..';
  String fri = 'loading..';
  String? area;
  final DatabaseReference _database = FirebaseDatabase(
      databaseURL: Strings.database_url
  ).reference();
  bool is_loaded = true;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get_area();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return SafeArea(
        child: Scaffold(
          bottomNavigationBar: Navbar(),
          body: Column(
            children: [

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  //mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    SizedBox(
                      height: height * 0.08,
                    ),

                    InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: Container(
                        height: height * 0.045,
                        width: width * 0.1,
                        //color: Colors.green,
                        child: Icon(Icons.arrow_back_sharp, size: height * 0.045,),
                      ),
                    ),

                    Container(
                      height: height * 0.045,
                      width: width * 0.05,
                      //color: Colors.orange,
                      child: Text(''),
                    ),

                    Row(
                      children: [
                        Container(
                          width: width*0.7,
                          child: Row(
                            children: [
                              Text("Schedule ", style: TextStyle(fontSize: width*0.8*0.10, fontWeight: FontWeight.bold, color: Colors.black),),
                              Text("Time", style: TextStyle(fontSize: width*0.8*0.10, fontWeight: FontWeight.bold, color: Color(0xFF00A669),),)
                            ],
                          ),
                        ),
                      ],
                    ),

                  ],
                ),
              ),


              SizedBox(height: height * 0.03,),



           Padding(
             padding: const EdgeInsets.only(left: 10, right: 10),
             child: Container(
               height: height * 0.75,
               width: width * 1,
               child: Skeletonizer(
                   enabled: is_loaded,
                 child: ListView(
                   children: [

                     get_tile(height, 'Saturday :', sat),
                     SizedBox(height: height* 0.02,),

                     get_tile(height, 'Sunday :', sun),
                     SizedBox(height: height* 0.02,),

                     get_tile(height, 'Monday :', mon),
                     SizedBox(height: height* 0.02,),

                     get_tile(height, 'Tuesday :', tue),
                     SizedBox(height: height* 0.02,),

                     get_tile(height, 'Wednesday :', wed),
                     SizedBox(height: height* 0.02,),

                     get_tile(height, 'Thursday :', thu),
                     SizedBox(height: height* 0.02,),

                     get_tile(height, 'Friday :', fri),

                   ],
                 ),
               ),
             ),
           ),

            ],
          ),
        ),
    );
  }

  Widget get_tile(var height, String day, String value) {

    return Container(
      //color: Colors.green,
      child: Card(
        color: Color(0xFF00A669),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        elevation: 5.0,
        child: ListTile(
          title: Text(day, style: TextStyle(
              fontSize: height * 0.025,
              fontWeight: FontWeight.w600,
              color: Colors.white
          ),),
          trailing: Text(value, style: TextStyle(
              fontSize: height * 0.023,
              fontWeight: FontWeight.w400,
              color: Colors.white
          ),),
        ),
      ),
    );
  }

  void get_area() {

    _database.child('Users/${Common_Methods().get_uid()}/Area').onValue.listen((DatabaseEvent event) {
      final data = event.snapshot.value;
      print(Common_Methods().get_uid());
      if(data != null) {
        setState(() {
          area = data.toString();

        });
        print(data.toString());
        get_schedule();
      }
      else {
        print('else:   ');
        print(data.toString());
      }

    });
  }

  void get_schedule() {

    _database.child('Schedule/${area}/').onValue.listen((DatabaseEvent event) {
      final data = event.snapshot.value;
      print(Common_Methods().get_uid());
      if(data != null) {
        setState(() {
          is_loaded = false;
          sat = event.snapshot.child('Saturday').value.toString();
          sun = event.snapshot.child('Sunday').value.toString();
          mon = event.snapshot.child('Monday').value.toString();
          tue = event.snapshot.child('Tuesday').value.toString();
          wed = event.snapshot.child('Wednesday').value.toString();
          thu = event.snapshot.child('Thursday').value.toString();
          fri = event.snapshot.child('Friday').value.toString();
        });
        print(data.toString());
      }
      else {
        print('else:   ');
        print(data.toString());
      }

    });
  }


}
