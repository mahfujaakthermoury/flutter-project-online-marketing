import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:happybuy/Controller/controller.dart';
import 'package:happybuy/Helper/helper.dart';
import 'package:happybuy/Model/CartList.dart';
import 'package:happybuy/Model/ProductListModel.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
class ProductEdit extends StatefulWidget {
  ModelProductList product;
  ProductEdit(this.product);
  @override
  _CreateCategoryState createState() => _CreateCategoryState();
}

class _CreateCategoryState extends State<ProductEdit> {

  final Controller _controller = Get.put(Controller());

  bool isProgress = false;

  File _image1;
  File _image2;
  File _image3;
  File _image4;
  File _image5;

  String msg="";


  final picker = ImagePicker();
  int catID =0 ;

  TextEditingController _etName =TextEditingController();
  TextEditingController _etDesc =TextEditingController();
  TextEditingController _etPrice =TextEditingController();
  TextEditingController _etSell =TextEditingController();

  Future getImage(serial) async {
    print("Getting img");

    final pickedFile =
    await picker.getImage(source: ImageSource.gallery, imageQuality: 100);

    if(serial==1){
      setState(() {
        if (pickedFile != null) {
          _image1 = File(pickedFile.path);
        } else {
          print('No image selected.');
        }
      });
    }
    else if (serial==2){
      setState(() {
        if (pickedFile != null) {
          _image2 = File(pickedFile.path);
        } else {
          print('No image selected.');
        }
      });
    }
    else if (serial==3){
      setState(() {
        if (pickedFile != null) {
          _image3 = File(pickedFile.path);
        } else {
          print('No image selected.');
        }
      });
    }

    else if (serial==4){
      setState(() {
        if (pickedFile != null) {
          _image4 = File(pickedFile.path);
        } else {
          print('No image selected.');
        }
      });
    }

    else if (serial==5){
      setState(() {
        if (pickedFile != null) {
          _image5 = File(pickedFile.path);
        } else {
          print('No image selected.');
        }
      });
    }
    setState(() {

    });
  }

  //upload product
  Future createPostRequest() async {
    setState(() {
      isProgress = true;
    });
    var postUri = Uri.parse(Helper.baseurl+"updateproductdata");
    var request = new http.MultipartRequest("POST", postUri);
    request.fields['id'] =widget.product.id.toString();
    request.fields['category_id'] =catID.toString();
    request.fields['name'] =_etName.text;
    request.fields['price'] =_etPrice.text;
    request.fields['selling_price'] =_etSell.text;
    request.fields['description'] =_etDesc.text;


    if (_image1 != null) {
      print('Not null');
      http.MultipartFile multipartFile = await http.MultipartFile.fromPath(
          'img1',_image1.path);
      request.files.add(multipartFile);
    } else {
      print('null null');
    }
    if (_image2 != null) {
      print('Not null');
      http.MultipartFile multipartFile = await http.MultipartFile.fromPath(
          'img2',_image2.path);
      request.files.add(multipartFile);
    } else {
      print('null null');
    }
    if (_image3 != null) {
      print('Not null');
      http.MultipartFile multipartFile = await http.MultipartFile.fromPath(
          'img3',_image3.path);
      request.files.add(multipartFile);
    } else {
      print('null null');
    }
    if (_image4 != null) {
      print('Not null');
      http.MultipartFile multipartFile = await http.MultipartFile.fromPath(
          'img4',_image4.path);
      request.files.add(multipartFile);
    } else {
      print('null null');
    }
    if (_image5 != null) {
      print('Not null');
      http.MultipartFile multipartFile = await http.MultipartFile.fromPath(
          'img5',_image5.path);
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
          _controller.fetchProductList();
          setState(() {
            isProgress = false;
            _image1 = null;
            _image2 = null;
            _image3 = null;
            _image4 = null;
            _image5 = null;
            _etSell.text="";
            _etPrice.text="";
            _etName.text="";
            _etDesc.text="";
            msg=data['msg'];
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
  void initState() {
    // TODO: implement initState
    super.initState();
    _etName.text = widget.product.name;
    _etDesc.text = widget.product.description;
    _etPrice.text = widget.product.price.toString();
   _etSell.text = widget.product.selling.toString();
    catID=int.parse(widget.product.categoryId);
 }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Product Edit"),),
      body:SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              // dropdown category
              // DropdownButton<String>(
              //   items: <String>['A', 'B', 'C', 'D'].map((String value) {
              //     return DropdownMenuItem<String>(
              //       value: value,
              //       child: new Text(value),
              //     );
              //   }).toList(),
              //   onChanged: (_) {},
              // ),


              Container(
                height: 30,
                margin: EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 10),
                width: MediaQuery.of(context).size.width,
                child: ListView.builder(
                    scrollDirection:  Axis.horizontal,
                    itemCount: _controller.catList.length,
                    itemBuilder:  (BuildContext contex, int index){
                      return GestureDetector(
                        child: Visibility(
                          visible: _controller.catList[index].isActive ==1,
                          child: Container(
                            height: 30,
                            decoration: BoxDecoration(
                                color:  catID==  _controller.catList[index].id ? Colors.green[300]:Colors.grey[300],
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(color: Colors.red,width: 1)
                            ),
                            padding: EdgeInsets.only(left: 20,right: 20,top: 5,bottom: 5),
                            margin: EdgeInsets.only(left: 10,right: 10,),
                            child: Text(_controller.catList.value[index].name),
                          ),
                        ),
                        onTap: (){
                          setState(() {
                            catID = _controller.catList[index].id;
                          });
                        },
                      );
                    }),
              ),

              //product name
              Container(
                margin: EdgeInsets.all(10),

                child: TextField(
                  controller:  _etName,
                  keyboardType: TextInputType.text,
                  decoration: new InputDecoration(
                    labelText: 'Product Name',
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              //product image
              Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.all(10),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      GestureDetector(
                        child: Container(
                            margin: EdgeInsets.only(left: 5,right: 5),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Colors.grey.withOpacity(.5))
                            ),
                            height:100,
                            width: 100,
                            child:_image1!=null? Image.file(_image1): widget.product.img1 != null ? Image.network(Helper.baseurl+widget.product.img1): Icon(Icons.add_a_photo_outlined)),
                        onTap: (){
                          getImage(1);
                        },
                      ),
                      GestureDetector(
                        child: Container(
                            margin: EdgeInsets.only(left: 5,right: 5),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Colors.grey.withOpacity(.5))
                            ),
                            height:100,
                            width: 100,
                            child:_image2!=null? Image.file(_image2): widget.product.img2 != null ? Image.network(Helper.baseurl+widget.product.img2): Icon(Icons.add_a_photo_outlined)),
                        onTap: (){
                          getImage(2);
                        },
                      ),
                      GestureDetector(
                        child: Container(
                            margin: EdgeInsets.only(left: 5,right: 5),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Colors.grey.withOpacity(.5))
                            ),
                            height:100,
                            width: 100,
                            child:_image3!=null? Image.file(_image3): widget.product.img3 != null ? Image.network(Helper.baseurl+widget.product.img3): Icon(Icons.add_a_photo_outlined)),
                        onTap: (){
                          getImage(3);
                        },
                      ),
                      GestureDetector(
                        child: Container(
                            margin: EdgeInsets.only(left: 5,right: 5),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Colors.grey.withOpacity(.5))
                            ),
                            height:100,
                            width: 100,
                            child:_image4!=null? Image.file(_image4): widget.product.img4 != null ? Image.network(Helper.baseurl+widget.product.img4): Icon(Icons.add_a_photo_outlined)),
                        onTap: (){
                          getImage(4);
                        },
                      ),
                      GestureDetector(
                        child: Container(
                            margin: EdgeInsets.only(left: 5,right: 5),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Colors.grey.withOpacity(.5))
                            ),
                            height:100,
                            width: 100,
                            child:_image5!=null? Image.file(_image5): widget.product.img5 != null ? Image.network(Helper.baseurl+widget.product.img5): Icon(Icons.add_a_photo_outlined)),
                        onTap: (){
                          getImage(5);
                        },
                      ),
                    ],
                  ),
                ),
              ),
              //  product description
              Container(
                margin: EdgeInsets.all(10),
                width: MediaQuery.of(context).size.width,
                child: TextField(
                  maxLines: 3,
                  controller: _etDesc,
                  keyboardType: TextInputType.multiline,
                  decoration: new InputDecoration(
                    labelText: 'Product Description',
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              // product price
              Container(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.all(10),
                      width: MediaQuery.of(context).size.width/2-20,
                      child: TextField(
                        //  minLines: 3,
                        controller: _etPrice,
                        keyboardType: TextInputType.number,
                        decoration: new InputDecoration(
                          labelText: 'Price',
                          border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(10),
                      width: MediaQuery.of(context).size.width/2-20,
                      child: TextField(
                        // minLines: 3,
                        controller: _etSell,
                        keyboardType: TextInputType.number,
                        decoration: new InputDecoration(
                          labelText: 'Sell Price',
                          border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),

                  ],
                ),

              ),
              Container(
                margin: EdgeInsets.only(bottom: 10,top: 5),
                height: 30,
                child:isProgress ? CircularProgressIndicator() : Container(),
              ),
              GestureDetector(
                child: Container(
                  height: 50,width: 200,
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: Center(child: Text("Save",style: TextStyle(fontSize: 18,color: Colors.white),)),
                ),
                onTap: (){
                  if(_etName.text.length<3){
                    setState(() {
                      msg = "Please Input Correct Name";
                    });
                  }
                  else{
                    createPostRequest();
                  }



                },
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                child: Text(msg),
              ),
            ],
          ),

        ),
      ) ,
    );
  }
}
