

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:green_clean_bangladesh/widgets/nav_bar.dart';

import '../utils/strings.dart';

class Tips_Details extends StatefulWidget {

  String image, title, description, date;
  Tips_Details({required this.image, required this.title, required this.description, required this.date, super.key});

  @override
  State<Tips_Details> createState() => _Tips_DetailsState();
}

class _Tips_DetailsState extends State<Tips_Details> {

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return SafeArea(
        child: Scaffold(
          bottomNavigationBar: Navbar(),
          body: SingleChildScrollView(
            child: Column(
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

                SizedBox(height: height * 0.04,),

                Container(
                  height: height * 0.3,
                  width: width * 1,
                  child: Image.network(
                    widget.image,
                    fit: BoxFit.fill,
                  ),
                ),

                SizedBox(height: height * 0.02,),

                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text('Published on: ${widget.date}   '),
                    ],
                  ),
                ),

                SizedBox(height: height * 0.02,),

                Container(
                  height: height * 0.1,
                  width: width * 1,
                  //color: Colors.cyan,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 5, right: 5),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(widget.title,
                            style: TextStyle(
                                fontSize: height * 0.03,
                                fontWeight: FontWeight.w800,
                                color: Colors.black87
                            ),
                            // maxLines: 2,
                            // overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: height * 0.02,),


                Padding(
                  padding: const EdgeInsets.only(left: 5, right: 5),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(widget.description,
                          style: TextStyle(
                              fontSize: height * 0.02,
                              //fontWeight: FontWeight.w800,
                              color: Colors.black87
                          ),


                        ),
                      ),
                    ],
                  ),
                ),


                SizedBox(height: height * 0.05,),


              ],
            ),
          ),
        ),
    );
  }
}
