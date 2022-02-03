import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:happybuy/Helper/user_info.dart';
import 'package:happybuy/view/SplashScreen.dart';
import 'package:happybuy/view/category_list.dart';
import 'package:happybuy/view/dashboard.dart';
import 'package:happybuy/view/login_view.dart';
import 'package:happybuy/view/registration_view.dart';
import 'view_c/product_list.dart';
import 'package:happybuy/view/product_upload.dart';
import 'package:happybuy/view/product_view.dart';
import 'package:happybuy/view_c/Dashboard_client.dart';


void main() {
  runApp(
    new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SM Supar Shop',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp>{

  UserInfo user = new UserInfo();
  String name ;
  String type ;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserDataFromSharedPreference();
    Future.delayed(Duration(seconds:2),
      (){
        print(type);
        // if(type == '1') {
        //   Navigator.of(context).pop();
        //   Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
        // } else
          if(type == 'admin'){
          Navigator.of(context).pop();
          Navigator.push(context, MaterialPageRoute(builder: (context) => AdminDashboard()));
        }  else if(type == 'user'){
          Navigator.of(context).pop();
          Navigator.push(context, MaterialPageRoute(builder: (context) => DashboardClient()));
        } else{
          Navigator.of(context).pop();
         Navigator.push(context, MaterialPageRoute(builder: (context) => RegistrationPage()));
        }
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body : Container(
        child: Image.asset("images/logo.png",height: MediaQuery.of(context).size.height, width: MediaQuery.of(context).size.width),
      )
    );
  }

  void getUserDataFromSharedPreference() {
    Future<String> userName = user.getName();
    userName.then((data) {
      name = data.toString();
      print(name);
    },onError: (e) {
      print(e);
    });

    Future<String> userType = user.getType();
    userType.then((data) {
      setState(() {
        type = data.toString() ;
      });
      print(type);
    },onError: (e) {
      print(e);
    });
  }

}

   
