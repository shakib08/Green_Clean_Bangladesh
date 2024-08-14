

import 'dart:io';

import 'package:colorful_circular_progress_indicator/colorful_circular_progress_indicator.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:green_clean_bangladesh/utils/common_methods.dart';
import 'package:green_clean_bangladesh/widgets/nav_bar.dart';
import 'package:image_picker/image_picker.dart';

import '../utils/strings.dart';

class Create_Opinion extends StatefulWidget {
  const Create_Opinion({super.key});

  @override
  State<Create_Opinion> createState() => _Create_OpinionState();
}

class _Create_OpinionState extends State<Create_Opinion> {


  bool? is_feedback = false;
  bool? is_report = false;
  String? selectedLocation;
  String? purpose;
  late TextEditingController location, subject, description;
  String image_text = 'No file selected yet!';
  String image_path = '';
  String? downloadURL;
  final DatabaseReference database = FirebaseDatabase(databaseURL: Strings.database_url).reference();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    location = TextEditingController();
    subject = TextEditingController();
    description = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    location.dispose();
    subject.dispose();
    description.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    DateTime now = DateTime.now();
    String _twoDigits(int n) => n.toString().padLeft(2, '0');
    String formattedDateTime = "${_twoDigits(now.day)}/${_twoDigits(now.month)}/${now.year}";


    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: Navbar(),
        body: SingleChildScrollView(
          child: Column(
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
                          Text("Opinion ", style: TextStyle(fontSize: size.width*0.8*0.10, fontWeight: FontWeight.bold, color: Colors.black),),
                          Text("Center", style: TextStyle(fontSize: size.width*0.8*0.10, fontWeight: FontWeight.bold, color: Color(0xFF00A669),),)
                        ],
                      ),
                    ),
                  ),
                ],
              ),


              SizedBox(height: size.height*0.07,),


              Container(
                width: size.width*0.9,
                child: Row(
                  children: [

                    SizedBox(width: size.width*0.9*0.05,),

                    Checkbox(
                        value: is_report,
                        activeColor: Color(0xFF00A669),
                        onChanged: (newBool){
                          setState(() {
                            is_report = newBool;
                            is_feedback = false;
                            purpose = 'Report';
                          });
                        }
                    ),

                    Text("Report"),

                    SizedBox(width: size.width*0.9*0.2,),

                    Checkbox(
                        value: is_feedback,
                        activeColor: Color(0xFF00A669),
                        onChanged: (newBool){
                          setState(() {
                            purpose = 'Feedback';
                            is_feedback = newBool;
                            is_report = false;
                          });
                        }
                    ),

                    Text("Feedback"),

                  ],
                ),
              ),


              SizedBox(height: size.height * 0.03,),


              Container(
                width: size.width * 0.8,
                child: TextField(
                  controller: location,
                  decoration: InputDecoration(hintText: "Location",
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


              SizedBox(height: size.height * 0.03,),

              // Container for Dropdown List
              Container(
                width: size.width * 0.8,
                child: TextField(
                  controller: subject,
                  decoration: InputDecoration(hintText: "Subject of opinion",
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
                height: size.width * 0.25,
                //color: Colors.redAccent,
                child: Expanded(
                  child: TextField(
                    maxLines: 3,
                    controller: description,
                    decoration: InputDecoration(hintText: "Description",
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
                        child: Center(child: Text("Select Picture", style: TextStyle(color: Colors.white),),)
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


              Container(
                width: size.width*0.8,
                decoration: BoxDecoration(
                  color: Color(0xFF00A669), // Green color
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: TextButton(
                    onPressed: (){

                      showConfirmationDialog(context);

                      print(formattedDateTime);
                      //create_opinion(formattedDateTime);
                      uploadImage().then((value) {
                        create_opinion(formattedDateTime);
                      });

                    },
                    child: Text("Submit", style: TextStyle(color: Colors.white, fontSize: size.width*0.8*0.06),)
                ),
              ),







            ],
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

  Future<String?> uploadImage() async {
    try {
      // Get a reference to the storage service
      Reference storageReference = FirebaseStorage.instance.ref().child(
          'images/${Common_Methods().get_uid()}/${DateTime.now()}.png'
      );

      // Upload the file to Firebase Storage
      await storageReference.putFile(File(image_path));

      // Get the download URL of the uploaded image
      downloadURL = await storageReference.getDownloadURL();
      print(downloadURL);
      return downloadURL;
    } catch (e) {
      print("Error uploading image: $e");
      return '';
    }
  }


  void create_opinion(String date) async{

    try {
      String p = database.push().key.toString();
      await database.child('Report_and_Feedback/$p').set({
        'Date': date,
        'Description': description.text,
        'Image': downloadURL,
        'Location': location.text,
        'P_ID': p,
        'Submitted_As': purpose,
        'Time': '',
        'U_ID': Common_Methods().get_uid(),
        'Title': subject.text,
        // Add more fields as needed
      }).then((value) {
        Navigator.of(context).pop();
        print('Data inserted succesfully!');
        Get.back();
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
          title: Text('Submitting Opinion'),
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


}
