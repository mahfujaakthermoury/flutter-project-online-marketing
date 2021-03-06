import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:happybuy/Helper/SizeConfig.dart';
import 'package:happybuy/Model/OrderModel.dart';

class Single_Order_Tracking_Page extends StatefulWidget {
  ModelOrder order;
  Single_Order_Tracking_Page(this.order);
  @override
  Single_Order_Tracking_PageState createState() =>
      new Single_Order_Tracking_PageState();
}

class Single_Order_Tracking_PageState
    extends State<Single_Order_Tracking_Page> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Track Orders",
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            // width: SizeConfig.safeBlockHorizontal * 100,
            // height: SizeConfig.safeBlockVertical * 100,
            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
            child: Card(
              margin: EdgeInsets.all(2),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: SizeConfig.safeBlockHorizontal * 100,
                    height: SizeConfig.safeBlockVertical * 4,
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 20,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Order Id: ",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                           widget.order.id.toString(),
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w300),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    height: 5,
                    thickness: 1,
                    color: Colors.black12,
                  ),
                  Container(
                    height: widget.order.details.length * 100.0,
                    child: Flexible(child: ListView.builder(
                        itemCount: widget.order.details.length,
                        itemBuilder: (BuildContext contex, int index){
                      return Container(
                        height: 100,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  width: SizeConfig.blockSizeHorizontal * 59,
                                  height: SizeConfig.safeBlockVertical * 12,
                                  padding: EdgeInsets.only(left: 20, right: 20),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(widget.order.details[index].productName,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                            )),
                                      ),
                                      SizedBox(
                                        height: SizeConfig.safeBlockVertical * 2,
                                      ),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "??? "+widget.order.details[index].price.toString(),
                                          style: TextStyle(
                                              color: Colors.redAccent,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 4),
                              height: 1,
                              width: MediaQuery.of(context).size.width,
                              color: Colors.grey,
                            ),
                          ],
                        ),
                      );
                    })),
                  ),
                  Divider(
                    height: 5,
                    thickness: 1,
                    color: Colors.black12,
                  ),
               widget.order.status=="placed" ?  placedOrder() : Container(),


               // confirmOrder()
                // readyToShipOrder()
                 //orderPickUp()
                 // orderDelivered(),
                ],
              ),
            ),
          ),
        ));
  }
  Widget placedOrder(){
   return Container(
        width: SizeConfig.safeBlockHorizontal * 100,
        height: SizeConfig.safeBlockVertical * 55,
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
                width: SizeConfig.safeBlockHorizontal * 100,
                padding:
                EdgeInsets.only(left: 20, right: 20, top: 10),
                child: Text(
                  "Track Orders",
                  style: TextStyle(fontWeight: FontWeight.bold),
                )),
            Container(
              width: SizeConfig.safeBlockHorizontal * 100,
              height: SizeConfig.safeBlockVertical * 10,
              // padding: EdgeInsets.only(left: 20,right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Container(
                        width: 3,
                        height: SizeConfig.safeBlockVertical * 4,
                        color: Colors.transparent,
                      ),
                      Container(
                        width: SizeConfig.safeBlockVertical * 2,
                        height: SizeConfig.safeBlockVertical * 2,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.lightBlueAccent,
                        ),
                      ),
                      Container(
                        width: 3,
                        height: SizeConfig.safeBlockVertical * 4,
                        color: Colors.grey[400],
                      ),
                    ],
                  ),
                  Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.lightBlueAccent[300],
                          borderRadius:
                          BorderRadius.circular(30)),
                      child: Icon(
                        Icons.watch_later_outlined,
                        color: Colors.white,
                      )),
                  Container(
                    width: SizeConfig.safeBlockHorizontal * 60,
                    height: SizeConfig.safeBlockVertical * 9,
                    // color: Colors.green,
                    // padding: EdgeInsets.only(left: 15,top: 10),
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Order Placed",
                            style: TextStyle(
                                color: Colors.lightBlueAccent,
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Your Order Placed. Wait for Confirm your Order",
                            maxLines: 2,
                            style: TextStyle(
                                color: Colors.lightBlueAccent,
                                fontSize: 14,
                                fontWeight: FontWeight.w300),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              width: SizeConfig.safeBlockHorizontal * 100,
              height: SizeConfig.safeBlockVertical * 10,
              //  padding: EdgeInsets.only(left: 20,right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Container(
                        width: 3,
                        height: SizeConfig.safeBlockVertical * 4,
                        color: Colors.grey[400],
                      ),
                      Container(
                        width: SizeConfig.safeBlockVertical * 2,
                        height: SizeConfig.safeBlockVertical * 2,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.grey[400],
                        ),
                      ),
                      Container(
                        width: 3,
                        height: SizeConfig.safeBlockVertical * 4,
                        color: Colors.grey[400],
                      ),
                    ],
                  ),
                  Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.grey[400],
                          borderRadius:
                          BorderRadius.circular(30)),
                      child: Icon(
                        Icons.check,
                        color: Colors.white,
                      )),
                  Container(
                    width: SizeConfig.safeBlockHorizontal * 60,
                    height: SizeConfig.safeBlockVertical * 9,
                    // color: Colors.green,
                    // padding: EdgeInsets.only(left: 15,top: 10),
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Order Confirm",
                            style: TextStyle(
                                color: Colors.grey[400],
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Order Confirmed. Soon your Order Ready to ship.",
                            maxLines: 2,
                            style: TextStyle(
                                color: Colors.grey[400],
                                fontSize: 14,
                                fontWeight: FontWeight.w300),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              width: SizeConfig.safeBlockHorizontal * 100,
              height: SizeConfig.safeBlockVertical * 10,
              //  padding: EdgeInsets.only(left: 20,right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Container(
                        width: 3,
                        height: SizeConfig.safeBlockVertical * 4,
                        color: Colors.grey[400],
                      ),
                      Container(
                        width: SizeConfig.safeBlockVertical * 2,
                        height: SizeConfig.safeBlockVertical * 2,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.grey[400],
                        ),
                      ),
                      Container(
                        width: 3,
                        height: SizeConfig.safeBlockVertical * 4,
                        color: Colors.grey[400],
                      ),
                    ],
                  ),
                  Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.grey[400],
                          borderRadius:
                          BorderRadius.circular(30)),
                      child: Icon(
                        Icons.check_box,
                        color: Colors.white,
                      )),
                  Container(
                    width: SizeConfig.safeBlockHorizontal * 60,
                    height: SizeConfig.safeBlockVertical * 9,
                    // color: Colors.green,
                    // padding: EdgeInsets.only(left: 15,top: 10),
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Ready To Ship",
                            style: TextStyle(
                                color: Colors.grey[400],
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Your Order Ready. Waiting for hand over delivery Man",
                            maxLines: 2,
                            style: TextStyle(
                                color: Colors.grey[400],
                                fontSize: 14,
                                fontWeight: FontWeight.w300),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              width: SizeConfig.safeBlockHorizontal * 100,
              height: SizeConfig.safeBlockVertical * 10,
              //  padding: EdgeInsets.only(left: 20,right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Container(
                        width: 3,
                        height: SizeConfig.safeBlockVertical * 4,
                        color: Colors.grey[400],
                      ),
                      Container(
                        width: SizeConfig.safeBlockVertical * 2,
                        height: SizeConfig.safeBlockVertical * 2,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.grey[400],
                        ),
                      ),
                      Container(
                        width: 3,
                        height: SizeConfig.safeBlockVertical * 4,
                        color: Colors.grey[400],
                      ),
                    ],
                  ),
                  Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.grey[400],
                          borderRadius:
                          BorderRadius.circular(30)),
                      child: Icon(
                        Icons.local_shipping_outlined,
                        color: Colors.white,
                      )),
                  Container(
                    width: SizeConfig.safeBlockHorizontal * 60,
                    height: SizeConfig.safeBlockVertical * 9,
                    // color: Colors.green,
                    // padding: EdgeInsets.only(left: 15,top: 10),
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Order Pick Up",
                            style: TextStyle(
                                color: Colors.grey[400],
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Soon your parcel arrived your shipping address.",
                            maxLines: 2,
                            style: TextStyle(
                                color: Colors.grey[400],
                                fontSize: 14,
                                fontWeight: FontWeight.w300),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              width: SizeConfig.safeBlockHorizontal * 100,
              height: SizeConfig.safeBlockVertical * 10,
              //  padding: EdgeInsets.only(left: 20,right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Container(
                        width: 3,
                        height: SizeConfig.safeBlockVertical * 4,
                        color: Colors.grey[400],
                      ),
                      Container(
                        width: SizeConfig.safeBlockVertical * 2,
                        height: SizeConfig.safeBlockVertical * 2,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.grey[400],
                        ),
                      ),
                      Container(
                        width: 3,
                        height: SizeConfig.safeBlockVertical * 4,
                        color: Colors.transparent,
                      ),
                    ],
                  ),
                  Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.grey[400],
                          borderRadius:
                          BorderRadius.circular(30)),
                      child: Icon(
                        Icons.home_outlined,
                        color: Colors.white,
                      )),
                  Container(
                    width: SizeConfig.safeBlockHorizontal * 60,
                    height: SizeConfig.safeBlockVertical * 9,
                    // color: Colors.green,
                    // padding: EdgeInsets.only(left: 15,top: 10),
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Delivered",
                            style: TextStyle(
                                color: Colors.grey[400],
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Order Delivered.\nThanks For Order in Happy Buy.",
                            maxLines: 2,
                            style: TextStyle(
                                color: Colors.grey[400],
                                fontSize: 14,
                                fontWeight: FontWeight.w300),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ));
  }

  Widget confirmOrder(){
    return Container(
        width: SizeConfig.safeBlockHorizontal * 100,
        height: SizeConfig.safeBlockVertical * 55,
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
                width: SizeConfig.safeBlockHorizontal * 100,
                padding:
                EdgeInsets.only(left: 20, right: 20, top: 10),
                child: Text(
                  "Track Orders",
                  style: TextStyle(fontWeight: FontWeight.bold),
                )),
            Container(
              width: SizeConfig.safeBlockHorizontal * 100,
              height: SizeConfig.safeBlockVertical * 10,
              // padding: EdgeInsets.only(left: 20,right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Container(
                        width: 3,
                        height: SizeConfig.safeBlockVertical * 4,
                        color: Colors.transparent,
                      ),
                      Container(
                        width: SizeConfig.safeBlockVertical * 2,
                        height: SizeConfig.safeBlockVertical * 2,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.orange[400],
                        ),
                      ),
                      Container(
                        width: 3,
                        height: SizeConfig.safeBlockVertical * 4,
                        color: Colors.orange[400],
                      ),
                    ],
                  ),
                  Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.orange[400],
                          borderRadius:
                          BorderRadius.circular(30)),
                      child: Icon(
                        Icons.watch_later_outlined,
                        color: Colors.white,
                      )),
                  Container(
                    width: SizeConfig.safeBlockHorizontal * 60,
                    height: SizeConfig.safeBlockVertical * 9,
                    // color: Colors.green,
                    // padding: EdgeInsets.only(left: 15,top: 10),
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Order Placed",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Your Order Placed. Wait for Confirm your Order",
                            maxLines: 2,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w300),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              width: SizeConfig.safeBlockHorizontal * 100,
              height: SizeConfig.safeBlockVertical * 10,
              //  padding: EdgeInsets.only(left: 20,right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Container(
                        width: 3,
                        height: SizeConfig.safeBlockVertical * 4,
                        color: Colors.orange[400],
                      ),
                      Container(
                        width: SizeConfig.safeBlockVertical * 2,
                        height: SizeConfig.safeBlockVertical * 2,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.lightBlueAccent[400],
                        ),
                      ),
                      Container(
                        width: 3,
                        height: SizeConfig.safeBlockVertical * 4,
                        color: Colors.grey[400],
                      ),
                    ],
                  ),
                  Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.lightBlueAccent[400],
                          borderRadius:
                          BorderRadius.circular(30)),
                      child: Icon(
                        Icons.check,
                        color: Colors.white,
                      )),
                  Container(
                    width: SizeConfig.safeBlockHorizontal * 60,
                    height: SizeConfig.safeBlockVertical * 9,
                    // color: Colors.green,
                    // padding: EdgeInsets.only(left: 15,top: 10),
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Order Confirm",
                            style: TextStyle(
                                color: Colors.lightBlueAccent[400],
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Order Confirmed. Soon your Order Ready to ship.",
                            maxLines: 2,
                            style: TextStyle(
                                color: Colors.lightBlueAccent[400],
                                fontSize: 14,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              width: SizeConfig.safeBlockHorizontal * 100,
              height: SizeConfig.safeBlockVertical * 10,
              //  padding: EdgeInsets.only(left: 20,right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Container(
                        width: 3,
                        height: SizeConfig.safeBlockVertical * 4,
                        color: Colors.grey[400],
                      ),
                      Container(
                        width: SizeConfig.safeBlockVertical * 2,
                        height: SizeConfig.safeBlockVertical * 2,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.grey[400],
                        ),
                      ),
                      Container(
                        width: 3,
                        height: SizeConfig.safeBlockVertical * 4,
                        color: Colors.grey[400],
                      ),
                    ],
                  ),
                  Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.grey[400],
                          borderRadius:
                          BorderRadius.circular(30)),
                      child: Icon(
                        Icons.check_box,
                        color: Colors.white,
                      )),
                  Container(
                    width: SizeConfig.safeBlockHorizontal * 60,
                    height: SizeConfig.safeBlockVertical * 9,
                    // color: Colors.green,
                    // padding: EdgeInsets.only(left: 15,top: 10),
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Ready To Ship",
                            style: TextStyle(
                                color: Colors.grey[400],
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Your Order Ready. Waiting for hand over delivery Man",
                            maxLines: 2,
                            style: TextStyle(
                                color: Colors.grey[400],
                                fontSize: 14,
                                fontWeight: FontWeight.w300),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              width: SizeConfig.safeBlockHorizontal * 100,
              height: SizeConfig.safeBlockVertical * 10,
              //  padding: EdgeInsets.only(left: 20,right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Container(
                        width: 3,
                        height: SizeConfig.safeBlockVertical * 4,
                        color: Colors.grey[400],
                      ),
                      Container(
                        width: SizeConfig.safeBlockVertical * 2,
                        height: SizeConfig.safeBlockVertical * 2,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.grey[400],
                        ),
                      ),
                      Container(
                        width: 3,
                        height: SizeConfig.safeBlockVertical * 4,
                        color: Colors.grey[400],
                      ),
                    ],
                  ),
                  Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.grey[400],
                          borderRadius:
                          BorderRadius.circular(30)),
                      child: Icon(
                        Icons.local_shipping_outlined,
                        color: Colors.white,
                      )),
                  Container(
                    width: SizeConfig.safeBlockHorizontal * 60,
                    height: SizeConfig.safeBlockVertical * 9,
                    // color: Colors.green,
                    // padding: EdgeInsets.only(left: 15,top: 10),
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Order Pick Up",
                            style: TextStyle(
                                color: Colors.grey[400],
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Soon your parcel arrived your shipping address.",
                            maxLines: 2,
                            style: TextStyle(
                                color: Colors.grey[400],
                                fontSize: 14,
                                fontWeight: FontWeight.w300),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              width: SizeConfig.safeBlockHorizontal * 100,
              height: SizeConfig.safeBlockVertical * 10,
              //  padding: EdgeInsets.only(left: 20,right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Container(
                        width: 3,
                        height: SizeConfig.safeBlockVertical * 4,
                        color: Colors.grey[400],
                      ),
                      Container(
                        width: SizeConfig.safeBlockVertical * 2,
                        height: SizeConfig.safeBlockVertical * 2,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.grey[400],
                        ),
                      ),
                      Container(
                        width: 3,
                        height: SizeConfig.safeBlockVertical * 4,
                        color: Colors.transparent,
                      ),
                    ],
                  ),
                  Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.grey[400],
                          borderRadius:
                          BorderRadius.circular(30)),
                      child: Icon(
                        Icons.home_outlined,
                        color: Colors.white,
                      )),
                  Container(
                    width: SizeConfig.safeBlockHorizontal * 60,
                    height: SizeConfig.safeBlockVertical * 9,
                    // color: Colors.green,
                    // padding: EdgeInsets.only(left: 15,top: 10),
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Delivered",
                            style: TextStyle(
                                color: Colors.grey[400],
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Order Delivered.\nThanks For Order in Happy Buy.",
                            maxLines: 2,
                            style: TextStyle(
                                color: Colors.grey[400],
                                fontSize: 14,
                                fontWeight: FontWeight.w300),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ));
  }

  Widget readyToShipOrder(){
    return Container(
        width: SizeConfig.safeBlockHorizontal * 100,
        height: SizeConfig.safeBlockVertical * 55,
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
                width: SizeConfig.safeBlockHorizontal * 100,
                padding:
                EdgeInsets.only(left: 20, right: 20, top: 10),
                child: Text(
                  "Track Orders",
                  style: TextStyle(fontWeight: FontWeight.bold),
                )),
            Container(
              width: SizeConfig.safeBlockHorizontal * 100,
              height: SizeConfig.safeBlockVertical * 10,
              // padding: EdgeInsets.only(left: 20,right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Container(
                        width: 3,
                        height: SizeConfig.safeBlockVertical * 4,
                        color: Colors.transparent,
                      ),
                      Container(
                        width: SizeConfig.safeBlockVertical * 2,
                        height: SizeConfig.safeBlockVertical * 2,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color:Colors.orange[400],
                        ),
                      ),
                      Container(
                        width: 3,
                        height: SizeConfig.safeBlockVertical * 4,
                        color: Colors.orange[400],
                      ),
                    ],
                  ),
                  Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.orange[400],
                          borderRadius:
                          BorderRadius.circular(30)),
                      child: Icon(
                        Icons.watch_later_outlined,
                        color: Colors.white,
                      )),
                  Container(
                    width: SizeConfig.safeBlockHorizontal * 60,
                    height: SizeConfig.safeBlockVertical * 9,
                    // color: Colors.green,
                    // padding: EdgeInsets.only(left: 15,top: 10),
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Order Placed",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Your Order Placed. Wait for Confirm your Order",
                            maxLines: 2,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              width: SizeConfig.safeBlockHorizontal * 100,
              height: SizeConfig.safeBlockVertical * 10,
              //  padding: EdgeInsets.only(left: 20,right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Container(
                        width: 3,
                        height: SizeConfig.safeBlockVertical * 4,
                        color: Colors.orange[400],
                      ),
                      Container(
                        width: SizeConfig.safeBlockVertical * 2,
                        height: SizeConfig.safeBlockVertical * 2,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.orange[400],
                        ),
                      ),
                      Container(
                        width: 3,
                        height: SizeConfig.safeBlockVertical * 4,
                        color: Colors.orange[400],
                      ),
                    ],
                  ),
                  Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.orange[400],
                          borderRadius:
                          BorderRadius.circular(30)),
                      child: Icon(
                        Icons.check,
                        color: Colors.white,
                      )),
                  Container(
                    width: SizeConfig.safeBlockHorizontal * 60,
                    height: SizeConfig.safeBlockVertical * 9,
                    // color: Colors.green,
                    // padding: EdgeInsets.only(left: 15,top: 10),
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Order Confirm",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Order Confirmed. Soon your Order Ready to ship.",
                            maxLines: 2,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              width: SizeConfig.safeBlockHorizontal * 100,
              height: SizeConfig.safeBlockVertical * 10,
              //  padding: EdgeInsets.only(left: 20,right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Container(
                        width: 3,
                        height: SizeConfig.safeBlockVertical * 4,
                        color: Colors.orange[400],
                      ),
                      Container(
                        width: SizeConfig.safeBlockVertical * 2,
                        height: SizeConfig.safeBlockVertical * 2,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.lightBlueAccent[400],
                        ),
                      ),
                      Container(
                        width: 3,
                        height: SizeConfig.safeBlockVertical * 4,
                        color: Colors.grey[400],
                      ),
                    ],
                  ),
                  Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.lightBlueAccent[400],
                          borderRadius:
                          BorderRadius.circular(30)),
                      child: Icon(
                        Icons.check_box,
                        color: Colors.white,
                      )),
                  Container(
                    width: SizeConfig.safeBlockHorizontal * 60,
                    height: SizeConfig.safeBlockVertical * 9,
                    // color: Colors.green,
                    // padding: EdgeInsets.only(left: 15,top: 10),
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Ready To Ship",
                            style: TextStyle(
                                color: Colors.lightBlueAccent[400],
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Your Order Ready. Waiting for hand over delivery Man",
                            maxLines: 2,
                            style: TextStyle(
                                color: Colors.lightBlueAccent[400],
                                fontSize: 14,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              width: SizeConfig.safeBlockHorizontal * 100,
              height: SizeConfig.safeBlockVertical * 10,
              //  padding: EdgeInsets.only(left: 20,right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Container(
                        width: 3,
                        height: SizeConfig.safeBlockVertical * 4,
                        color: Colors.grey[400],
                      ),
                      Container(
                        width: SizeConfig.safeBlockVertical * 2,
                        height: SizeConfig.safeBlockVertical * 2,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.grey[400],
                        ),
                      ),
                      Container(
                        width: 3,
                        height: SizeConfig.safeBlockVertical * 4,
                        color: Colors.grey[400],
                      ),
                    ],
                  ),
                  Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.grey[400],
                          borderRadius:
                          BorderRadius.circular(30)),
                      child: Icon(
                        Icons.local_shipping_outlined,
                        color: Colors.white,
                      )),
                  Container(
                    width: SizeConfig.safeBlockHorizontal * 60,
                    height: SizeConfig.safeBlockVertical * 9,
                    // color: Colors.green,
                    // padding: EdgeInsets.only(left: 15,top: 10),
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Order Pick Up",
                            style: TextStyle(
                                color: Colors.grey[400],
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Soon your parcel arrived your shipping address.",
                            maxLines: 2,
                            style: TextStyle(
                                color: Colors.grey[400],
                                fontSize: 14,
                                fontWeight: FontWeight.w300),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              width: SizeConfig.safeBlockHorizontal * 100,
              height: SizeConfig.safeBlockVertical * 10,
              //  padding: EdgeInsets.only(left: 20,right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Container(
                        width: 3,
                        height: SizeConfig.safeBlockVertical * 4,
                        color: Colors.grey[400],
                      ),
                      Container(
                        width: SizeConfig.safeBlockVertical * 2,
                        height: SizeConfig.safeBlockVertical * 2,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.grey[400],
                        ),
                      ),
                      Container(
                        width: 3,
                        height: SizeConfig.safeBlockVertical * 4,
                        color: Colors.transparent,
                      ),
                    ],
                  ),
                  Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.grey[400],
                          borderRadius:
                          BorderRadius.circular(30)),
                      child: Icon(
                        Icons.home_outlined,
                        color: Colors.white,
                      )),
                  Container(
                    width: SizeConfig.safeBlockHorizontal * 60,
                    height: SizeConfig.safeBlockVertical * 9,
                    // color: Colors.green,
                    // padding: EdgeInsets.only(left: 15,top: 10),
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Delivered",
                            style: TextStyle(
                                color: Colors.grey[400],
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Order Delivered.\nThanks For Order in Happy Buy.",
                            maxLines: 2,
                            style: TextStyle(
                                color: Colors.grey[400],
                                fontSize: 14,
                                fontWeight: FontWeight.w300),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ));
  }

  Widget orderPickUp(){
    return Container(
        width: SizeConfig.safeBlockHorizontal * 100,
        height: SizeConfig.safeBlockVertical * 55,
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
                width: SizeConfig.safeBlockHorizontal * 100,
                padding:
                EdgeInsets.only(left: 20, right: 20, top: 10),
                child: Text(
                  "Track Orders",
                  style: TextStyle(fontWeight: FontWeight.bold),
                )),
            Container(
              width: SizeConfig.safeBlockHorizontal * 100,
              height: SizeConfig.safeBlockVertical * 10,
              // padding: EdgeInsets.only(left: 20,right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Container(
                        width: 3,
                        height: SizeConfig.safeBlockVertical * 4,
                        color: Colors.transparent,
                      ),
                      Container(
                        width: SizeConfig.safeBlockVertical * 2,
                        height: SizeConfig.safeBlockVertical * 2,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.orange[400],
                        ),
                      ),
                      Container(
                        width: 3,
                        height: SizeConfig.safeBlockVertical * 4,
                        color: Colors.orange[400],
                      ),
                    ],
                  ),
                  Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.orange[400],
                          borderRadius:
                          BorderRadius.circular(30)),
                      child: Icon(
                        Icons.watch_later_outlined,
                        color: Colors.white,
                      )),
                  Container(
                    width: SizeConfig.safeBlockHorizontal * 60,
                    height: SizeConfig.safeBlockVertical * 9,
                    // color: Colors.green,
                    // padding: EdgeInsets.only(left: 15,top: 10),
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Order Placed",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Your Order Placed. Wait for Confirm your Order",
                            maxLines: 2,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              width: SizeConfig.safeBlockHorizontal * 100,
              height: SizeConfig.safeBlockVertical * 10,
              //  padding: EdgeInsets.only(left: 20,right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Container(
                        width: 3,
                        height: SizeConfig.safeBlockVertical * 4,
                        color: Colors.orange[400],
                      ),
                      Container(
                        width: SizeConfig.safeBlockVertical * 2,
                        height: SizeConfig.safeBlockVertical * 2,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.orange[400],
                        ),
                      ),
                      Container(
                        width: 3,
                        height: SizeConfig.safeBlockVertical * 4,
                        color: Colors.orange[400],
                      ),
                    ],
                  ),
                  Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.orange[400],
                          borderRadius:
                          BorderRadius.circular(30)),
                      child: Icon(
                        Icons.check,
                        color: Colors.white,
                      )),
                  Container(
                    width: SizeConfig.safeBlockHorizontal * 60,
                    height: SizeConfig.safeBlockVertical * 9,
                    // color: Colors.green,
                    // padding: EdgeInsets.only(left: 15,top: 10),
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Order Confirm",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Order Confirmed. Soon your Order Ready to ship.",
                            maxLines: 2,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              width: SizeConfig.safeBlockHorizontal * 100,
              height: SizeConfig.safeBlockVertical * 10,
              //  padding: EdgeInsets.only(left: 20,right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Container(
                        width: 3,
                        height: SizeConfig.safeBlockVertical * 4,
                        color: Colors.orange[400],
                      ),
                      Container(
                        width: SizeConfig.safeBlockVertical * 2,
                        height: SizeConfig.safeBlockVertical * 2,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.orange[400],
                        ),
                      ),
                      Container(
                        width: 3,
                        height: SizeConfig.safeBlockVertical * 4,
                        color: Colors.orange[400],
                      ),
                    ],
                  ),
                  Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.orange[400],
                          borderRadius:
                          BorderRadius.circular(30)),
                      child: Icon(
                        Icons.check_box,
                        color: Colors.white,
                      )),
                  Container(
                    width: SizeConfig.safeBlockHorizontal * 60,
                    height: SizeConfig.safeBlockVertical * 9,
                    // color: Colors.green,
                    // padding: EdgeInsets.only(left: 15,top: 10),
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Ready To Ship",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Your Order Ready. Waiting for hand over delivery Man",
                            maxLines: 2,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              width: SizeConfig.safeBlockHorizontal * 100,
              height: SizeConfig.safeBlockVertical * 10,
              //  padding: EdgeInsets.only(left: 20,right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Container(
                        width: 3,
                        height: SizeConfig.safeBlockVertical * 4,
                        color: Colors.orange[400],
                      ),
                      Container(
                        width: SizeConfig.safeBlockVertical * 2,
                        height: SizeConfig.safeBlockVertical * 2,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.lightBlueAccent[400],
                        ),
                      ),
                      Container(
                        width: 3,
                        height: SizeConfig.safeBlockVertical * 4,
                        color: Colors.grey[400],
                      ),
                    ],
                  ),
                  Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.lightBlueAccent[400],
                          borderRadius:
                          BorderRadius.circular(30)),
                      child: Icon(
                        Icons.local_shipping_outlined,
                        color: Colors.white,
                      )),
                  Container(
                    width: SizeConfig.safeBlockHorizontal * 60,
                    height: SizeConfig.safeBlockVertical * 9,
                    // color: Colors.green,
                    // padding: EdgeInsets.only(left: 15,top: 10),
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Order Pick Up",
                            style: TextStyle(
                                color: Colors.lightBlueAccent[400],
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Soon your parcel arrived your shipping address.",
                            maxLines: 2,
                            style: TextStyle(
                                color: Colors.lightBlueAccent[400],
                                fontSize: 14,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              width: SizeConfig.safeBlockHorizontal * 100,
              height: SizeConfig.safeBlockVertical * 10,
              //  padding: EdgeInsets.only(left: 20,right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Container(
                        width: 3,
                        height: SizeConfig.safeBlockVertical * 4,
                        color: Colors.grey[400],
                      ),
                      Container(
                        width: SizeConfig.safeBlockVertical * 2,
                        height: SizeConfig.safeBlockVertical * 2,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.grey[400],
                        ),
                      ),
                      Container(
                        width: 3,
                        height: SizeConfig.safeBlockVertical * 4,
                        color: Colors.transparent,
                      ),
                    ],
                  ),
                  Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.grey[400],
                          borderRadius:
                          BorderRadius.circular(30)),
                      child: Icon(
                        Icons.home_outlined,
                        color: Colors.white,
                      )),
                  Container(
                    width: SizeConfig.safeBlockHorizontal * 60,
                    height: SizeConfig.safeBlockVertical * 9,
                    // color: Colors.green,
                    // padding: EdgeInsets.only(left: 15,top: 10),
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Delivered",
                            style: TextStyle(
                                color: Colors.grey[400],
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Order Delivered.\nThanks For Order in Happy Buy.",
                            maxLines: 2,
                            style: TextStyle(
                                color: Colors.grey[400],
                                fontSize: 14,
                                fontWeight: FontWeight.w300),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ));
  }
  Widget orderDelivered(){
    return Container(
        width: SizeConfig.safeBlockHorizontal * 100,
        height: SizeConfig.safeBlockVertical * 55,
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
                width: SizeConfig.safeBlockHorizontal * 100,
                padding:
                EdgeInsets.only(left: 20, right: 20, top: 10),
                child: Text(
                  "Track Orders",
                  style: TextStyle(fontWeight: FontWeight.bold),
                )),
            Container(
              width: SizeConfig.safeBlockHorizontal * 100,
              height: SizeConfig.safeBlockVertical * 10,
              // padding: EdgeInsets.only(left: 20,right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Container(
                        width: 3,
                        height: SizeConfig.safeBlockVertical * 4,
                        color: Colors.transparent,
                      ),
                      Container(
                        width: SizeConfig.safeBlockVertical * 2,
                        height: SizeConfig.safeBlockVertical * 2,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.orange[400],
                        ),
                      ),
                      Container(
                        width: 3,
                        height: SizeConfig.safeBlockVertical * 4,
                        color: Colors.orange[400],
                      ),
                    ],
                  ),
                  Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.orange[400],
                          borderRadius:
                          BorderRadius.circular(30)),
                      child: Icon(
                        Icons.watch_later_outlined,
                        color: Colors.white,
                      )),
                  Container(
                    width: SizeConfig.safeBlockHorizontal * 60,
                    height: SizeConfig.safeBlockVertical * 9,
                    // color: Colors.green,
                    // padding: EdgeInsets.only(left: 15,top: 10),
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Order Placed",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Your Order Placed. Wait for Confirm your Order",
                            maxLines: 2,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              width: SizeConfig.safeBlockHorizontal * 100,
              height: SizeConfig.safeBlockVertical * 10,
              //  padding: EdgeInsets.only(left: 20,right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Container(
                        width: 3,
                        height: SizeConfig.safeBlockVertical * 4,
                        color: Colors.orange[400],
                      ),
                      Container(
                        width: SizeConfig.safeBlockVertical * 2,
                        height: SizeConfig.safeBlockVertical * 2,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.orange[400],
                        ),
                      ),
                      Container(
                        width: 3,
                        height: SizeConfig.safeBlockVertical * 4,
                        color: Colors.orange[400],
                      ),
                    ],
                  ),
                  Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.orange[400],
                          borderRadius:
                          BorderRadius.circular(30)),
                      child: Icon(
                        Icons.check,
                        color: Colors.white,
                      )),
                  Container(
                    width: SizeConfig.safeBlockHorizontal * 60,
                    height: SizeConfig.safeBlockVertical * 9,
                    // color: Colors.green,
                    // padding: EdgeInsets.only(left: 15,top: 10),
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Order Confirm",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Order Confirmed. Soon your Order Ready to ship.",
                            maxLines: 2,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              width: SizeConfig.safeBlockHorizontal * 100,
              height: SizeConfig.safeBlockVertical * 10,
              //  padding: EdgeInsets.only(left: 20,right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Container(
                        width: 3,
                        height: SizeConfig.safeBlockVertical * 4,
                        color: Colors.orange[400],
                      ),
                      Container(
                        width: SizeConfig.safeBlockVertical * 2,
                        height: SizeConfig.safeBlockVertical * 2,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.orange[400],
                        ),
                      ),
                      Container(
                        width: 3,
                        height: SizeConfig.safeBlockVertical * 4,
                        color: Colors.orange[400],
                      ),
                    ],
                  ),
                  Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.orange[400],
                          borderRadius:
                          BorderRadius.circular(30)),
                      child: Icon(
                        Icons.check_box,
                        color: Colors.white,
                      )),
                  Container(
                    width: SizeConfig.safeBlockHorizontal * 60,
                    height: SizeConfig.safeBlockVertical * 9,
                    // color: Colors.green,
                    // padding: EdgeInsets.only(left: 15,top: 10),
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Ready To Ship",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Your Order Ready. Waiting for hand over delivery Man",
                            maxLines: 2,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              width: SizeConfig.safeBlockHorizontal * 100,
              height: SizeConfig.safeBlockVertical * 10,
              //  padding: EdgeInsets.only(left: 20,right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Container(
                        width: 3,
                        height: SizeConfig.safeBlockVertical * 4,
                        color: Colors.orange[400],
                      ),
                      Container(
                        width: SizeConfig.safeBlockVertical * 2,
                        height: SizeConfig.safeBlockVertical * 2,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.orange[400],
                        ),
                      ),
                      Container(
                        width: 3,
                        height: SizeConfig.safeBlockVertical * 4,
                        color: Colors.orange[400],
                      ),
                    ],
                  ),
                  Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.orange[400],
                          borderRadius:
                          BorderRadius.circular(30)),
                      child: Icon(
                        Icons.local_shipping_outlined,
                        color: Colors.white,
                      )),
                  Container(
                    width: SizeConfig.safeBlockHorizontal * 60,
                    height: SizeConfig.safeBlockVertical * 9,
                    // color: Colors.green,
                    // padding: EdgeInsets.only(left: 15,top: 10),
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Order Pick Up",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Soon your parcel arrived your shipping address.",
                            maxLines: 2,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              width: SizeConfig.safeBlockHorizontal * 100,
              height: SizeConfig.safeBlockVertical * 10,
              //  padding: EdgeInsets.only(left: 20,right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Container(
                        width: 3,
                        height: SizeConfig.safeBlockVertical * 4,
                        color: Colors.orange[400],
                      ),
                      Container(
                        width: SizeConfig.safeBlockVertical * 2,
                        height: SizeConfig.safeBlockVertical * 2,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.lightBlueAccent[400],
                        ),
                      ),
                      Container(
                        width: 3,
                        height: SizeConfig.safeBlockVertical * 4,
                        color: Colors.transparent,
                      ),
                    ],
                  ),
                  Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.lightBlueAccent[400],
                          borderRadius:
                          BorderRadius.circular(30)),
                      child: Icon(
                        Icons.home_outlined,
                        color: Colors.white,
                      )),
                  Container(
                    width: SizeConfig.safeBlockHorizontal * 60,
                    height: SizeConfig.safeBlockVertical * 9,
                    // color: Colors.green,
                    // padding: EdgeInsets.only(left: 15,top: 10),
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Delivered",
                            style: TextStyle(
                                color: Colors.lightBlueAccent[400],
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Order Delivered.\nThanks For Order in Happy Buy.",
                            maxLines: 2,
                            style: TextStyle(
                                color: Colors.lightBlueAccent[400],
                                fontSize: 14,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ));
  }
}

