import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:happybuy/Controller/controller.dart';
import 'package:get/get.dart';
import 'package:happybuy/Helper/helper.dart';
import 'package:happybuy/Helper/user_info.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {

  final picker = ImagePicker();
  final Controller _controller = Get.put(Controller());

  String token = "";
  UserInfo user = new UserInfo();
  Future getUserDataFromSharedPreference() async{



    Future<String> userName = user.getName();
    await userName.then((data) {
      token = data.toString();
      print(token);
      print("name print");
      _controller.singleUser(token);
    },onError: (e) {
      print(e);
    });

  }
  Future getImage() async {
    print("Getting img");

    final pickedFile =
    await picker.getImage(source: ImageSource.gallery, imageQuality: 50);
      setState(() {
        if (pickedFile != null) {
          _image1 = File(pickedFile.path);
        } else {
          print('No image selected.');
        }
      });
  }
 bool _isLoading = false;
  File _image1;
  Future createPostRequest() async {

    var postUri = Uri.parse(Helper.baseurl+"updateuser");
    var request = new http.MultipartRequest("POST", postUri);
    request.fields['id'] =token;
    request.fields['name'] =ct_name.text;
    request.fields['password']=ct_newPass.text;
    request.fields['email'] =ct_email.text;
    request.fields['address'] =ct_address.text;



    if (_image1 != null) {
      print('Not null');
      http.MultipartFile multipartFile = await http.MultipartFile.fromPath(
          'profileimage',_image1.path);
      request.files.add(multipartFile);
    } else {
      print('null null');
    }

    request
        .send()
        .then((result) async {
      http.Response.fromStream(result).then((response) {
        if (response.statusCode == 200) {

          print("Uploaded! ");
          print('response.body ' + response.body);
          var data = jsonDecode(response.body);
          _controller.singleUser(token);
          setState(() {
            _isLoading = false;
            _image1 = null;
          });

        } else {
          setState(() {
            _isLoading = false;
          });
        }

        return response.body;
      });
    })
        .catchError((err) => print('error : ' + err.toString()))
        .whenComplete(() {
    });

  }
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserDataFromSharedPreference();

  }
  TextEditingController ct_name = TextEditingController();
  TextEditingController ct_phone = TextEditingController();
  TextEditingController ct_email = TextEditingController();
  TextEditingController ct_address = TextEditingController();
  TextEditingController ct_newPass = TextEditingController();
  TextEditingController ct_oldPass = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Edit Profile"),),
      body: SingleChildScrollView(
        child: Obx((){
          if(_controller.isLoading.value){
            return Center(child: CircularProgressIndicator(),);
          }
          else{

            ct_name.text = _controller.userData[0].name;
            ct_phone.text = _controller.userData[0].phone;
            ct_email.text = _controller.userData[0].email;
            ct_address.text = _controller.userData[0].address;
            return Column(
              children: [
                GestureDetector(
                  child: Stack(
                    children: [
                      Center(
                        child: Container(
                          margin: EdgeInsets.only(top: 25),
                          height: 58,width: 58,
                          decoration: BoxDecoration(

                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(  color: Color(0xff21274E),width: 3)
                          ),
                          child: ClipRRect(
                            borderRadius:
                            BorderRadius.circular(30),
                            child:_image1 != null ? Image.file(_image1) :CachedNetworkImage(
                              fit: BoxFit.fill,
                              imageUrl: _controller.userData[0].profileimage == null ? "" :Helper.baseurl+_controller.userData[0].profileimage,
                              placeholder: (context, url) => Container(child:  Image.asset('images/profile.png')),
                              errorWidget: (context, url, error) => Icon(Icons.error),
                            ),
                          ),
                        ),
                      ),
                      Center(
                        child: Container(
                          margin: EdgeInsets.only(top: 70,left: 40),
                          height: 15,width: 16,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Colors.red
                          ),
                          child: Icon(Icons.add,color: Colors.white,size: 14,),
                        ),
                      ),
                    ],
                  ),
                  onTap: (){
                    getImage();
                  },
                ),

                // Text("Name"),
                Container(
                  margin: EdgeInsets.only(left: 20,right: 20,top: 20),
                  child: TextField(
                    style: TextStyle(fontSize: 18),
                    controller: ct_name,
                    keyboardType: TextInputType.text,
                    decoration: new InputDecoration(
                      contentPadding: EdgeInsets.only(left: 10),
                      labelText: 'Name',
                      border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(0),
                      ),
                    ),
                  ),
                ),
                // Text("Name"),
                Container(
                  margin: EdgeInsets.only(left: 20,right: 20,top: 20),
                  child: Row(children: [
                    Text("Phone : "),
                    Text(_controller.userData[0].phone),
                  ],)
                ),
                // Text("Name"),
                Container(
                  margin: EdgeInsets.only(left: 20,right: 20,top: 20),
                  child: TextField(
                    style: TextStyle(fontSize: 18),
                    controller: ct_email,
                    keyboardType: TextInputType.emailAddress,
                    decoration: new InputDecoration(
                      contentPadding: EdgeInsets.only(left: 10),
                      labelText: 'Email',
                      border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(0),
                      ),
                    ),
                  ),
                ),
                // Text("pass"),
                // Container(
                //   margin: EdgeInsets.only(left: 20,right: 20,top: 20),
                //   child: TextField(
                //     style: TextStyle(fontSize: 18),
                //     controller: ct_oldPass,
                //     keyboardType: TextInputType.emailAddress,
                //     decoration: new InputDecoration(
                //       contentPadding: EdgeInsets.only(left: 10),
                //       labelText: 'Old Password',
                //       border: new OutlineInputBorder(
                //         borderRadius: new BorderRadius.circular(0),
                //       ),
                //     ),
                //   ),
                // ),
                // Container(
                //   margin: EdgeInsets.only(left: 20,right: 20,top: 20),
                //   child: TextField(
                //     style: TextStyle(fontSize: 18),
                //     controller: ct_newPass,
                //     keyboardType: TextInputType.emailAddress,
                //     decoration: new InputDecoration(
                //       contentPadding: EdgeInsets.only(left: 10),
                //       labelText: 'New Password',
                //       border: new OutlineInputBorder(
                //         borderRadius: new BorderRadius.circular(0),
                //       ),
                //     ),
                //   ),
                // ),
                // Text("Name"),
                Container(
                  margin: EdgeInsets.only(left: 20,right: 20,top: 20),
                  child: TextField(
                    style: TextStyle(fontSize: 18),
                    controller: ct_address,
                    keyboardType: TextInputType.text,
                    decoration: new InputDecoration(
                      contentPadding: EdgeInsets.only(left: 10),
                      labelText: 'Address',
                      border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(0),
                      ),
                    ),
                  ),
                ),
                Container(child:_isLoading?CircularProgressIndicator():Container()),
                GestureDetector(
                  child: Container(
                    margin: EdgeInsets.only(top: 20),
                    height: 40,
                    width: MediaQuery.of(context).size.width-40,
                    color: Colors.lightBlueAccent,
                    child: Center(child: Text("Save",style: TextStyle(color: Colors.white),),),
                  ),
                  onTap: (){
                    setState(() {
                      _isLoading = true;
                    });
                    createPostRequest();
                  },
                ),



              ],
            );
          }
        })
      ),
    );
  }
}
