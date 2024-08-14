


import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:green_clean_bangladesh/admin/admin_home.dart';

import '../user/login.dart';
import '../utils/shared_preference.dart';


class Admin_Navbar extends StatelessWidget {

  //GlobalKey<ScaffoldState>? openDrawer;
  Admin_Navbar({super.key});

  @override
  Widget build(BuildContext context) {

    var height = MediaQuery.of(context).size.height;
    var _open_drawer = GlobalKey<ScaffoldState>();
    return ConvexAppBar(
      height: height * 0.07,
      backgroundColor: Color(0xFF00A669),
      style: TabStyle.react,
      items: [
        TabItem(icon: Icons.logout, title: 'Logout'),
        TabItem(icon: Icons.home, title: 'Home'),
        TabItem(icon: Icons.settings, title: 'Settings'),
      ],
      initialActiveIndex: 1,
      onTap: (int i) {
        print('click index=$i');

        if (i == 0) showConfirmationDialog(context);
        //openDrawer!.currentState!.openDrawer();
        else if (i == 1) {
          print(i);
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Admin_Home()));
        }
      },
    );
  }
}

Future<void> showConfirmationDialog(BuildContext context) async {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Confirmation'),
        content: Text('Are you sure you want to logout?'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              // Close the dialog and perform the action

              print('Yes Clicked!!');
              Navigator.of(context).pop();
              goto_login_page(context);
            },
            child: Text('Yes'),
          ),
          TextButton(
            onPressed: () {
              // Close the dialog
              print('No Clicked!!');
              Navigator.of(context).pop();
            },
            child: Text('No'),
          ),
        ],
      );
    },
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
