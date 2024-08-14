

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:green_clean_bangladesh/widgets/nav_bar.dart';
import 'package:lottie/lottie.dart';

class Dustbin_Locations extends StatefulWidget {
  const Dustbin_Locations({super.key});

  @override
  State<Dustbin_Locations> createState() => _Dustbin_LocationsState();
}

class _Dustbin_LocationsState extends State<Dustbin_Locations> {


  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    Size size = MediaQuery.of(context).size;

    return SafeArea(
        child: Scaffold(
          bottomNavigationBar: Navbar(),
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
                          Text("Dustbin ", style: TextStyle(fontSize: size.width*0.8*0.10, fontWeight: FontWeight.bold, color: Colors.black),),
                          Text("Locations", style: TextStyle(fontSize: size.width*0.8*0.10, fontWeight: FontWeight.bold, color: Color(0xFF00A669),),)
                        ],
                      ),
                    ),
                  ),
                ],
              ),


              SizedBox(height: size.height*0.07,),


              Container(
                height: height * 0.7,
                width: width * 1,
                //color: Colors.green,
                child: Center(
                    child: Lottie.asset('assets/lottie/Animation - 1702884053423.json' ,
                        height: height * 1,
                        width: width * 1,
                      fit: BoxFit.contain,
                    ),
                ),
              ),







            ],
          ),
        ),
    );
  }
}
