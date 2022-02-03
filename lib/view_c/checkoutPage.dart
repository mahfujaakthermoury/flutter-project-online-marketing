import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:happybuy/Controller/controller.dart';
import 'package:happybuy/Helper/SizeConfig.dart';
import 'package:happybuy/Helper/helper.dart';
import 'package:happybuy/Helper/user_info.dart';
import 'package:happybuy/db/dbModel.dart';
import 'package:happybuy/db/db_helper.dart';
import 'package:happybuy/view_c/OrderConfirmPage.dart';
import 'package:happybuy/view_c/OrderList.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:core';

class CheckoutPageView extends StatefulWidget {
  @override
  _CheckoutPageViewState createState() => _CheckoutPageViewState();
}

class _CheckoutPageViewState extends State<CheckoutPageView> {
  bool _isLoading = false;
  TextEditingController ctAddress = TextEditingController();
  TextEditingController ctPhone = TextEditingController();
  final dbHelper = DatabaseHelper.instance;
  final Controller _controller = Get.put(Controller());
  UserInfo user = new UserInfo();
  var dbjson = [];
  Future<List> _Dataquery() async {
    _controller.cartList.clear();
    final allRows = await dbHelper.queryAllRows();
    //  print('query all rows:');
    //  allRows.forEach((row) => print(row));
    // print(allRows[0]["_id"]);
    dbHelper.queryAllRows().then((notes) {
      // print(notes);
      notes.forEach((note) {
        // dbjson = dbjson + ((('{product_id: '+note['product_id'].toString()+
        //     ', product_name: '+note['product_name']+
        //     ', price: '+note['price'].toString()+
        //     ', quantity: '+note['quantity'].toString()) + "}"));
        // dbjson = dbjson +jsonEncode(note)+',' ;
        _controller.cartList.add(Model.fromMapObject(note));
        dbjson.add(note);

        //d_items.add(Model.fromMapObject(notes));
        //count.add((Model.fromMapObject(notes).pQuantity));
      });
    });
  }

  String token = "";

  Future getUserDataFromSharedPreference() async {
    Future<String> userName = user.getName();
    await userName.then((data) {
      token = data.toString();
      print(token);
      print("name print");
    }, onError: (e) {
      print(e);
    });
  }

  void indertUpdate(index) async {
    print("add to card");
    Map<String, dynamic> row = {
      DatabaseHelper.proid: _controller.cartList[index].id,
      DatabaseHelper.proName: _controller.cartList[index].productName,
      DatabaseHelper.proQuantity: _controller.cartList[index].productQuantity,
      DatabaseHelper.pImg: _controller.cartList[index].productImg,
      DatabaseHelper.proPrice: _controller.cartList[index].productPrice,
      DatabaseHelper.discount: '0',
      DatabaseHelper.tPrice:
          (double.parse(_controller.cartList[index].productPrice.toString()) *
                  _controller.cartList[index].productQuantity)
              .toString(),
    };
    final checkPro =
        await dbHelper.checkProduct(_controller.cartList[index].id.toString());
    if (checkPro == null) {
      final idupdate = await dbHelper.insert(row);
      print(idupdate.toString() + "insert");
    } else {
      final updatedata =
          await dbHelper.updateCartList(row, _controller.cartList[index].id);
      print(updatedata.toString() + "update");
      setState(() {
        //  count[index]++;
      });
    }
  }

  int totalAmount = 0;
  getTotal() {
    totalAmount = 0;
    for (var i = 0; i < _controller.cartList.length; i++) {
      totalAmount += _controller.cartList[i].productPrice *
          _controller.cartList[i].productQuantity;
    }
    setState(() {});
    return totalAmount;
  }
  Future createNotifi()async{
    Uri url = Uri.parse(Helper.baseurl + '/notify');
    var response = await http.get(
      url,
    );
    print(response);
  }

  //order create
  Future<List> createOrder() async {
    print("create order");

    // set up POST request arguments
    Uri url = Uri.parse(Helper.baseurl + '/placedorder');
    Map<String, String> headers = {"Content-type": "application/json"};

    var testdata = {
      "user_id": token,
      "shipping_address": ctAddress.text,
      "total_price": totalAmount,
      "orders": dbjson
    };
    print(testdata);
    var response = await http.post(
      url,
      headers: headers,
      body: jsonEncode(testdata),
    );
    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      setState(() {
        _isLoading = false;
      });
      _controller.cartList.clear();
      dbHelper.deleteall();
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => OrderConfirm()));
      createNotifi();
      print(response.body);
    }
    //  this API passes back the id of the new item added to the body
  }

  @override
  void initState() {
    // TODO: implement initState

    _Dataquery();
    getUserDataFromSharedPreference();
    if(_controller.userData.value.length==0){
      print("no data");

    }
    else{
      ctAddress.text=_controller.userData[0].address;
      print("has data");
    }


  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return _isLoading
        ? Scaffold(
            body: Center(
            child: CircularProgressIndicator(),
          ))
        : Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              title: Text(
                "Cart",
                style: TextStyle(fontSize: 14),
              ),
              centerTitle: false,
              backgroundColor: Colors.lightBlueAccent,
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    print("delete");
                    dbHelper.deleteall();
                    _Dataquery();
                    setState(() {});
                  },
                  child: Text("Clear",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      )),
                )
              ],
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  //Slider

                  Obx(() {
                    if (_controller.cartList.length == 0) {
                      return Container(
                        height: MediaQuery.of(context).size.height / 1.8,
                        child: Center(
                          child: Text(" No Data Please Add New Item"),
                        ),
                      );
                    } else {
                      return Container(
                        height: MediaQuery.of(context).size.height / 1.8,
                        child: ListView.builder(
                            itemCount: _controller.cartList.length,
                            itemBuilder: (BuildContext contex, int index) {
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    // width: MediaQuery.of(context).size.width * .28,
                                    // height: MediaQuery.of(context).size.height * .15,
                                    width: 100,
                                    height: 100,
                                    margin: EdgeInsets.all(10),
                                    child: Image.network(
                                      Helper.baseurl +
                                          _controller.cartList[index].pImg,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  Container(
                                    // width: MediaQuery.of(context).size.width * .7,
                                    // height: MediaQuery.of(context).size.height * .14,

                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  .5,
                                              // height: MediaQuery.of(context).size.height * .05,

                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text(
                                                          _controller
                                                              .cartList[index]
                                                              .pName,
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          )),
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                          _controller
                                                              .cartList[index]
                                                              .pQuantity
                                                              .toString(),
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                            color:
                                                                Colors.black54,
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                          )),
                                                      Text(" | ",
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                            color:
                                                                Colors.black54,
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                          )),
                                                      Text(
                                                        _controller
                                                            .cartList[index]
                                                            .pPrice
                                                            .toString(),
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black54,
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            IconButton(
                                                onPressed: () {
                                                  dbHelper.delete(_controller
                                                      .cartList[index].id);
                                                  _Dataquery();
                                                },
                                                icon: Icon(
                                                  Icons.delete,
                                                  color: Colors.red[300],
                                                )),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  .35,
                                              // height: MediaQuery.of(context).size.height * .05,

                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        "৳" +
                                                            (_controller
                                                                        .cartList[
                                                                            index]
                                                                        .productPrice *
                                                                    _controller
                                                                        .cartList[
                                                                            index]
                                                                        .productQuantity)
                                                                .toString(),
                                                        style: TextStyle(
                                                            color: Colors.amber,
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                      ),
                                                    ],
                                                  ),
                                                  // Row(
                                                  //   children: [
                                                  //     Text(
                                                  //       "৳ 180",
                                                  //       style: TextStyle(
                                                  //           decoration: TextDecoration.lineThrough,
                                                  //           decorationStyle: TextDecorationStyle.solid,
                                                  //           color: Colors.black26,
                                                  //           fontSize: 14,
                                                  //           fontWeight: FontWeight.w500),
                                                  //     ),
                                                  //     SizedBox(width: 5,),
                                                  //     Text(
                                                  //         " 20% Off ",
                                                  //         overflow: TextOverflow.ellipsis,
                                                  //         style: TextStyle(
                                                  //           color: Colors.red,
                                                  //           fontSize: 14,
                                                  //           fontWeight: FontWeight.w400,
                                                  //         )
                                                  //     ),
                                                  //   ],
                                                  // ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              // padding: EdgeInsets.fromLTRB(2, 2, 2, 2),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  ClipOval(
                                                    child: Material(
                                                      color: Colors.red[
                                                          400], // Button color
                                                      child: InkWell(
                                                        splashColor: Colors
                                                            .white70, // Splash color
                                                        onTap: () {
                                                          _controller
                                                                      .cartList[
                                                                          index]
                                                                      .pQuantity >
                                                                  1
                                                              ? _controller
                                                                  .cartList[
                                                                      index]
                                                                  .pQuantity--
                                                              : 1;
                                                          indertUpdate(index);
                                                        },
                                                        child: Icon(
                                                          Icons.remove,
                                                          color: Colors.white,
                                                          size: 18,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                      _controller
                                                          .cartList[index]
                                                          .pQuantity
                                                          .toString(),
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      )),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  ClipOval(
                                                    child: Material(
                                                      color: Colors.green[
                                                          400], // Button color
                                                      child: InkWell(
                                                        splashColor: Colors
                                                            .white, // Splash color
                                                        onTap: () {
                                                          _controller
                                                              .cartList[index]
                                                              .pQuantity++;
                                                          indertUpdate(index);
                                                        },
                                                        child: Icon(
                                                          Icons.add,
                                                          color: Colors.white,
                                                          size: 18,
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            }),
                      );
                    }
                  }),

                  Container(
                    padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   children: [
                        //     Text(
                        //         "Subtotal",
                        //         maxLines: 1,
                        //         overflow: TextOverflow.ellipsis,
                        //         style: TextStyle(
                        //           color: Colors.black,
                        //           fontSize: 17,
                        //           fontWeight: FontWeight.bold,
                        //         )
                        //     ),
                        //     Text(
                        //       "৳ 180",
                        //       style: TextStyle(
                        //           color: Colors.black,
                        //           fontSize: 16,
                        //           fontWeight: FontWeight.w400),
                        //     ),
                        //   ],
                        // ),
                        // SizedBox(height: 10,),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   children: [
                        //     Text(
                        //         "Discount",
                        //         maxLines: 1,
                        //         overflow: TextOverflow.ellipsis,
                        //         style: TextStyle(
                        //           color: Colors.black54,
                        //           fontSize: 15,
                        //           fontWeight: FontWeight.w400,
                        //         )
                        //     ),
                        //     Text(
                        //       "- "+"৳36",
                        //       style: TextStyle(
                        //           color: Colors.redAccent,
                        //           fontSize: 15,
                        //           fontWeight: FontWeight.w400),
                        //     ),
                        //   ],
                        // ),
                        // SizedBox(height: 10,),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   children: [
                        //     Text(
                        //         "Delivery fee",
                        //         maxLines: 1,
                        //         overflow: TextOverflow.ellipsis,
                        //         style: TextStyle(
                        //           color: Colors.black54,
                        //           fontSize: 15,
                        //           fontWeight: FontWeight.w400,
                        //         )
                        //     ),
                        //     Text(
                        //       "৳20",
                        //       style: TextStyle(
                        //           color: Colors.black54,
                        //           fontSize: 15,
                        //           fontWeight: FontWeight.w400),
                        //     ),
                        //   ],
                        // ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 18),
                              child: Text(
                                  _controller.cartList.length.toString() +
                                      " item",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  )),
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: 18),
                              child: Text(
                                "Total : " + getTotal().toString(),
                                style: TextStyle(
                                    color: Colors.green,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ],
                        ),
                        // Container(
                        //   //color: Colors.white,
                        //   padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                        //   child: TextField(
                        //     style: TextStyle(fontSize: 18),
                        //     controller: ctPhone,
                        //     maxLines: 2,
                        //     keyboardType: TextInputType.phone,
                        //     decoration: new InputDecoration(
                        //       contentPadding: EdgeInsets.only(left: 10),
                        //       labelText: 'Phone',
                        //       border: new OutlineInputBorder(
                        //         borderRadius: new BorderRadius.circular(10),
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        Container(
                          //color: Colors.white,
                          padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                          child: TextField(
                            style: TextStyle(fontSize: 18),
                            controller: ctAddress,
                            maxLines: 1,
                            keyboardType: TextInputType.text,
                            decoration: new InputDecoration(
                              contentPadding: EdgeInsets.only(left: 10,),
                              labelText: 'Address',
                              border: new OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            bottomNavigationBar: Container(
                // height: MediaQuery.of(context).size.height * .092,
                height: SizeConfig.safeBlockVertical * 11,
                child: Column(
                  children: [
                    OutlinedButton(
                        onPressed: () {
                          if(_controller.cartList.length>0){
                            _Dataquery();
                            createOrder();
                            setState(() {
                              _isLoading = true;
                            });
                          }

                        },
                        child: Container(
                            width: MediaQuery.of(context).size.width * .85,
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                'Checkout',
                                style: TextStyle(
                                    fontSize: 17, color: Colors.white),
                              ),
                            )),
                        style: OutlinedButton.styleFrom(
                          shape: StadiumBorder(),
                          backgroundColor: Colors.green,
                        )),
                  ],
                )));
  }
}
