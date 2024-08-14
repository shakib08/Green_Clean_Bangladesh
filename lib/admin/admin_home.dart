

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:green_clean_bangladesh/admin/manage_opinion.dart';
import 'package:green_clean_bangladesh/user/tips_and_guidelines.dart';
import 'package:green_clean_bangladesh/widgets/admin_nav_bar.dart';

import '../firebase/test.dart';
import '../user/login.dart';
import '../utils/shared_preference.dart';
import 'manage_request.dart';

class Admin_Home extends StatefulWidget {
  const Admin_Home({super.key});

  @override
  State<Admin_Home> createState() => _Admin_HomeState();
}

class _Admin_HomeState extends State<Admin_Home> {

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: Admin_Navbar(),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                SizedBox(height: size.height * 0.05,),

                Container(
                  //color: Colors.green,
                  width: size.width*0.9,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Admin", style: TextStyle(fontSize: size.width*0.9*0.12, fontWeight: FontWeight.bold, color: Colors.black),),
                      Text("Panel", style: TextStyle(fontSize: size.width*0.9*0.12, fontWeight: FontWeight.bold, color: Color(0xFF00A669),),),
                      SizedBox(width: size.width*0.9*0.1,),
                      Container(width: size.width*0.9*0.2, child: Image.asset('assets/images/gcb.png'),)
                    ],
                  ),
                ),

                SizedBox(height: size.height*0.1,),

                Container(width: size.width*0.9, child: Text("Features", style: TextStyle(color: Colors.black, fontSize: size.width*0.08, fontWeight: FontWeight.bold),),),

                SizedBox(height: size.height * 0.05,),

                Card(
                  elevation: 20,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(40))
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(40)),
                    child: InkWell(
                      onTap: (){
                        Get.to(Manage_Request());
                      },
                      child: Container(
                        width: size.width*0.9,
                        height: size.height*0.1,
                        color:  Color(0xFF00A669),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Manage", style: TextStyle(fontSize: size.width*0.9*0.08, color: Colors.white, fontWeight: FontWeight.bold),),
                                Text("    Pickup Request", style: TextStyle(fontSize: size.width*0.9*0.06, color: Colors.white),)
                              ],
                            ),

                            Container(child: Icon(Icons.arrow_forward, size: size.width*0.9*0.15, color: Colors.white,),)

                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: size.height*0.03,),

                Card(
                  elevation: 20,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(40))
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(40)),
                    child: InkWell(
                      onTap: (){
                        Get.to(Manage_Opinion());
                      },
                      child: Container(
                        width: size.width*0.9,
                        height: size.height*0.1,
                        color:  Color(0xFF00A669),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(width: size.width*0.9*0.04,),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Manage", style: TextStyle(fontSize: size.width*0.9*0.08, color: Colors.white, fontWeight: FontWeight.bold),),
                                Text("Opinion", style: TextStyle(fontSize: size.width*0.9*0.06, color: Colors.white),)
                              ],
                            ),
                            SizedBox(width: size.width*0.9*0.33,),
                            Container(child: Icon(Icons.arrow_forward, size: size.width*0.9*0.15, color: Colors.white,),)

                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: size.height*0.03,),

                Card(
                  elevation: 20,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(40))
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(40)),
                    child: InkWell(
                      onTap: (){
                        Get.to(Tips_and_Guidelines(role: 'Admin',));
                      },
                      child: Container(
                        width: size.width*0.9,
                        height: size.height*0.1,
                        color:  Color(0xFF00A669),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(width: size.width*0.9*0.04,),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Manage", style: TextStyle(fontSize: size.width*0.9*0.08, color: Colors.white, fontWeight: FontWeight.bold),),
                                Center(child: Text("Tips", style: TextStyle(fontSize: size.width*0.9*0.06, color: Colors.white),))
                              ],
                            ),
                            SizedBox(width: size.width*0.9*0.42,),
                            Container(child: Icon(Icons.arrow_forward, size: size.width*0.9*0.15, color: Colors.white,),)

                          ],
                        ),
                      ),
                    ),
                  ),
                ),


              ],
            ),
          ),
        ),
      ),
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



}
