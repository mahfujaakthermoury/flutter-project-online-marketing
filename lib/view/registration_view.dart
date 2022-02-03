import 'dart:convert';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:happybuy/GlobalSetting/GlobalColor.dart';
import 'package:happybuy/Helper/helper.dart';
import 'package:happybuy/Helper/user_info.dart';
import 'package:happybuy/view/login_view.dart';
import 'package:happybuy/view_c/Dashboard_client.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegistrationPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<RegistrationPage> {
  // FirebaseMessaging firebaseMessaging = FirebaseMessaging();

  bool _isLoading = false;

  String msg = "";

  String nameKey = "_key_name";

  Future<void> saveData(String msg) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString(nameKey, msg);
  }

  TextEditingController name = new TextEditingController();
  TextEditingController phone = new TextEditingController();
  TextEditingController pass = new TextEditingController();
  // ignore: missing_return

  // Login view
  Future registrationRequest() async {
    String token = await FirebaseMessaging.instance.getToken();
    print("calling reg");
    _isLoading = true;
    Uri url = Uri.parse(Helper.baseurl + "registration");
    Map data = {
      "phone": phone.text,
      "password": pass.text,
      "name": name.text,
      "type": "user",
      "token": token,
    };
    //encode Map to JSON
    var body = json.encode(data);
    var response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: body,
    );
    print("calling regbbbbbbbbbbbbbbbbbbbbbbbbb");
    print(response.body);
    print(response.statusCode);
    if (response.statusCode == 200) {
      _isLoading = false;
      var jsonString = jsonDecode(response.body);
      msg = jsonString["msg"];
      // String type = jsonString["data"]["type"];
      // String name = jsonString["data"]["name"];
      // print(type+"21");
      print(jsonString);
      setState(() {
        _isLoading = false;
      });
      // UserInfo user = new UserInfo();
      // user.saveLoginDataToSharedPreference(type, name);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginPage()));
      return null;
    } else {
//show error message
      return null;
    }
  }

  Widget getPageView(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            child: new Container(
              padding: EdgeInsets.fromLTRB(0, 40, 0, 0),
              child: new Card(
                elevation: 8.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(0),
                    topRight: Radius.circular(0),
                    bottomLeft: Radius.circular(0),
                    bottomRight: Radius.circular(0),
                  ),
                ),
                margin: EdgeInsets.only(right: 0, left: 0),
                child: new Wrap(
                  children: <Widget>[
                    Center(
                      child: Container(
                        alignment: Alignment(-1.0, 0.0),
                        padding: EdgeInsets.fromLTRB(30, 44, 30, 10),
                        child: Text(
                          'Registration',
                          style: TextStyle(
                            fontFamily: 'Eina_regular',
                            fontSize: 30.0,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ),
                    Container(
                      child: Container(
                        //color: Colors.white,
                        padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
                        child: TextField(
                          controller: name,
                          keyboardType: TextInputType.text,
                          decoration: new InputDecoration(
                            contentPadding: EdgeInsets.only(left: 10),
                            labelText: 'Your Name',
                            border: new OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(0),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      child: Container(
                        //color: Colors.white,
                        padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
                        child: TextField(
                          controller: phone,
                          keyboardType: TextInputType.phone,
                          decoration: new InputDecoration(
                            contentPadding: EdgeInsets.only(left: 10),
                            labelText: 'Phone Number',
                            border: new OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(0),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      child: Container(
                        //color: Colors.blueAccent,
                        padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
                        child: TextField(
                          controller: pass,
                          obscureText: true,
                          decoration: new InputDecoration(
                            contentPadding: EdgeInsets.only(left: 10),
                            labelText: 'Password',
                            border: new OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(0),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      //color: Colors.blueAccent,
                      width: double.infinity,

                      padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
                      height: 60,
                      child: RaisedButton(
                        //padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
                        color: GlobalColor.buttonColor,
                        onPressed: () {
                          if (phone.text.length == 11) {
                            registrationRequest();
                            setState(() {
                              _isLoading = true;
                            });
                          } else {
                            setState(() {
                              msg = "Invalid Phone Number";
                            });
                          }

//
                        }, //
                        child: new Text(
                          "Registration",
                          style: TextStyle(
                            fontFamily: 'Eina_regular',
                            fontSize: 14.0,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Center(
                        child: Text(
                          msg,
                          style: TextStyle(fontSize: 20.0, color: Colors.red),
                        ),
                      ),
                    ),
                    GestureDetector(
                      child: Container(
                        margin: EdgeInsets.only(top: 15),
                        width: MediaQuery.of(context).size.width,
                        child: Center(
                            child: Text(
                          "Already have an Account ?",
                          style: TextStyle(
                              color: GlobalColor.highlightTextColor,
                              fontWeight: FontWeight.bold),
                        )),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()));
                      },
                    ),
                    Center(
                      child: Container(
                        //color: Colors.white,
                        padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
                        child: SizedBox(
                          height: 118,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Firebase.initializeApp();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: GlobalColor.appbarColor,
          centerTitle: true,
          title: Title(color: Colors.blue, child: Text("Snov Buy")),
        ),
        body: Center(
            child: _isLoading
                ? CircularProgressIndicator()
                : getPageView(context)));
  }
}
