import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:happybuy/GlobalSetting/GlobalColor.dart';
import 'package:happybuy/Helper/user_info.dart';
import 'package:happybuy/view_c/single_order_traking.dart';
import 'package:happybuy/Controller/controller.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';

class OrderList extends StatefulWidget {
  @override
  _OrderListState createState() => _OrderListState();
}

class _OrderListState extends State<OrderList> {

  final Controller _controller = Get.put(Controller());
  UserInfo user = new UserInfo();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getUserDataFromSharedPreference();
  }
  String token = "";

  Future getUserDataFromSharedPreference() async{



    Future<String> userName = user.getName();
    await userName.then((data) {
      token = data.toString();
      print(token);
      print("name print");
      _controller.fetchOrderList(token);
    },onError: (e) {
      print(e);
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: GlobalColor.appbarColor,
        title: Text('My Orders'),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Obx((){
          if(_controller.isLoading.value){
            return Center(child: CircularProgressIndicator());
          }
          else{
            return ListView.builder(
                itemCount: _controller.orderList.length,
                itemBuilder: (BuildContext contex, int index) {
                  return GestureDetector(
                    child: Visibility(
                    //  visible: token.toString()==_controller.orderList[index].userId.toString(),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey[300]),
                        ),
                        padding: EdgeInsets.only(left: 20,top: 10,bottom: 12),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    Text("Order#:"+_controller.orderList[index].id.toString(),style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.bold)),
                                    Text("20-July-2021, 3.20PM",style: TextStyle(color: Colors.grey[400],fontSize: 10)),
                                    SizedBox(height: 10,)
                                  ],
                                ),
                                Container(
                                    margin: EdgeInsets.only(right: 20),
                                    child: Text("Total: ৳"+_controller.orderList[index].totalPrice.toString(),style: TextStyle(fontWeight: FontWeight.bold),)),

                              ],

                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [

                                Text("Estimated Delivery on Today",style: TextStyle(color: Colors.lightBlueAccent,fontSize: 12),),
                                Text(_controller.orderList[index].status,style: TextStyle(color: Colors.deepOrangeAccent,fontWeight:FontWeight.bold,fontSize: 14),),
                              ],
                            ),

                          ],
                        ),

                      ),
                    ),
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Single_Order_Tracking_Page(_controller.orderList[index])));
                    },
                  );
                });
          }
        })
      ),
    );
  }
}
