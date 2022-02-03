import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:happybuy/Controller/controller.dart';
import 'package:happybuy/Helper/helper.dart';
import 'package:happybuy/Setting/Repositiory.dart' as ripo;
import 'package:happybuy/view/CategoryEditDelete.dart';
import 'package:happybuy/view/category_create.dart';
import 'package:http/http.dart' as http;
class CategoryList extends StatefulWidget {
  @override
  _CreateCategoryState createState() => _CreateCategoryState();
}

class _CreateCategoryState extends State<CategoryList> {
  final Controller _controller = Get.put(Controller());
 bool isProcess = false;
  Future deleteProduct(id) async {
    setState(() {
      isProcess = true;
    });
    print("fun active");
    var postUri = Uri.parse(Helper.baseurl+"deletecategory");
    var request = new http.MultipartRequest("POST", postUri);
    request.fields['id'] =id.toString();

    request
        .send()
        .then((result) async {
      http.Response.fromStream(result).then((response) {
        print(response.body);
        if (response.statusCode == 200) {
          _controller.fetchCatList();
          print("Deleted! ");
          print('response.body ' + response.body);
          var data = jsonDecode(response.body);
          setState(() {
            isProcess = false;
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
  bool isSelect = false;
  int index_select = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("All Category List"),
        actions: <Widget>[
      IconButton(
      icon: Icon(
        Icons.add_circle_outline,
        color: ripo.iconColor,
      ),
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) =>CategoryAdd()));
      },
    )
    ]
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: isProcess ? Center(child: CircularProgressIndicator()): Obx(() {
          if (_controller.categoryLoading.value) {
            return Center(
              child: CircularProgressIndicator(
                valueColor: new AlwaysStoppedAnimation<Color>(Colors.blue),
              ),
            );
          } else {
            return Container(
              margin: EdgeInsets.only(top: 10),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Obx(() {
                if (_controller.categoryLoading.value) {
                  return Center(
                    child: CircularProgressIndicator(
                      valueColor:
                      new AlwaysStoppedAnimation<Color>(Colors.red),
                    ),
                  );
                } else {
                  return ListView.builder(
                      itemCount: _controller.catList.length,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (BuildContext context, int index) {
                        return Visibility(
                       //   visible: _controller.catList[index].isActive==1,
                          child: Stack(
                            children: [
                              Container(
                                margin: EdgeInsets.all(10),
                                height: 150,
                                width: MediaQuery.of(context).size.width ,
                                decoration: BoxDecoration(
                                  color: Colors.red[200],
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Stack(
                                  children: [
                                    //TODO: for image
                                    _controller.catList[index].categoryImage == null
                                        ? ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child: Container(
                                          child: Image.asset(
                                            'images/food.jpg',
                                            fit: BoxFit.fill,
                                          )),
                                    )
                                        : FadeInImage(
                                      image: NetworkImage(Helper.baseurl +
                                         _controller.catList[index].categoryImage),
                                      placeholder:
                                      AssetImage('images/gif-logo.gif'),
                                      fit: BoxFit.cover,
                                    ),
                                    // Container(
                                    //   height:
                                    //   MediaQuery.of(context).size.width / 2 -
                                    //       40,
                                    //   child: ClipRRect(
                                    //     borderRadius: BorderRadius.circular(15),
                                    //     child: Container(
                                    //         child: Image.asset(
                                    //           'images/food.jpg',
                                    //           fit: BoxFit.fill,
                                    //         )),
                                    //   ),
                                    // ),
                                    GestureDetector(
                                      child: Container(
                                        margin: EdgeInsets.only(left: 10, top: 110,bottom: 10),
                                        height: 30,
                                        width: 80,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(15),
                                            border: Border.all(
                                                color: Colors.grey[300], width: 1)),
                                        child: Center(
                                            child: Text(
                                              "Edit Now",
                                              style: TextStyle(fontSize: 10),
                                            )),
                                      ),
                                      onTap: (){
                                        Navigator.push(
                                            context, MaterialPageRoute(builder: (context) => CategoryEdit(_controller.catList[index])));
                                      },
                                    ),

                                    Container(
                                      margin: EdgeInsets.only(left: 13, top: 80),
                                      child: Text(
                                        _controller.catList[index].name,
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              GestureDetector(
                                child: Container(
                                  padding: EdgeInsets.all(15),
                                  height: 150,
                                  width: MediaQuery.of(context).size.width ,
                                  child: Align(
                                    alignment: Alignment.topRight,
                                    child: Icon(Icons.delete,size: 24,color: Colors.white,),
                                  ),
                                ),
                                onTap: (){
                                 // deleteProduct(_controller.catList[index].id);
                                  deleteAlertDialog(_controller.catList[index].id,_controller.catList[index].name);
                                },
                              )
                            ],
                          ),
                        );
                      });
                }
              }),
            );
          }
        }),
      ),
    );
  }

  addAlertDialog(BuildContext context) {

    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("Cancel"),
      onPressed:  () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = FlatButton(
      child: Text("Add Category"),
      onPressed:  () {

      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Add New Category"),
      content:TextField(
       // controller: ct_amount,
        keyboardType:TextInputType.text,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.blue[100],
          hintText: "Barger",
          contentPadding: const EdgeInsets.only(
              left: 30.0, bottom: 8.0, top: 8.0),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue,width: 1.5),
            borderRadius: BorderRadius.circular(10),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue,width: 1.5),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
      actions: [
        cancelButton,
        continueButton,
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
  deleteAlertDialog(catID,name) {

    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("Cancel"),
      onPressed:  () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = FlatButton(
      child: Text("Delete"),
      onPressed:  () {
        Navigator.pop(context);
        deleteProduct(catID);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Are you Sure ?"),
      content:Text("Delete category $name"),
      actions: [
        cancelButton,
        continueButton,
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
}
