

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../utils/common_methods.dart';
import '../utils/strings.dart';
import '../widgets/nav_bar.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  final DatabaseReference _database = FirebaseDatabase(
      databaseURL: Strings.database_url
  ).reference();
  bool is_picture_loaded = false;
  String image_link = 'a';
  String name = 'Loading..';
  String cell = 'Loading..';
  String email = 'Loading..';
  String area = 'Loading..';
  String location = 'Loading..';
  bool is_loaded = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDataFromFirebase();
  }


  @override
  Widget build(BuildContext context) {

    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    DateTime _dateTime = DateTime.now();


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
                            Text("User ", style: TextStyle(fontSize: width*0.8*0.10, fontWeight: FontWeight.bold, color: Colors.black),),
                            Text("Profile", style: TextStyle(fontSize: width*0.8*0.10, fontWeight: FontWeight.bold, color: Color(0xFF00A669),),)
                          ],
                        ),
                      ),
                    ],
                  ),

                ],
              ),
            ),

            SizedBox(
              height: height * 0.025,
            ),

            Skeletonizer(
              enabled: is_loaded,
              child: Container(
                height: height * 0.3,
                width: width * 1,
                //color: Colors.green,
                child: Center(
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(image_link),
                    backgroundColor: Colors.transparent,
                    radius: width * 0.28,
                  ),
                ),
              ),
            ),

            SizedBox(
              height: height * 0.05,
            ),

            Skeletonizer(
              enabled: is_loaded,
              child: Container(
                height: height * 0.06,
                width: width * 1,
                //color: Colors.green,
                child: draw_user_info(
                  width * 0.06, width * 0.05,
                  width * 0.34, height * 0.05,
                  width * 0.02, height * 0.05,
                  width * 0.55, height * 0.05,
                  width * 0.025, height * 0.05,
                  height * 0.025,
                  'Name :', name,
                ),
              ),
            ),

            SizedBox(
              height: height * 0.01,
            ),

            Skeletonizer(
              enabled: is_loaded,
              child: Container(
                height: height * 0.06,
                width: width * 1,
                //color: Colors.green,
                child: draw_user_info(
                  width * 0.06, width * 0.05,
                  width * 0.34, height * 0.05,
                  width * 0.02, height * 0.05,
                  width * 0.55, height * 0.05,
                  width * 0.025, height * 0.05,
                  height * 0.025,
                  'Cell :', cell,
                ),
              ),
            ),

            SizedBox(
              height: height * 0.01,
            ),

            Skeletonizer(
              enabled: is_loaded,
              child: Container(
                height: height * 0.06,
                width: width * 1,
                //color: Colors.green,
                child: draw_user_info(
                  width * 0.06, width * 0.05,
                  width * 0.34, height * 0.05,
                  width * 0.02, height * 0.05,
                  width * 0.55, height * 0.05,
                  width * 0.025, height * 0.05,
                  height * 0.025,
                  'Email :', email,
                ),
              ),
            ),

            SizedBox(
              height: height * 0.01,
            ),

            Skeletonizer(
              enabled: is_loaded,
              child: Container(
                height: height * 0.06,
                width: width * 1,
                //color: Colors.green,
                child: draw_user_info(
                  width * 0.06, width * 0.05,
                  width * 0.34, height * 0.05,
                  width * 0.02, height * 0.05,
                  width * 0.55, height * 0.05,
                  width * 0.025, height * 0.05,
                  height * 0.025,
                  'Area :', area,
                ),
              ),
            ),

            SizedBox(
              height: height * 0.01,
            ),

            Skeletonizer(
              enabled: is_loaded,
              child: Container(
                height: height * 0.08,
                width: width * 1,
                //color: Colors.green,
                child: draw_user_info(
                  width * 0.06, width * 0.05,
                  width * 0.34, height * 0.05,
                  width * 0.02, height * 0.05,
                  width * 0.55, height * 0.4,
                  width * 0.025, height * 0.05,
                  height * 0.025,
                  'Location :', location,
                ),
              ),
            ),

            SizedBox(
              height: height * 0.01,
            ),



          ],
        ),
      ),
    );
  }

  Widget draw_user_info(
      double left_space_width, double left_space_height,
      double key_space_width, double key_space_height,
      double middle_space_width, double middle_space_height,
      double value_space_width, double value_space_height,
      double right_space_width, double right_space_height,
      double text_size,
      String key, String value
      ){

    return Row(
      children: [

        Container(
          width: left_space_width,
          height: left_space_height,
          color: Colors.transparent,
          child: Text(''),
        ),

        Container(
          width: key_space_width,
          height: key_space_height,
          //color: Colors.blue,
          child: Row(
            children: [
              Center(
                child: Text(key,
                  style: TextStyle(
                      fontSize: text_size,
                      fontWeight: FontWeight.w600
                  ),
                ),
              ),
            ],
          ),
        ),

        Container(
          width: middle_space_width,
          height: middle_space_height,
          color: Colors.transparent,
          child: Text(''),
        ),

        Container(
          width: value_space_width,
          height: value_space_height,
          //color: Colors.red,
          child: Row(
            children: [
              Expanded(
                child: Text(value,
                  style: TextStyle(
                    fontSize: text_size,
                  ),
                ),
              ),
            ],
          ),
        ),

        Container(
          width: right_space_width,
          height: right_space_height,
          color: Colors.transparent,
          child: Text(''),
        ),

      ],
    );

  }


  void getDataFromFirebase() {

    _database.child('Users/${Common_Methods().get_uid()}/').onValue.listen((DatabaseEvent event) {
      final data = event.snapshot.value;
      print(Common_Methods().get_uid());
      if(data != null) {
        setState(() {
          print(data);
          image_link = event.snapshot.child('Profile_Image').value.toString();
          name = event.snapshot.child('Name').value.toString();
          email = event.snapshot.child('Email').value.toString();
          area = event.snapshot.child('Area').value.toString();
          location = event.snapshot.child('Location').value.toString();
          cell = event.snapshot.child('Mobile').value.toString();

          is_picture_loaded = true;
          is_loaded = false;

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
