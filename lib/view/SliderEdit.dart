import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:happybuy/Controller/controller.dart';
import 'package:happybuy/Helper/helper.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class SliderEdit extends StatefulWidget {
  @override
  _SliderEditState createState() => _SliderEditState();
}

class _SliderEditState extends State<SliderEdit> {
  final Controller _controller = Get.put(Controller());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller.fetchSliderList();
  }
  File _image;
  final picker = ImagePicker();

  bool isProgress = false;
// delete slider
  Future deleteSLider(id) async {
    setState(() {
      isProgress = true;
    });
    var postUri = Uri.parse(Helper.baseurl+"deleteslider");
    var request = new http.MultipartRequest("POST", postUri);
    request.fields['id'] =id.toString();

    request
        .send()
        .then((result) async {
      http.Response.fromStream(result).then((response) {
        if (response.statusCode == 200) {
          isProgress = false;
          _controller.fetchSliderList();
          Navigator.pop(context);
          print("Deleted! ");
          print('response.body ' + response.body);
          var data = jsonDecode(response.body);
          _controller.fetchSliderList();
          setState(() {
            isProgress = false;
            _image= null;
          });

        } else {}

        return response.body;
      });
    })
        .catchError((err) => print('error : ' + err.toString()))
        .whenComplete(() {
    });
    setState(() {

    });
  }

  //upload slider
  Future createPostRequest() async {
    setState(() {
      isProgress = true;
    });
    var postUri = Uri.parse(Helper.baseurl+"saveslider");
    var request = new http.MultipartRequest("POST", postUri);


    if (_image != null) {
      print('Not null');
      http.MultipartFile multipartFile = await http.MultipartFile.fromPath(
          'slider_image',_image.path);
      request.files.add(multipartFile);
    }
    else {
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
          _controller.fetchSliderList();
          setState(() {
            isProgress = false;
            _image= null;
          });

        } else {}

        return response.body;
      });
    })
        .catchError((err) => print('error : ' + err.toString()))
        .whenComplete(() {
    });
    setState(() {

    });
  }

  Future getImage() async {
    print("Getting img");

    final pickedFile =
    await picker.getImage(source: ImageSource.gallery, imageQuality: 100);


      setState(() {
        if (pickedFile != null) {
          _image = File(pickedFile.path);
        } else {
          print('No image selected.');
        }
      });
    }

  showAlertDialog(BuildContext context,id) {

    Widget cancelButton = FlatButton(
      child: Text("Cancel"),
      onPressed:  () {
        Navigator.pop(context);
      },
    );
    // set up the button
    Widget okButton = FlatButton(
      child: Text("Delete"),
      onPressed: () {
        deleteSLider(id);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Delete Image"),
      content: Text("Are you sure to Delete ?"),
      actions: [
        cancelButton,
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Edit Slider"),backgroundColor: Colors.lightBlueAccent[300],
      actions: [
        IconButton(onPressed: (){
          createPostRequest();
        }, icon: Text("Save"))
      ],),
      body: SingleChildScrollView(
        child: Column(
          children: [
            GestureDetector(
              child: Container(
                height: 150,
                child: isProgress ? Center(child: CircularProgressIndicator()): _image==null ? Icon(Icons.add_a_photo_outlined,size: 36,): Image.file(_image),
              ),
              onTap: (){
                getImage();
              },
            ),
            Container(
              height: MediaQuery.of(context).size.height-200,
              child: Obx(() {

                if(_controller.isLoading.value){
                  return Center (child: CircularProgressIndicator(),);
                }
                else{
                  return   ListView.builder(
                      itemCount: _controller.sliderlist.length,
                      itemBuilder: (BuildContext contex, int index){
                        return Stack(
                          children: [
                            Container(
                              margin: EdgeInsets.all(10),
                              height: 150,
                              width: MediaQuery.of(context).size.width,
                              child:      FadeInImage(
                                image: NetworkImage(
                                    Helper.baseurl+_controller.sliderlist[index].sliderImage
                                ),
                                placeholder: AssetImage('images/gif-logo.gif'),
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                            GestureDetector(
                              child: Container(
                                margin: EdgeInsets.all(10),
                                height: 150,
                                width: MediaQuery.of(context).size.width,
                                child: Align(
                                  alignment: Alignment.topRight,
                                  child: Icon(Icons.delete,size: 28,color: Colors.red,),
                                ),
                              ),
                              onTap: (){
                                showAlertDialog(context,_controller.sliderlist[index].id);
                              },
                            )
                          ],
                        );
                      });
                }
              })


            ),
          ],

        ),
      ),
    );
  }
}
