

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:green_clean_bangladesh/widgets/admin_nav_bar.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:super_banners/super_banners.dart';

import '../user/oinion_details.dart';
import '../utils/common_methods.dart';
import '../utils/report_feedback.dart';
import '../utils/strings.dart';

class Manage_Opinion extends StatefulWidget {
  const Manage_Opinion({super.key});

  @override
  State<Manage_Opinion> createState() => _Manage_OpinionState();
}

class _Manage_OpinionState extends State<Manage_Opinion> {

  final DatabaseReference _database = FirebaseDatabase(
      databaseURL: Strings.database_url
  ).reference();
  List<Report_Guideline_Model> items = [];
  bool is_loaded = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get_report_details();
  }

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
                        Text("Opinion", style: TextStyle(fontSize: size.width*0.8*0.10, fontWeight: FontWeight.bold, color: Color(0xFF00A669),),)
                      ],
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: size.height*0.07,),

            Container(
              //color: Colors.green,
              width: size.width * 1,
              height: size.height * 0.66,
              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Expanded(
                  child: Skeletonizer(
                    enabled: is_loaded,
                    child: ListView.builder(
                        itemCount: items.length,
                        itemBuilder: (context, index){

                          return Padding(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: Card(
                                elevation: 20,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(20)),
                                ),
                                child: InkWell(
                                  onTap: () {
                                    Get.to(Oinion_Details(
                                      purpose: items[index].submitted_as,
                                      image: items[index].image,
                                      description: items[index].description,
                                      date: items[index].date,
                                      title: items[index].title,
                                      location: items[index].location,

                                    ));
                                  },
                                  child: Container(
                                    height: size.height * 0.4,
                                    width: size.width * 1,
                                    child: Column(
                                      children: [

                                        Stack(
                                          children: [
                                            Container(
                                              height: size.height * 0.2,
                                              width: size.width * 1,
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20)),
                                                child: Image.network(
                                                  items[index].image,
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                            ),

                                            CornerBanner(
                                              bannerPosition: CornerBannerPosition.topLeft,
                                              bannerColor:  (items[index].submitted_as=='Report') ? Colors.redAccent : Colors.blueAccent,
                                              elevation: 5,
                                              child: Text(items[index].submitted_as,
                                                style: TextStyle(
                                                    color: Colors.white
                                                ),),
                                            )
                                          ],
                                        ),

                                        SizedBox(height: size.height * 0.04,),

                                        Padding(
                                          padding: const EdgeInsets.only(left: 5, right: 5),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: Text(items[index].title,
                                                  style: TextStyle(
                                                      fontSize: size.height * 0.03,
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

                                        SizedBox(height: size.height * 0.02,),


                                        Padding(
                                          padding: const EdgeInsets.only(left: 5, right: 5),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: Text(items[index].description,
                                                  style: TextStyle(
                                                      fontSize: size.height * 0.02,
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


  void get_report_details() {

    items.clear();
    _database.child('Report_and_Feedback/').onValue.listen((DatabaseEvent event) {
      final data1 = event.snapshot.value;

      print(Common_Methods().get_uid());
      if(event.snapshot.value != null) {

        Map data = data1 as Map;

        items.clear();
        for (var value in data.values) {
          items.add(Report_Guideline_Model.fromJson(Map.from(value)));
        }
        print('Items: $items');

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
