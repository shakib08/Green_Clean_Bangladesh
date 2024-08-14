

import 'package:colorful_circular_progress_indicator/colorful_circular_progress_indicator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_cached_image/firebase_cached_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:green_clean_bangladesh/admin/admin_home.dart';
import 'package:green_clean_bangladesh/user/home.dart';
import 'package:green_clean_bangladesh/user/registration.dart';
import 'package:sidebarx/sidebarx.dart';

import '../utils/shared_preference.dart';

class Login_Page extends StatefulWidget {
  const Login_Page({super.key});

  @override
  State<Login_Page> createState() => _Login_PageState();
}

class _Login_PageState extends State<Login_Page> {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  late TextEditingController email;
  late TextEditingController pass;
  bool? ischecked = false;
  bool is_clicked = true;
  late bool login_success;
  String? uid = '';
  bool _isPasswordVisible = false;



  @override
  void initState() {
    // TODO: implement initState
    email = TextEditingController();
    pass = TextEditingController();

    super.initState();

  }

  @override
  void dispose() {
    // TODO: implement dispose
    email.dispose();
    pass.dispose();
    super.dispose();

  }

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    Size size = MediaQuery.of(context).size;


    return SafeArea(
      child:
      Scaffold(
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                SizedBox(height: size.height*0.2,),
                Container(
                  width: size.width*0.8,
                  child: RichText(
                      text: TextSpan(
                        style:  DefaultTextStyle.of(context).style,
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Welcome ',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black, // Set the color for "Welcome"
                                fontSize: size.width*0.1,
                                 decoration: TextDecoration.none,

                            ),
                          ),
                          TextSpan(
                            text: 'Back',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF00A669), // Set the color for "Back"
                                fontSize: size.width*0.1,
                                 decoration: TextDecoration.none,
                            ),
                          ),
                        ],
                      )
                  ),
                ),

                SizedBox(height: size.height*0.1,),

                Container(
                  width: size.width * 0.8,

                  child: TextField(
                    controller: email,
                    decoration: InputDecoration(hintText: "Email",
                      prefixIcon: Icon(Icons.email, color: Color(0xFF00A669),),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF00A669)), // Border color when focused
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),

                  ),
                ),

                SizedBox(height: size.height*0.03,),

                Container(
                  width: size.width * 0.8,
                  child: TextField(
                    controller: pass,
                    obscureText: !_isPasswordVisible,
                    decoration: InputDecoration(
                      hintText: "Password",
                      prefixIcon: Icon(Icons.lock, color: Color(0xFF00A669),),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            _isPasswordVisible = !_isPasswordVisible;
                          });
                        },
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF00A669)), // Border color when focused
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),

                  ),
                ),
                SizedBox(height: size.height*0.02,),

                Container(
                  width: size.width*0.8,
                  child: Row(
                    children: [
                      Checkbox(
                        value: ischecked,
                        onChanged: (bool? value) {
                          setState(() {
                            ischecked = value ?? false;
                          });
                        },
                        activeColor: Color(0xFF00A669),
                      ),
                      Text("Keep me loged in")
                    ],
                  ),
                ),

                SizedBox(height: size.height*0.03,),

                Container(
                  width: size.width*0.8,
                  decoration: BoxDecoration(
                    color: Color(0xFF00A669), // Green color
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: TextButton(
                      onPressed: is_clicked ? () async{

                        showConfirmationDialog(context);

                        setState(() {
                          is_clicked = false;
                        });

                          login_success = await signIn(email.text, pass.text);

                          if(login_success){
                            Get.snackbar('Welcome!', 'User Logged In Successfully!!');
                            print(uid);
                            print('Display name: ${getDisplayName()}');

                            setState(() {
                              is_clicked = true;
                            });

                            if(getDisplayName()=='User') {
                              Navigator.of(context).pop();
                              goto_home_page(context);
                            }
                            else {
                              Navigator.of(context).pop();
                              goto_admin_home_page(context);
                            }



                          }
                          else {
                            Navigator.of(context).pop();
                            Get.snackbar('Oopps!', 'Invalid email or Password!');
                            setState(() {
                              is_clicked = true;
                            });
                          }

                      } : null,
                      child: Text("Log in", style: TextStyle(color: Colors.white, fontSize: size.width*0.8*0.06),)
                  ),
                ),

                SizedBox(height: size.height*0.05,),

                Container(
                  width: size.width*0.8,
                  child: Center(child: Text("Don't have an account?",
                  style: TextStyle(
                    fontSize: size.height * 0.022
                  ),),),
                ),

                SizedBox(height: size.height*0.02,),

                Container(
                  width: size.width*0.8,
                  child: Center(
                    child: GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Registration_Page()));
                      },
                      child: Text("Sign up Now!",
                        style: TextStyle(
                            color: Color(0xFF00A669),
                          fontWeight: FontWeight.w700,
                            fontSize: size.height * 0.02
                        ),),
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

  void goto_home_page(BuildContext context) async {
    await Shared_Prefference_Class.init();
    await Shared_Prefference_Class.set_Login_Status(true);
    await Shared_Prefference_Class.set_role_Status(getDisplayName());
    //await print(Shared_Prefference_Class.get_OnBoarding_Status().toString());
    // Navigator.of(context).pushReplacement(
    //   MaterialPageRoute(builder: (_) => Login_Page()),
    // );
    Get.offAll(Home_Page());
  }

  Future<void> showConfirmationDialog(BuildContext context) async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Loggin In'),
          content: Text('Please wait for a moment.'),
          actions: <Widget>[
            SizedBox(height: 10,),
            Center(
                child: ColorfulCircularProgressIndicator(
                  colors: [Color(0xFF00A669)],
                  strokeWidth: 5,
                  indicatorHeight: 40,
                  indicatorWidth: 40,
                )),
          ],
        );
      },
    );
  }

  void goto_admin_home_page(BuildContext context) async {
    await Shared_Prefference_Class.init();
    await Shared_Prefference_Class.set_Login_Status(true);
    await Shared_Prefference_Class.set_role_Status(getDisplayName());
    //await print(Shared_Prefference_Class.get_OnBoarding_Status().toString());
    // Navigator.of(context).pushReplacement(
    //   MaterialPageRoute(builder: (_) => Login_Page()),
    // );
    Get.offAll(Admin_Home());
  }

  Future<bool> signIn(String email, String pass) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: pass,
      );
      uid = userCredential.user?.uid.toString();
      print("User signed in successfully: ${userCredential.user?.uid}");
      //Get.snackbar('Welcome!', 'User Logged In Successfully!!');
      return true;
    }
    catch (error) {
      print("Error signing in: $error");
      //Get.snackbar('Oopps!', 'Invalid email or Password!');
      return false;
    }
  }

  String getDisplayName() {
    User? user = _auth.currentUser;
    String displayName = user?.displayName ?? "N/A";
    return displayName;
  }

}
