

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:green_clean_bangladesh/user/tips_details.dart';
import 'package:green_clean_bangladesh/utils/tips_guideline_model.dart';
import 'package:green_clean_bangladesh/widgets/nav_bar.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../admin/create_tips_guidelines.dart';
import '../utils/common_methods.dart';
import '../utils/strings.dart';

class Tips_and_Guidelines extends StatefulWidget {
  String role;
  Tips_and_Guidelines({required this.role, super.key});

  @override
  State<Tips_and_Guidelines> createState() => _Tips_and_GuidelinesState();
}

class _Tips_and_GuidelinesState extends State<Tips_and_Guidelines> {


  final DatabaseReference _database = FirebaseDatabase(
      databaseURL: Strings.database_url
  ).reference();
  List<Tips_Guideline> items = [];
  bool ok = false;
  bool is_loaded = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get_tips_guideline_info();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;


    return SafeArea(
        child: Scaffold(
          floatingActionButton: (widget.role == 'Admin') ? FloatingActionButton(
          onPressed: () {
            // Add your FAB onPressed logic here
            print('Floating Action Button Pressed!');
            Get.to(Create_Tips_Guidelines());
           },
          child: Icon(Icons.add, color: Colors.white,), // You can use any Icon here
          backgroundColor: Color(0xFF00A669), // Customize FAB background color
          ) : Text(''),
          bottomNavigationBar: Navbar(),
          body: Column(
            children: [

              SizedBox(height: height*0.02,),

              Row(
                children: [
                  InkWell(
                    onTap: () {

                      Get.back();
                    },
                    child: Container(
                      height: height * 0.04,
                      width: width * 0.1,
                      //color: Colors.green,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Icon(Icons.arrow_back_sharp, size: height * 0.045,),
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
                      width: width*0.8,
                      child: Row(
                        children: [
                          Text("Tips & ", style: TextStyle(fontSize: width*0.8*0.10, fontWeight: FontWeight.bold, color: Colors.black),),
                          Text("Guidelines", style: TextStyle(fontSize: width*0.8*0.10, fontWeight: FontWeight.bold, color: Color(0xFF00A669),),)
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: height*0.05,),


              Container(
                //color: Colors.green,
                width: width * 1,
                height: height * 0.68,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Expanded(
                    child: Skeletonizer(
                      enabled: is_loaded,
                      child: ListView.builder(
                        itemCount: items.length,
                          itemBuilder: (context, index){

                          return Padding(
                            padding: const EdgeInsets.only(bottom: 40),
                            child: Card(
                              elevation: 20,
                                //color: Colors.grey,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(20)),
                              ),
                              child: InkWell(
                                onTap: () {
                                  Get.to(Tips_Details(

                                    title: items[index].title,
                                    date: items[index].date,
                                    description: items[index].description,
                                    image: items[index].image,
                                  ));
                                },
                                child: Container(
                                  height: height * 0.4,
                                  width: width * 1,
                                  child: Column(
                                    children: [

                                      Container(
                                        height: height * 0.2,
                                        width: width * 1,
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20)),
                                          child: Image.network(
                                            items[index].image,
                                               fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),

                                      SizedBox(height: height * 0.04,),

                                      Padding(
                                        padding: const EdgeInsets.only(left: 5, right: 5),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Text(items[index].title,
                                              style: TextStyle(
                                                fontSize: height * 0.03,
                                                fontWeight: FontWeight.w800,
                                                color: Colors.black87
                                              ),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),

                                      SizedBox(height: height * 0.02,),


                                      Padding(
                                        padding: const EdgeInsets.only(left: 5, right: 5),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Text(items[index].description,
                                                style: TextStyle(
                                                    fontSize: height * 0.02,
                                                    //fontWeight: FontWeight.w800,
                                                    color: Colors.black87
                                                ),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,

                                              ),
                                            ),
                                          ],
                                        ),
                                      ),

                                    ],
                                  ),
                                ),
                              ),
                            )
                          );

                          }
                      ),
                    ),
                  ),
                ),
              ),



            ],
          ),
        ),
    );
  }



  void get_tips_guideline_info() {

    items.clear();
    _database.child('Tips_and_Guidelines/').onValue.listen((DatabaseEvent event) {
      final data1 = event.snapshot.value;

      print(Common_Methods().get_uid());
      if(event.snapshot.value != null) {

        Map data = data1 as Map;



        items.clear();
        for (var value in data.values) {
          items.add(Tips_Guideline.fromJson(Map.from(value)));
        }
        print(items.length);

        setState(() {
          // is_avialable = true;
          // print(location);
          // print(mobile);
          //is_picture_loaded = true;
          is_loaded = false;
        });
        print(data.toString());

      }
      else {
        print('else:   ');
        //print(data.toString());
        setState(() {
          //is_avialable = false;
        });

      }



    });
  }


}
