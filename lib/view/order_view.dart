import 'dart:convert';
import 'package:happybuy/Helper/user_info.dart';
import 'package:happybuy/view_c/order_tracking.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:happybuy/Helper/helper.dart';
import 'package:happybuy/Model/OrderModel.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:happybuy/Controller/controller.dart';
import 'package:get/get.dart';
class OrderView extends StatefulWidget {
  ModelOrder Order;
  OrderView(this.Order);
  @override
  _CreateCategoryState createState() => _CreateCategoryState();
}

class _CreateCategoryState extends State<OrderView> {
  final Controller _controller = Get.put(Controller());
  Widget orderItemText(txt){
    return Text(txt,style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),);
  }

  String token = "";
  UserInfo user = new UserInfo();
  Future getUserDataFromSharedPreference() async{



    Future<String> userName = user.getName();
    await userName.then((data) {
      token = data.toString();
      print(token);
      print("name print");
      _controller.orderList.clear();
      _controller.fetchOrderList(token);
    },onError: (e) {
      print(e);
    });

  }

  Future processing(id) async {
    setState(() {});

    Uri url = Uri.parse(Helper.baseurl + "processingorder");
    Map data = {
      "id": id
    };
    //encode Map to JSON
    var body = json.encode(data);
    var response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: body,
    );
    if (response.statusCode == 200) {

      var jsonString = jsonDecode(response.body);

      print(response.body);
      print(jsonString["status"]);
      if (jsonString["status"] == 'success') {
        Navigator.pop(context);
        Navigator.pop(context);
        Navigator.pop(context);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => OrderTracking()));
        getUserDataFromSharedPreference();
      }

      return null;
    } else {
//show error message
      return null;
    }
  }
  Future picked(id) async {
    setState(() {});

    Uri url = Uri.parse(Helper.baseurl + "deliverorder");
    Map data = {
      "id": id
    };
    //encode Map to JSON
    var body = json.encode(data);
    var response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: body,
    );
    if (response.statusCode == 200) {

      var jsonString = jsonDecode(response.body);

      print(response.body);
      print(jsonString["status"]);
      if (jsonString["status"] == 'success') {
        Navigator.pop(context);
        Navigator.pop(context);
        Navigator.pop(context);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => OrderTracking()));
        getUserDataFromSharedPreference();
      }

      return null;
    } else {
//show error message
      return null;
    }
  }

  Future complete(id) async {
    setState(() {});

    Uri url = Uri.parse(Helper.baseurl + "completeorder");
    Map data = {
      "id": id
    };
    //encode Map to JSON
    var body = json.encode(data);
    var response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: body,
    );
    if (response.statusCode == 200) {

      var jsonString = jsonDecode(response.body);

      print(response.body);
      print(jsonString["status"]);
      if (jsonString["status"] == 'success') {
        Navigator.pop(context);
        Navigator.pop(context);
        getUserDataFromSharedPreference();
        Navigator.pop(context);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => OrderTracking()));
      }

      return null;
    } else {
//show error message
      return null;
    }
  }

  showAlertDialog(BuildContext context,status,id) {

    // set up the button
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        if(status=="placed"){
          processing(id);
        }
        if(status=="processing"){
          picked(id);
        }
        if(status=="deliver"){
          complete(id);
        }

      },
    );
    Widget noButton = TextButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Order Status"),
      content: Text("Are you sure to change Status."),
      actions: [

        noButton,
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
      appBar: AppBar(
        centerTitle: true,
        title: Text("Order Details"),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(left: 10, right: 10),
          child: Column(
            children: [
              //id
              Container(
                width: MediaQuery.of(context).size.width-20,
                  margin: EdgeInsets.only(left: 0, top: 20,right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("#" + widget.Order.id.toString(),style: TextStyle(fontWeight: FontWeight.bold)),
                      Text(widget.Order.status,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.lightBlueAccent)),
                    ],
                  )),
              //date time
              Container(
                  width: MediaQuery.of(context).size.width-20,
                  margin: EdgeInsets.only(left: 0, top: 0),
                  child: Text(widget.Order.createAt.toString(),style: TextStyle(fontWeight: FontWeight.bold))),
              //deliver address
              Container(
                width: MediaQuery.of(context).size.width-20,
                  margin: EdgeInsets.only(left: 0, top: 20),
                  child: Text("Delivered To",style: TextStyle(color: Colors.grey)),),
              Container(
                width: MediaQuery.of(context).size.width-20,
                margin: EdgeInsets.only(left: 0, top: 0),
                child: Text(widget.Order.shipping.shippingAddress,style: TextStyle(fontWeight: FontWeight.bold)),),
              //customar details
              Container(
                width: MediaQuery.of(context).size.width-20,
                margin: EdgeInsets.only(left: 0, top: 0),
                child: Text(widget.Order.user.name,style: TextStyle(color: Colors.grey)),),
              Container(
                width: MediaQuery.of(context).size.width-20,
                margin: EdgeInsets.only(left: 0, top: 0),
                child: InkWell(child: Text(widget.Order.user.phone,style: TextStyle(fontWeight: FontWeight.bold)),onTap: (){

                  launch("tel://+88"+widget.Order.user.phone);

                },),),

              //payment
              Container(
                width: MediaQuery.of(context).size.width-20,
                margin: EdgeInsets.only(left: 0, top: 20),
                child: Text("Payment Method",style: TextStyle(color: Colors.grey),),),
              Container(
                width: MediaQuery.of(context).size.width-20,
                margin: EdgeInsets.only(left: 0, bottom: 10),
                child: Text("Cash On Delivery",style: TextStyle(fontWeight: FontWeight.bold),),),
              Container(
                height: 1,
                width: MediaQuery.of(context).size.width-20,
                color: Colors.grey,
              ),
             Container(
               margin: EdgeInsets.only(top: 10),
                 height:widget.Order.details.length*32.0,
                 child: ListView.builder(
                 itemCount: widget.Order.details.length,
                 itemBuilder: (BuildContext contex, int index){
               return Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                   Container(
                    child: Row(children: [Container(child:orderItemText(widget.Order.details[index].productName+" X "),),Container(child: orderItemText(widget.Order.details[index].quantity),)],),
                   ),
                   Container(child: orderItemText("৳"+widget.Order.details[index].price),),
                 ],
               );

             })),
              Container(
                height: 1,
                width: MediaQuery.of(context).size.width-20,
                color: Colors.grey,
              ),
              Container(
                alignment: Alignment.centerRight,
                child: orderItemText("Total:    ৳"+widget.Order.totalPrice),
              ),
              widget.Order.status=='complete' ? Container():   Container(
                margin: EdgeInsets.only(top: 30),
                child:Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                 Icon(Icons.delete_outline,color: Colors.red[400],),
                   GestureDetector(
                    child: Container(
                      height: 40,
                      width: MediaQuery.of(context).size.width-100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.amber
                      ),
                      child:Center(child: widget.Order.status=="processing" ? orderItemText('Picked Order'):  widget.Order.status=="deliver" ? orderItemText('Complete Order'): orderItemText('Processing Order'),),
                    ),
                    onTap: (){
                      showAlertDialog(context,widget.Order.status,widget.Order.id);
                    },
                  )
                ],) ,
              ),

            ],
          ),
        ),
      ),
    );
  }
}
