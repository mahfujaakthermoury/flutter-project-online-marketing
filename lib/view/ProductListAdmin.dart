import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:happybuy/Controller/controller.dart';
import 'package:happybuy/Helper/helper.dart';
import 'package:happybuy/view/Product_edit.dart';
import 'package:happybuy/view/product_upload.dart';
import 'package:get/get.dart';
import 'package:happybuy/view/product_view.dart';
import 'package:http/http.dart' as http;
class ProductListAdmin extends StatefulWidget {
  @override
  _CreateCategoryState createState() => _CreateCategoryState();
}

class _CreateCategoryState extends State<ProductListAdmin> {

  final Controller _controller = Get.put(Controller());

  List<Color> colorlist = [
    Colors.purple[300],
    Colors.blue[300],
    Colors.red[300],
    Colors.green[300],
    Colors.purple[300],
    Colors.brown[300],
    Colors.greenAccent,
    Colors.indigo[300],
    Colors.orange[300],
    Colors.pink[300],
  ];
  Future onRefresh() async{
    _controller.fetchProductList();

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
        deleteProduct(id);
        print("delete fun call");
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Delete Product"),
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
 bool isProcess = false;
  Future deleteProduct(id) async {
    setState(() {
      isProcess = true;
    });
    print("fun active");
    var postUri = Uri.parse(Helper.baseurl+"deleteproduct");
    var request = new http.MultipartRequest("POST", postUri);
    request.fields['id'] =id.toString();

    request
        .send()
        .then((result) async {
      http.Response.fromStream(result).then((response) {
        print(response.body);
        if (response.statusCode == 200) {

          Navigator.pop(context);
          print("Deleted! ");
          print('response.body ' + response.body);
          var data = jsonDecode(response.body);
          _controller.fetchProductList();
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




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Product List"),
        actions: [
          IconButton(onPressed: (){
            Navigator.push(
                context, MaterialPageRoute(builder: (context) =>ProductAdd()));
          }, icon: Icon(Icons.add_circle_outline_outlined)),
        ],
      ),
      body:   Container(
          height: MediaQuery.of(context).size.height ,
          width: MediaQuery.of(context).size.width,
          child: Obx((){
            if(_controller.isLoadingProduct.value){
              return Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Center(child: CircularProgressIndicator()),
              );
            }
            else{
              return  RefreshIndicator(
                onRefresh: onRefresh,
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: _controller.productList.length,
                    itemBuilder: (BuildContext contex, int index) {
                      return Container(

                        margin:
                        EdgeInsets.only(left: 10, right: 10, bottom: 12),
                        width: MediaQuery.of(context).size.width,
                        height: 150,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey[300],width: 1),
                            borderRadius: BorderRadius.circular(15),
                            color:colorlist[index%10]),
                        child: Row(
                          children: [
                            Container(
                              height:
                              MediaQuery.of(context).size.width / 2 -
                                  40,
                              width: MediaQuery.of(context).size.width / 2-20,
                              child: ClipRRect(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(15),
                                    bottomLeft: Radius.circular(15)),
                                child:  FadeInImage(
                                  image: NetworkImage(_controller
                                      .productList[index].img1==null ? "https://geagletkd.com/wp-content/uploads/2017/04/default-image-620x600.jpg": Helper.baseurl+_controller.productList[index].img1),
                                  placeholder: AssetImage(
                                      'images/gif-logo.gif'),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(
                                  left: 8, top: 10, right: 5),
                              width: MediaQuery.of(context).size.width / 2-20,
                              child: Column(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    child: Text(
                                      _controller.productList[index].name,
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  Container(
                                   // / width: 90,
                                    padding: EdgeInsets.only(
                                        left: 5, top: 8, bottom: 0),
                                    child: _controller.productList[index].selling != null ? Text(
                                      "Sell Price"+ "৳ "+  _controller.productList[index].selling ,
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,color: Colors.white),
                                    ) : Text(
                                      "Sell Price"+ "৳ 0",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,color: Colors.white),
                                    ),
                                  ),
                                  Container(

                                    padding: EdgeInsets.only(
                                        left: 5, top: 8, bottom: 0),
                                    child: Text(
                                      "Price:"+"৳ "+ _controller.productList[index].price,
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,color: Colors.white),
                                    ),
                                  ),


                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          GestureDetector(
                                            child: Container(
                                              width: 40,
                                              height:20,
                                              decoration: BoxDecoration(
                                                  color: Colors.red[300],
                                                  borderRadius: BorderRadius.circular(15),
                                                  border: Border.all(color: Colors.grey[300],width: 1)
                                              ),
                                              child: Center(child: Text("Delete",style: TextStyle(fontSize: 10,color: Colors.white),)),
                                            ),
                                            onTap: (){
                                              showAlertDialog(context,_controller.productList[index].id);
                                            },
                                          ),
                                          GestureDetector(
                                            child: Container(
                                              width: 40,
                                              height:20,
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius: BorderRadius.circular(15),
                                                  border: Border.all(color: Colors.grey[300],width: 1)
                                              ),
                                              child: Center(child: Text("Edit",style: TextStyle(fontSize: 10),)),
                                            ),
                                            onTap: (){
                                              Navigator.push(
                                                  context, MaterialPageRoute(builder: (context) =>ProductEdit(_controller.productList[index])));
                                            },
                                          ),
                                          GestureDetector(
                                            child: Container(
                                              width: 40,
                                              height:20,
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius: BorderRadius.circular(15),
                                                  border: Border.all(color: Colors.grey[300],width: 1)
                                              ),
                                              child: Center(child: Text("View",style: TextStyle(fontSize: 10),)),
                                            ),
                                            onTap: (){
                                              Navigator.push(
                                                  context, MaterialPageRoute(builder: (context) =>ProductView(_controller.productList[index])));
                                            },
                                          ),
                                        ],
                                      ),
                                  SizedBox(height: 10,),

                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
              );
            }
          })

      ),
    );
  }
}
