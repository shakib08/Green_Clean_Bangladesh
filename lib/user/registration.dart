

import 'dart:io';

import 'package:colorful_circular_progress_indicator/colorful_circular_progress_indicator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_clean_bangladesh/user/login.dart';
import 'package:image_picker/image_picker.dart';


import '../utils/strings.dart';

class Registration_Page extends StatefulWidget {
  const Registration_Page({super.key});

  @override
  State<Registration_Page> createState() => _Registration_PageState();
}

class _Registration_PageState extends State<Registration_Page> {

  late TextEditingController name;
  late TextEditingController email;
  late TextEditingController password;
  late TextEditingController location;
  late TextEditingController mobile;
  bool ischecked = false;
  bool is_clicked = true;
  String? selectedLocation;
  String image_text = 'No file selected yet';
  String image_path = '';
  String uid = '';
  String? downloadURL;
  //File? pickedImageFile;
  bool _isPasswordVisible = false;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final DatabaseReference database = FirebaseDatabase(databaseURL: Strings.database_url).reference();

  @override
  void initState() {
    // TODO: implement initState
    name = TextEditingController();
    email = TextEditingController();
    password = TextEditingController();
    location = TextEditingController();
    mobile = TextEditingController();
    super.initState();

  }

  @override
  void dispose() {
    // TODO: implement dispose
    name.dispose();
    email.dispose();
    password.dispose();
    location.dispose();
    mobile.dispose();

    super.dispose();
  }

  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;


    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [

                SizedBox(height: size.height*0.05,),

                Container(
                  width: size.width*0.8,
                  child: RichText(
                      text: TextSpan(
                        style:  DefaultTextStyle.of(context).style,
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Lets make your',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black, // Set the color for "Welcome"
                                fontSize: size.width*0.08,
                                decoration: TextDecoration.none,

                            ),
                          ),
                        ],
                      )
                  ),
                ),

                Container(
                  width: size.width*0.8,
                  child: RichText(
                      text: TextSpan(
                        style:  DefaultTextStyle.of(context).style,
                        children: <TextSpan>[
                          TextSpan(
                            text: 'account  ',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF00A669),  // Set the color for "Welcome"
                              fontSize: size.width*0.08,
                              decoration: TextDecoration.none,
                            ),
                          ),

                        ],
                      )
                  ),
                ),

                SizedBox(height: size.height*0.05,),


                Container(
                  width: size.width * 0.8,

                  child: TextField(
                    controller: name,
                    decoration: InputDecoration(hintText: "Name",
                      prefixIcon: Icon(Icons.person, color: Color(0xFF00A669),),
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
                    controller: password,
                    obscureText: !_isPasswordVisible,
                    decoration: InputDecoration(hintText: "Password",
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


                SizedBox(height: size.height * 0.03,),

                  // Container for Dropdown List
                Container(

                  width: size.width * 0.8,
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  decoration: BoxDecoration(
                    //color: Colors.green,
                    border: Border.all(color: Color(0xFF00A669)),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(top: 10, bottom: 10),
                    child: DropdownButton<String>(
                      isExpanded: true,
                      value: selectedLocation,
                      iconSize: 30,
                      hint: Text('  Select Area'),
                      items: Strings.locations
                          .map((String item) =>
                          DropdownMenuItem<String>(child: Text(item), value: item))
                          .toList(),
                      onChanged: (value2) => setState(() {
                        this.selectedLocation = value2.toString();
                        //mn = get_project_code(value.toString());
                      }),
                      underline: Container(  // Set underline to Container with zero height
                        height: 0,
                        color: Colors.transparent,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: size.height*0.03,),

                Container(
                  width: size.width * 0.8,
                  child: TextField(
                    controller: location,
                    decoration: InputDecoration(hintText: "House and Road",
                      prefixIcon: Icon(Icons.location_on, color: Color(0xFF00A669),),
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
                    controller: mobile,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(hintText: "Mobile Number",
                      prefixIcon: Icon(Icons.phone, color: Color(0xFF00A669),),
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
                  width: size.width*0.8,
                  child: Row(
                    children: [Container(
                      child: ElevatedButton(
                          onPressed: () {

                            // image = await picker.pickImage(source: ImageSource.gallery).then(
                            //         (value) {
                            //
                            //           print('Image Selected uccessfully!');
                            //           print(image!.path.toString());
                            //
                            //         });
                            _pick_image_from_gallery();

                          },
                          style: ElevatedButton.styleFrom(
                            primary:  Color(0xFF00A669), // Set the background color to green
                          ),
                          child: Center(child: Text("Profile Picture", style: TextStyle(color: Colors.white),),)
                      ),
                    ),
                      SizedBox(width: size.width*0.8*0.05,),
                      Container(
                        width: size.width*0.4,
                        //color: Colors.green,
                        child: Text(image_text,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      )
                    ],
                  ),
                ),




                SizedBox(height: size.height*0.02,),

                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Container(
                    width: size.width*0.9,
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

                        Text("I agreed with the terms and conditions"),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: size.height*0.02,),

                Container(
                  width: size.width*0.8,
                  decoration: BoxDecoration(
                    color: ischecked ? Color(0xFF00A669) : Colors.black38, // Green color
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: TextButton(
                      onPressed: ischecked ? () {

                        showConfirmationDialog(context);

                        setState(() {
                          is_clicked = !is_clicked;
                        });

                        print(name.text);
                        print(email.text);
                        print(password.text);
                        print(selectedLocation!);
                        print(image_path);
                        print(location.text);
                        print(mobile.text);

                        create_user(email.text, password.text).then((value) {

                          if (value != null) {
                            print("User created: ${value.uid}");

                            setState(() {
                              uid = value.uid;
                            });

                            uploadImage().then((value) {
                              //print('Image Saved Successfully!!!!!');


                              print(downloadURL);

                              saveUserData_databse(uid, name.text, email.text, password.text, selectedLocation!,
                              location.text, mobile.text, downloadURL!).then((value) {

                                Navigator.of(context).pop();
                                Get.snackbar('Welcome!', 'User Registered Successfully!!');
                                Get.offAll(Login_Page());
                                setState(() {
                                  is_clicked = !is_clicked;
                                });

                              }).onError((error, stackTrace) {
                                Navigator.of(context).pop();
                                Get.snackbar('Registered Failed!', 'Please provide accurate information!');
                              });



                            }).onError((error, stackTrace) {
                              Navigator.of(context).pop();
                              Get.snackbar('Registered Failed!', 'Please provide accurate information!');
                            });


                          }
                          else {
                            Navigator.of(context).pop();
                            print("Error creating user");
                            setState(() {
                              is_clicked = !is_clicked;
                            });
                          }

                        }).onError((error, stackTrace) {
                          Navigator.of(context).pop();
                          Get.snackbar('Registered Failed!', 'Please provide accurate information!');
                        });


                      } : null,
                      child: Text("Join Us",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: size.width*0.8*0.06
                        ),
                      )
                  ),
                ),
                SizedBox(height: size.height*0.05,),

                Container(
                  width: size.width*0.8,
                  child: Center(child: Text("Already have an account?",
                  style: TextStyle(
                      fontSize: size.height * 0.02
                  ),),),
                ),

                SizedBox(height: size.height*0.02,),

                Container(
                  width: size.width*0.8,
                  child: Center(
                    child: GestureDetector(
                      onTap: (){
                        Get.offAll(Login_Page());
                      },
                      child: Text("Sign in",
                        style: TextStyle(
                            color: Color(0xFF00A669),
                            fontWeight: FontWeight.w700,
                            fontSize: size.height * 0.02
                        ),),
                    ),
                  ),
                ),


                SizedBox(height: size.height*0.08,),

              ],
            ),
          ),
        ),
      ),
    );
  }

  Future _pick_image_from_gallery() async{

    final picker = ImagePicker();
    try {
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {

        setState(() {
          image_text = pickedFile.name;
          image_path = pickedFile.path;

        });

      } else {
        // User canceled the picker
      }
    } catch (e) {
      print("Error picking image: $e");
    }
  }

  Future<User?> create_user(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await result.user?.updateProfile(displayName: 'User');
      return result.user;
    } catch (e) {
      print("Error creating user: $e");
      return null;
    }
  }


  Future<String?> uploadImage() async {
    try {
      // Get a reference to the storage service
      Reference storageReference = FirebaseStorage.instance.ref().child('images/${uid}/${DateTime.now()}.png');

      // Upload the file to Firebase Storage
      await storageReference.putFile(File(image_path));

      // Get the download URL of the uploaded image
      downloadURL = await storageReference.getDownloadURL();

      return downloadURL;
    } catch (e) {
      print("Error uploading image: $e");
      return '';
    }
  }


  Future<void> saveUserData_databse(String uid,
      String name,
      String email,
      String password,
      String area,
      String location,
      String mobile,
      String profile_image

      ) async {
    try {
      await database.child('Users').child(uid).set({
        'Role': 'User',
        'U_ID': uid,
        'Name': name,
        'Email': email,
        'Password': password,
        'Area': area,
        'Location': location,
        'Mobile': mobile,
        'Profile_Image': profile_image,
        // Add more fields as needed
      });
    } catch (e) {
      print("Error saving user data: $e");
    }
  }


  Future<void> showConfirmationDialog(BuildContext context) async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Registering'),
          content: Text('You are almost there, please wait.'),
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



  


}
