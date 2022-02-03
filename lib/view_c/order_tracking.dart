import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:happybuy/Controller/controller.dart';
import 'package:get/get.dart';
import 'package:happybuy/view/order_view.dart';
class OrderTracking extends StatefulWidget {
  @override
  _OrderTrackingState createState() => _OrderTrackingState();
}


class _OrderTrackingState extends State<OrderTracking> with TickerProviderStateMixin {
   TabController tabController;
   final List placedOrderList = ["","","","","","","","","","","","",""];
   final Controller _controller = Get.put(Controller());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller.fetchallOrderList();
    tabController = TabController(length: 4, vsync: this, initialIndex: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Order List"),
        backgroundColor: Colors.lightBlueAccent,
        bottom: TabBar(
          controller: tabController,
          tabs: [
            Tab(text: "Placed",),
            Tab(text: "Processing ",),
            Tab(text: "Picked",),
            Tab(text: "Delivered",),
          ],
        )

      ),
      body: Obx((){
        if(_controller.isLoading.value){
          return Center(child: CircularProgressIndicator(),);
        }
        else{
          return TabBarView(
            controller: tabController,
            dragStartBehavior: DragStartBehavior.start,
            children: [
              Container(
                color: Colors.black12 ,
                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: ListView.separated(
                    separatorBuilder: (context, index) => Divider(
                      color: Colors.transparent,
                      height: 10,
                    ),
                    scrollDirection: Axis.vertical,
                    itemCount:_controller.allOrderList.length,
                    shrinkWrap: false,
                    itemBuilder: (context, index) {
                      return Visibility(
                        visible: _controller.allOrderList[index].status=="placed",
                        child: GestureDetector(
                          child: Container(
                            padding: EdgeInsets.only(left: 5,right: 5),
                            decoration: new BoxDecoration(
                              color: Colors.white70,
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.all(Radius.circular(10.0)),
                            ),
                            child : ListTile(
                                contentPadding: EdgeInsets.symmetric(horizontal: 4.0, vertical:4.0),
                                title: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("00"+_controller.allOrderList[index].id.toString(),style: TextStyle(fontSize: 17,fontWeight: FontWeight.w600,),),
                                      InkWell(
                                        splashColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        child: Container(

                                            height: 22.0,
                                            decoration: new BoxDecoration(
                                              color: Colors.transparent,
                                              shape: BoxShape.rectangle,
                                              // borderRadius: BorderRadius.only(topLeft: Radius.circular(6.0),bottomLeft: Radius.circular(6.0),topRight: Radius.circular(7.0),bottomRight: Radius.circular(7.0)),
                                            ),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Container(

                                                  height: 22.0,
                                                  padding: EdgeInsets.only(left: 5,right: 5,top: 2,bottom: 2),
                                                  decoration: new BoxDecoration(
                                                    color: Colors.deepPurple,
                                                    shape: BoxShape.rectangle,
                                                    borderRadius: BorderRadius.only(topLeft: Radius.circular(6.0),bottomLeft: Radius.circular(6.0)),
                                                  ),
                                                  child: Text(_controller.allOrderList[index].status,
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 14,
                                                        fontWeight: FontWeight.w400
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  width: 40.0,
                                                  height: 22.0,
                                                  padding: EdgeInsets.only(left: 5,right: 5,top: 2,bottom: 2),
                                                  decoration: new BoxDecoration(
                                                    color: Color(0xFFF47E08),
                                                    shape: BoxShape.rectangle,
                                                    borderRadius: BorderRadius.only(bottomRight: Radius.circular(6.0),topRight: Radius.circular(6)),
                                                  ),
                                                  child: Text("COD",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 14,
                                                        fontWeight: FontWeight.w400
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )
                                        ),
                                      )
                                    ]
                                ),
                                subtitle: Container(
                                  padding: EdgeInsets.only(top: 10),
                                  child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "৳"+_controller.allOrderList[index].totalPrice,
                                          style: TextStyle(
                                              color: Colors.amber,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700),
                                        ),
                                        Text(
                                          _controller.allOrderList[index].createAt.toString(),
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ]
                                  ),
                                )
                            ),
                          ),
                          onTap: (){

                            Navigator.push(
                                context, MaterialPageRoute(builder: (context) => OrderView(_controller.allOrderList[index])));
                          },
                        ),
                      );
                    }
                ),
              ),
              Container(
                color: Colors.black12 ,
                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: ListView.separated(
                    separatorBuilder: (context, index) => Divider(
                      color: Colors.transparent,
                      height: 10,
                    ),
                    scrollDirection: Axis.vertical,
                    itemCount:_controller.allOrderList.length,
                    shrinkWrap: false,
                    itemBuilder: (context, index) {
                      return Visibility(
                        visible: _controller.allOrderList[index].status=="processing",
                        child: GestureDetector(
                          child: Container(
                            padding: EdgeInsets.only(left: 5,right: 5),
                            decoration: new BoxDecoration(
                              color: Colors.white70,
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.all(Radius.circular(10.0)),
                            ),
                            child : ListTile(
                                contentPadding: EdgeInsets.symmetric(horizontal: 4.0, vertical:4.0),
                                title: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("00"+_controller.allOrderList[index].id.toString(),style: TextStyle(fontSize: 17,fontWeight: FontWeight.w600,),),
                                      InkWell(
                                        splashColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        child: Container(

                                            height: 22.0,
                                            decoration: new BoxDecoration(
                                              color: Colors.transparent,
                                              shape: BoxShape.rectangle,
                                              // borderRadius: BorderRadius.only(topLeft: Radius.circular(6.0),bottomLeft: Radius.circular(6.0),topRight: Radius.circular(7.0),bottomRight: Radius.circular(7.0)),
                                            ),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Container(

                                                  height: 22.0,
                                                  padding: EdgeInsets.only(left: 5,right: 5,top: 2,bottom: 2),
                                                  decoration: new BoxDecoration(
                                                    color: Colors.deepPurple,
                                                    shape: BoxShape.rectangle,
                                                    borderRadius: BorderRadius.only(topLeft: Radius.circular(6.0),bottomLeft: Radius.circular(6.0)),
                                                  ),
                                                  child: Text(_controller.allOrderList[index].status,
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 14,
                                                        fontWeight: FontWeight.w400
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  width: 40.0,
                                                  height: 22.0,
                                                  padding: EdgeInsets.only(left: 5,right: 5,top: 2,bottom: 2),
                                                  decoration: new BoxDecoration(
                                                    color: Color(0xFFF47E08),
                                                    shape: BoxShape.rectangle,
                                                    borderRadius: BorderRadius.only(bottomRight: Radius.circular(6.0),topRight: Radius.circular(6)),
                                                  ),
                                                  child: Text("COD",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 14,
                                                        fontWeight: FontWeight.w400
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )
                                        ),
                                      )
                                    ]
                                ),
                                subtitle: Container(
                                  padding: EdgeInsets.only(top: 10),
                                  child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "৳"+_controller.allOrderList[index].totalPrice,
                                          style: TextStyle(
                                              color: Colors.amber,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700),
                                        ),
                                        Text(
                                          _controller.allOrderList[index].createAt.toString(),
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ]
                                  ),
                                )
                            ),
                          ),
                          onTap: (){
                            Navigator.push(
                                context, MaterialPageRoute(builder: (context) => OrderView(_controller.allOrderList[index])));
                          },
                        ),
                      );
                    }
                ),
              ),
              Container(
                color: Colors.black12 ,
                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: ListView.separated(
                    separatorBuilder: (context, index) => Divider(
                      color: Colors.transparent,
                      height: 10,
                    ),
                    scrollDirection: Axis.vertical,
                    itemCount:_controller.allOrderList.length,
                    shrinkWrap: false,
                    itemBuilder: (context, index) {
                      return Visibility(
                        visible: _controller.allOrderList[index].status=="deliver",
                        child: GestureDetector(
                          child: Container(
                            padding: EdgeInsets.only(left: 5,right: 5),
                            decoration: new BoxDecoration(
                              color: Colors.white70,
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.all(Radius.circular(10.0)),
                            ),
                            child : ListTile(
                                contentPadding: EdgeInsets.symmetric(horizontal: 4.0, vertical:4.0),
                                title: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("00"+_controller.allOrderList[index].id.toString(),style: TextStyle(fontSize: 17,fontWeight: FontWeight.w600,),),
                                      InkWell(
                                        splashColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        child: Container(

                                            height: 22.0,
                                            decoration: new BoxDecoration(
                                              color: Colors.transparent,
                                              shape: BoxShape.rectangle,
                                              // borderRadius: BorderRadius.only(topLeft: Radius.circular(6.0),bottomLeft: Radius.circular(6.0),topRight: Radius.circular(7.0),bottomRight: Radius.circular(7.0)),
                                            ),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Container(

                                                  height: 22.0,
                                                  padding: EdgeInsets.only(left: 5,right: 5,top: 2,bottom: 2),
                                                  decoration: new BoxDecoration(
                                                    color: Colors.deepPurple,
                                                    shape: BoxShape.rectangle,
                                                    borderRadius: BorderRadius.only(topLeft: Radius.circular(6.0),bottomLeft: Radius.circular(6.0)),
                                                  ),
                                                  child: Text(_controller.allOrderList[index].status,
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 14,
                                                        fontWeight: FontWeight.w400
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  width: 40.0,
                                                  height: 22.0,
                                                  padding: EdgeInsets.only(left: 5,right: 5,top: 2,bottom: 2),
                                                  decoration: new BoxDecoration(
                                                    color: Color(0xFFF47E08),
                                                    shape: BoxShape.rectangle,
                                                    borderRadius: BorderRadius.only(bottomRight: Radius.circular(6.0),topRight: Radius.circular(6)),
                                                  ),
                                                  child: Text("COD",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 14,
                                                        fontWeight: FontWeight.w400
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )
                                        ),
                                      )
                                    ]
                                ),
                                subtitle: Container(
                                  padding: EdgeInsets.only(top: 10),
                                  child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "৳"+_controller.allOrderList[index].totalPrice,
                                          style: TextStyle(
                                              color: Colors.amber,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700),
                                        ),
                                        Text(
                                          _controller.allOrderList[index].createAt.toString(),
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ]
                                  ),
                                )
                            ),
                          ),
                          onTap: (){
                            Navigator.push(
                                context, MaterialPageRoute(builder: (context) => OrderView(_controller.allOrderList[index])));
                          },
                        ),
                      );
                    }
                ),
              ),
              Container(
                color: Colors.black12 ,
                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: ListView.separated(
                    separatorBuilder: (context, index) => Divider(
                      color: Colors.transparent,
                      height: 10,
                    ),
                    scrollDirection: Axis.vertical,
                    itemCount:_controller.allOrderList.length,
                    shrinkWrap: false,
                    itemBuilder: (context, index) {
                      return Visibility(
                        visible: _controller.allOrderList[index].status=="complete",
                        child: GestureDetector(
                          child: Container(
                            padding: EdgeInsets.only(left: 5,right: 5),
                            decoration: new BoxDecoration(
                              color: Colors.white70,
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.all(Radius.circular(10.0)),
                            ),
                            child : ListTile(
                                contentPadding: EdgeInsets.symmetric(horizontal: 4.0, vertical:4.0),
                                title: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("00"+_controller.allOrderList[index].id.toString(),style: TextStyle(fontSize: 17,fontWeight: FontWeight.w600,),),
                                      InkWell(
                                        splashColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        child: Container(

                                            height: 22.0,
                                            decoration: new BoxDecoration(
                                              color: Colors.transparent,
                                              shape: BoxShape.rectangle,
                                              // borderRadius: BorderRadius.only(topLeft: Radius.circular(6.0),bottomLeft: Radius.circular(6.0),topRight: Radius.circular(7.0),bottomRight: Radius.circular(7.0)),
                                            ),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Container(

                                                  height: 22.0,
                                                  padding: EdgeInsets.only(left: 5,right: 5,top: 2,bottom: 2),
                                                  decoration: new BoxDecoration(
                                                    color: Colors.deepPurple,
                                                    shape: BoxShape.rectangle,
                                                    borderRadius: BorderRadius.only(topLeft: Radius.circular(6.0),bottomLeft: Radius.circular(6.0)),
                                                  ),
                                                  child: Text(_controller.allOrderList[index].status,
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 14,
                                                        fontWeight: FontWeight.w400
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  width: 40.0,
                                                  height: 22.0,
                                                  padding: EdgeInsets.only(left: 5,right: 5,top: 2,bottom: 2),
                                                  decoration: new BoxDecoration(
                                                    color: Color(0xFFF47E08),
                                                    shape: BoxShape.rectangle,
                                                    borderRadius: BorderRadius.only(bottomRight: Radius.circular(6.0),topRight: Radius.circular(6)),
                                                  ),
                                                  child: Text("COD",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 14,
                                                        fontWeight: FontWeight.w400
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )
                                        ),
                                      )
                                    ]
                                ),
                                subtitle: Container(
                                  padding: EdgeInsets.only(top: 10),
                                  child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "৳"+_controller.allOrderList[index].totalPrice,
                                          style: TextStyle(
                                              color: Colors.amber,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700),
                                        ),
                                        Text(
                                          _controller.allOrderList[index].createAt.toString(),
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ]
                                  ),
                                )
                            ),
                          ),
                          onTap: (){
                            Navigator.push(
                                context, MaterialPageRoute(builder: (context) => OrderView(_controller.allOrderList[index])));
                          },
                        ),
                      );
                    }
                ),
              ),

            ],
          );
        }
      })
    );
  }
}