

import 'dart:io';

import 'package:colorful_circular_progress_indicator/colorful_circular_progress_indicator.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:green_clean_bangladesh/widgets/admin_nav_bar.dart';
import 'package:image_picker/image_picker.dart';

import '../utils/common_methods.dart';
import '../utils/strings.dart';

class Create_Tips_Guidelines extends StatefulWidget {
  const Create_Tips_Guidelines({super.key});

  @override
  State<Create_Tips_Guidelines> createState() => _Create_Tips_GuidelinesState();
}

class _Create_Tips_GuidelinesState extends State<Create_Tips_Guidelines> {

  bool? is_feedback = false;
  bool? is_report = false;
  String? selectedLocation;
  String? purpose;
  late TextEditingController title, description;
  String image_text = 'No file selected yet';
  String image_path = '';
  String? downloadURL;
  final DatabaseReference database = FirebaseDatabase(databaseURL: Strings.database_url).reference();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    title = TextEditingController();
    description = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    title.dispose();
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
        bottomNavigationBar: Admin_Navbar(),
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
                          Text("Create ", style: TextStyle(fontSize: size.width*0.8*0.10, fontWeight: FontWeight.bold, color: Colors.black),),
                          Text("Guidelines", style: TextStyle(fontSize: size.width*0.8*0.10, fontWeight: FontWeight.bold, color: Color(0xFF00A669),),)
                        ],
                      ),
                    ),
                  ),
                ],
              ),


              SizedBox(height: size.height*0.07,),


              Container(
                width: size.width * 0.8,
                child: TextField(
                  controller: title,
                  decoration: InputDecoration(hintText: "Title",
                    prefixIcon: Icon(Icons.perm_identity, color: Color(0xFF00A669),),
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

              Container(
                width: size.width * 0.8,
                height: size.height * 0.32,
                //color: Colors.redAccent,
                child: Expanded(
                  child: TextField(
                    maxLines: 8,
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
                      //uploadImage();
                      //create_opinion(formattedDateTime);
                      uploadImage().then((value) {
                        create_opinion(formattedDateTime);
                      });

                    },
                    child: Text("Create Tips & Guidelines", style: TextStyle(color: Colors.white, fontSize: size.width*0.8*0.06),)
                ),
              ),


            ],
          ),
        ),
      ),
    );
  }

  Future<void> showConfirmationDialog(BuildContext context) async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Creating Tips'),
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
          'tips_Guidelines/${DateTime.now()}.png'
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
      await database.child('Tips_and_Guidelines/$p').set({
        'Date': date,
        'Description': description.text,
        'Image': downloadURL,
        'P_ID': p,
        'Title': title.text,
      }).then((value) {
        print('Data inserted succesfully!');
        Navigator.of(context).pop();
        Get.back();
      });
    } catch (e) {
      print("Error saving user data: $e");
    }

  }











}
