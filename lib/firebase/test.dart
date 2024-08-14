import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:green_clean_bangladesh/utils/common_methods.dart';

import '../utils/strings.dart';

class responsiveGridView extends StatefulWidget {
  const responsiveGridView({super.key});

  @override
  State<responsiveGridView> createState() => _responsiveGridViewState();
}

class _responsiveGridViewState extends State<responsiveGridView> {

  final DatabaseReference _database = FirebaseDatabase(
      databaseURL: Strings.database_url
  ).reference();
  bool is_picture_loaded = false;
  String? image_link;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDataFromFirebase();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
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
                                  text: 'Dash ',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black, // Set the color for "Welcome"
                                      fontSize: size.width*0.1

                                  ),
                                ),
                                TextSpan(
                                  text: 'board',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF00A669), // Set the color for "Back"
                                      fontSize: size.width*0.1
                                  ),
                                ),
                              ],
                            )
                        ),
                      ),

                      SizedBox(width: size.width*0.9*0.15,),

                      Container(
                        width: size.width*0.9*0.25,
                        child: is_picture_loaded ?
                        ClipRRect(
                          borderRadius: BorderRadius.circular(50.0), // Adjust the radius as needed
                          child: Image.network(
                            image_link!, // Replace with your image URL
                            width: 100.0, // Adjust the width as needed
                            height: 100.0, // Adjust the height as needed
                            fit: BoxFit.cover,
                          ),
                        )
                            : Image.asset('assets/images/gcb.png'),
                      )


                    ],
                  ),
                ),

                SizedBox(height: size.height*0.05,),

                Card(
                  elevation: 30,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                  ),
                  child: Container(
                    width: size.width*0.9,

                    color: Color(0xFF00A669),
                    child: Center(
                      child: Column(
                        children: [
                          SizedBox(height: size.height*0.02,),
                          Text("Today's Time Schedule", style: TextStyle(color: Colors.white, fontSize: size.width*0.9*0.07, fontWeight: FontWeight.bold),),
                          Text("9AM to 6PM", style: TextStyle(color: Colors.white, fontSize: size.width*0.9*0.05),),
                          SizedBox(height: size.height*0.02,)
                        ],
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
                          SizedBox(height: size.height*0.02,),
                          Card(
                            elevation: 20,
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
                          )
                        ],
                      ),
                      SizedBox(width: size.width*0.9*0.06,),
                      Column( 	children: [
                        Card(
                          elevation: 20,
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
                        SizedBox(height: size.height*0.02,),
                        Card(
                          elevation: 20,
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
                        )
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


  void getDataFromFirebase() {

    _database.child('Users/${Common_Methods().get_uid()}/Profile_Image/').onValue.listen((DatabaseEvent event) {
      final data = event.snapshot.value;
      print(Common_Methods().get_uid());
      if(data != null) {
        setState(() {
          image_link = data.toString();
          is_picture_loaded = true;
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
