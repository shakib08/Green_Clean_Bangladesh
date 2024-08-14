
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:green_clean_bangladesh/admin/admin_home.dart';
import 'package:green_clean_bangladesh/user/home.dart';
import 'package:green_clean_bangladesh/user/login.dart';
import 'package:green_clean_bangladesh/user/onBoarding.dart';
import 'package:green_clean_bangladesh/user/registration.dart';
import 'package:green_clean_bangladesh/utils/shared_preference.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'firebase_options.dart';

Future<void> main() async{

  //await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,);
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static bool? is_first_time;
  static bool? is_logged_in;
  static String? Role;

  Future<int?> _loadWidget() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    is_first_time = preferences.getBool('OnBS_Status');
    is_logged_in = preferences.getBool('Login_Status');
    Role = preferences.getString('Role');

    if (is_logged_in == true)
      return 2;
    else if (is_first_time == true)
      return 1;
    else
      return 0;
    // return remember;
  }

  @override
  Widget build(BuildContext context) {

    return GetMaterialApp(
      title: 'Green Clean Bangladesh',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.green,
          textSelectionTheme:
          TextSelectionThemeData(selectionColor: Colors.white)),
      //onGenerateRoute: Router(routerDelegate: null,).generateRoute,
      home: FutureBuilder(
        future: _loadWidget(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {

          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data == 0) {
              print(snapshot.data.toString() + 'Null ------');
              // Shared_Prefference_Class.set_OnBoarding_Status(true).then((value) {
              //   return OnboardingPage();
              // });
              return OnboardingPage();
            }

            else if (snapshot.data == 1) {

              return Login_Page();

            }

            else {
              print(snapshot.data.toString() + 'Not Null ------');

              //return Home_Page();
              //return Registration_Page();
              if(Role=='User') return Home_Page();
              else return Admin_Home();

            }
          }
          return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ));
        },
      ),

    );
  }
}

