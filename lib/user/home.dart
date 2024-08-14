

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:green_clean_bangladesh/user/dustbin_locations.dart';
import 'package:green_clean_bangladesh/user/login.dart';
import 'package:green_clean_bangladesh/user/pick_up_request.dart';
import 'package:green_clean_bangladesh/user/profile.dart';
import 'package:green_clean_bangladesh/user/schedule_page.dart';
import 'package:green_clean_bangladesh/user/tips_and_guidelines.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../admin/create_tips_guidelines.dart';
import '../utils/common_methods.dart';
import '../utils/shared_preference.dart';
import '../utils/strings.dart';
import '../widgets/nav_bar.dart';
import 'opinion_center.dart';

class Home_Page extends StatefulWidget {
  const Home_Page({super.key});

  @override
  State<Home_Page> createState() => _Home_PageState();
}

class _Home_PageState extends State<Home_Page> {

  final DatabaseReference _database = FirebaseDatabase(
      databaseURL: Strings.database_url
  ).reference();
  bool is_picture_loaded = false;
  String? image_link;
  String? area;
  String schedule = 'Loading..';
  bool is_loaded = true;
  bool is_loaded_pic = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get_profile_image();
    get_schedule();
  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
          bottomNavigationBar: Navbar(),
          body: Center(
            child: Column(
              children: [
                SizedBox(height: size.height*0.05,),
                Container(
                  width: size.width*0.9,

                  //First Line of the page
                  child: Row(
                    children: [
                      Container(
                        width: size.width*0.9*0.6,
                        child: RichText(
                            text: TextSpan(
                              style:  DefaultTextStyle.of(context).style,
                              children: <TextSpan>[
                                TextSpan(
                                  text: 'Dashboard',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black, // Set the color for "Welcome"
                                      fontSize: size.width*0.08,
                                      decoration: TextDecoration.none,


                                  ),
                                ),
                                TextSpan(
                                  text: '',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF00A669), // Set the color for "Back"
                                    fontSize: size.width*0.08,
                                    decoration: TextDecoration.none,
                                  ),
                                ),
                              ],
                            )
                        ),
                      ),

                      SizedBox(width: size.width*0.9*0.15,),

                      Skeletonizer(
                        enabled: is_loaded_pic,
                        child: InkWell(
                          onTap: (){
                            Get.to(Profile());
                          },
                          child: Container(
                            width: size.width*0.9*0.25,
                            child: is_picture_loaded ?
                            CircleAvatar(
                              backgroundImage: NetworkImage(image_link!),
                              backgroundColor: Colors.transparent,
                              radius: size.width * 0.12,
                            )
                                : Image.asset('assets/images/gcb.png'),
                          ),
                        ),
                      )


                    ],
                  ),
                ),

                SizedBox(height: size.height*0.05,),

                Skeletonizer(
                  enabled: is_loaded,
                  child: Card(
                    elevation: 30,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                    ),
                    child: InkWell(
                      onTap: () {
                        Get.to(Schedule_Page());
                      },
                      child: Container(
                        width: size.width*0.9,
                        color: Color(0xFF00A669),
                        child: Center(
                          child: Column(
                            children: [
                              SizedBox(height: size.height*0.02,),
                              Text("Today's Time Schedule", style: TextStyle(color: Colors.white, fontSize: size.width*0.9*0.07, fontWeight: FontWeight.bold),),
                              Text(schedule, style: TextStyle(color: Colors.white, fontSize: size.width*0.9*0.05),),
                              SizedBox(height: size.height*0.02,)
                            ],
                          ),
                        ),

                      ),
                    ),
                  ),
                ),

                SizedBox(height: size.height*0.1,),

                Container(
                  width: size.width*0.9,
                  child: Row(
                    children: [
                      Column(
                        children: [
                          Card(
                            elevation: 20,
                            child: InkWell(
                              onTap: () {

                                Get.to(Pickup_Request());
                              },
                              child: Container(
                                width: size.width*0.9*0.44,
                                height: size.height*0.15,
                                color: Color(0xFF00A669),
                                child: Column(
                                  children: [
                                    SizedBox(height: size.height*0.15*0.1,),
                                    Icon(
                                      Icons.local_shipping, // You can choose a different icon that represents pickup
                                      color: Colors.white,
                                      size: size.width*0.9*0.44*0.4, // Customize the color as needed
                                    ),
                                    Text("Pick up request", style: TextStyle(color: Colors.white, fontSize: size.width*0.9*0.44*0.1, fontWeight: FontWeight.bold),)
                                  ],
                                ),
                              ),
                            ),


                          ),

                          SizedBox(height: size.height*0.02,),

                          Card(
                            elevation: 20,
                            child: InkWell(
                              onTap: () {
                                Get.to(Opinion_Center());
                              },
                              child: Container(
                                width: size.width*0.9*0.44,
                                height: size.height*0.15,
                                color: Color(0xFF00A669),
                                child: Column(
                                  children: [
                                    SizedBox(height: size.height*0.15*0.1,),
                                    Icon(
                                      Icons.forum, // You can choose a different icon that represents pickup
                                      color: Colors.white,
                                      size: size.width*0.9*0.44*0.4, // Customize the color as needed
                                    ),
                                    Text("Openion Center", style: TextStyle(color: Colors.white, fontSize: size.width*0.9*0.44*0.1, fontWeight: FontWeight.bold),)
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),

                      SizedBox(width: size.width*0.9*0.06,),

                      Column( 	children: [
                        Card(
                          elevation: 20,
                          child: InkWell(
                            onTap: () {

                             Get.to(Dustbin_Locations());
                            },
                            child: Container(   width: size.width*0.9*0.44,
                              height: size.height*0.15,
                              color: Color(0xFF00A669),
                              child:  Column(
                                children: [
                                  SizedBox(height: size.height*0.15*0.1,),
                                  Icon(
                                    Icons.delete, // You can choose a different icon that represents pickup
                                    color: Colors.white,
                                    size: size.width*0.9*0.44*0.4, // Customize the color as needed
                                  ),
                                  Text("Dustbin Locations", style: TextStyle(color: Colors.white, fontSize: size.width*0.9*0.44*0.1, fontWeight: FontWeight.bold),)
                                ],
                              ),),
                          ),

                        ),

                        SizedBox(height: size.height*0.02,),

                        Card(
                          elevation: 20,
                          child: InkWell(
                            onTap: () {
                              Get.to(Tips_and_Guidelines(role: 'User',));
                              //Get.to(Create_Tips_Guidelines());
                            },
                            child: Container(   width: size.width*0.9*0.44,
                              height: size.height*0.15,
                              color: Color(0xFF00A669),
                              child: Column(
                                children: [
                                  SizedBox(height: size.height*0.15*0.1,),
                                  Icon(
                                    Icons.list_alt, // You can choose a different icon that represents pickup
                                    color: Colors.white,
                                    size: size.width*0.9*0.44*0.4, // Customize the color as needed
                                  ),
                                  Text("Tips and Guidelines", style: TextStyle(color: Colors.white, fontSize: size.width*0.9*0.44*0.1, fontWeight: FontWeight.bold),)
                                ],
                              ),
                            ),
                          ),
                        ),

                      ],)
                    ],
                  ),
                )
              ],
            ),
          ),
        )

    );
  }

  void goto_login_page(BuildContext context) async {
    await Shared_Prefference_Class.init();
    await Shared_Prefference_Class.set_Login_Status(false);
    //await print(Shared_Prefference_Class.get_OnBoarding_Status().toString());
    // Navigator.of(context).pushReplacement(
    //   MaterialPageRoute(builder: (_) => Login_Page()),
    // );
    Get.offAll(Login_Page());
  }

  void get_profile_image() {

    _database.child('Users/${Common_Methods().get_uid()}/').onValue.listen((DatabaseEvent event) {
      final data = event.snapshot.value;
      print(Common_Methods().get_uid());
      if(data != null) {
        setState(() {
          is_loaded_pic = false;
          image_link = event.snapshot.child('Profile_Image').value.toString();
          area = event.snapshot.child('Area').value.toString();
          is_picture_loaded = true;
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

    _database.child('Schedule/${area}/${Common_Methods().get_current_day()}/').onValue.listen((DatabaseEvent event) {
      final data = event.snapshot.value;
      print(Common_Methods().get_uid());
      if(data != null) {
        setState(() {
          is_loaded = false;
          schedule = data.toString();
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
