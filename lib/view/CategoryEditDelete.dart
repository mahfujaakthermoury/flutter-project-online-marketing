import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:happybuy/Helper/helper.dart';
import 'package:happybuy/Model/CartList.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';
import 'package:happybuy/Controller/controller.dart';
class CategoryEdit extends StatefulWidget {

  ModelCatList category;
  CategoryEdit(this.category);
  @override
  _CategoryEditState createState() => _CategoryEditState();
}

class _CategoryEditState extends State<CategoryEdit> {

  final Controller _controller = Get.put(Controller());

  int _isAvailable = 0;


  File _image;
  final picker = ImagePicker();
  
  Future getImage() async {
    print("Getting img");

    final pickedFile =
    await picker.getImage(source: ImageSource.gallery, imageQuality: 100);
    
      setState(() {
        if (pickedFile != null) {
          _image= File(pickedFile.path);
        } else {
          print('No image selected.');
        }
      });
  
    
    setState(() {

    });
  }
  bool isProgress = false;
  //upload product
  Future editRequest() async {
    setState(() {
      isProgress = true;
    });
    var postUri = Uri.parse(Helper.baseurl+"update_category");
    var request = new http.MultipartRequest("POST", postUri);
    request.fields['id'] =widget.category.id.toString();
    request.fields['name'] =ctName.text;



    if (_image != null) {
      print('Not null');
      http.MultipartFile multipartFile = await http.MultipartFile.fromPath(
          'category_image',_image.path);
      request.files.add(multipartFile);
    } else {
      print('null null');
    }

    request
        .send()
        .then((result) async {
      http.Response.fromStream(result).then((response) {
        if (response.statusCode == 200) {
          isProgress = false;
          print("Uploaded! ");
          print('response.body ' + response.body);
          var data = jsonDecode(response.body);
          print(data);
          _controller.fetchCatList();
          setState(() {
            isProgress = false;
          });

        } else {

          setState(() {
            isProgress = false;
          });
        }

        return response.body;
      });
    })
        .catchError((err) => print('error : ' + err.toString()))
        .whenComplete(() {
    });
    setState(() {

    });
  }
  TextEditingController ctName = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ctName.text=widget.category.name;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Edit Category"),
      actions: [
        IconButton(onPressed: (){
          editRequest();
        }, icon: Text("Edit"))
      ],),
      body: Container(
        child: Column(
          children: [
            Text("Image Size 512 x 512 "),
            GestureDetector(
              child: Container(
                child:    _image != null ? Image.file(_image) : widget.category.categoryImage != null ? FadeInImage(
                  image: NetworkImage(Helper.baseurl +
                      widget.category.categoryImage),
                  placeholder:
                  AssetImage('images/gif-logo.gif'),
                  fit: BoxFit.cover,
                ) : Icon(Icons.add_a_photo_outlined,size: 48,),
              ),

              onTap: (){
                getImage();
              },
            ),

            Container(
              margin: EdgeInsets.all(15),
              child: TextField(
                controller: ctName,
                keyboardType: TextInputType.text,
                decoration: new InputDecoration(
                  labelText: 'Category Name',
                  border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
         // SwitchScreen(),
            Container(
              child: isProgress ? CircularProgressIndicator() : Container(),
            ),

          ],
        ),
      ),
    );
  }
}

class SwitchScreen extends StatefulWidget {
  @override
  SwitchClass createState() => new SwitchClass();
}

class SwitchClass extends State {
  bool isSwitched = false;
  var textValue = 'Available';

  void toggleSwitch(bool value) {

    if(isSwitched == false)
    {
      setState(() {
        isSwitched = true;
        textValue = 'Switch Button is ON';
      });
      print('Switch Button is ON');
    }
    else
    {
      setState(() {
        isSwitched = false;
        textValue = 'Switch Button is OFF';
      });
      print('Switch Button is OFF');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children:[ Transform.scale(
            scale: 2,
            child: Switch(
              onChanged: toggleSwitch,
              value: isSwitched,
              activeColor: Colors.blue,
              activeTrackColor: Colors.yellow,
              inactiveThumbColor: Colors.redAccent,
              inactiveTrackColor: Colors.orange,
            )
        ),
          Text('$textValue', style: TextStyle(fontSize: 20),)
        ]);
  }
}