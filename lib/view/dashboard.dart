import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:happybuy/Controller/controller.dart';
import 'package:happybuy/Drawer/AdminDrawer.dart';
import 'package:happybuy/Drawer/MainDrawer.dart';
import 'package:happybuy/view/AllUserList.dart';
import 'package:happybuy/view/ProductListAdmin.dart';
import 'package:happybuy/view/category_list.dart';
import '../view_c/product_list.dart';
import 'package:happybuy/view_c/order_tracking.dart';
import 'package:get/get.dart';
class AdminDashboard extends StatefulWidget {
  @override
  _AdminDashboardState createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {

  Widget countText(data){
    return Text(data,style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),);
  }

  Widget descText(data){
    return Text(data,style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),);
  }
  final Controller _controller = Get.put(Controller());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller.fetchProductList();
    _controller.fetchCatList();


  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AdminDrawer(),
      appBar: AppBar(title: Text("Admin Dashboard"),backgroundColor: Colors.lightBlueAccent[400],
      ),
      body: SingleChildScrollView(
        child: Obx((){
          if(_controller.categoryLoading.value){
            return Center(child: CircularProgressIndicator(),);
          }
          else{
            return Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        child: Container(
                            height: 100,
                            margin: EdgeInsets.only(left: 10,right: 5,top: 10),
                            padding: EdgeInsets.only(top: 30),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.red[300],
                            ),
                            child: Column(children: [
                              countText(_controller.summary.value.newOrder.toString()),
                              descText('New Order')
                            ],)),
                        onTap: (){
                          Navigator.push(
                              context, MaterialPageRoute(builder: (context) => OrderTracking()));
                        },
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        child: Container(
                            height: 100,
                            margin: EdgeInsets.only(left: 5,right: 5,top: 10),
                            padding: EdgeInsets.only(top: 30,left: 10,right: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.amber[300],
                            ),
                            child: Column(children: [
                              countText(_controller.summary.value.processingOrder.toString()),
                              descText('Processing')
                            ],)),
                        onTap: (){
                          Navigator.push(
                              context, MaterialPageRoute(builder: (context) => OrderTracking()));
                        },
                      ),
                    ),

                    Expanded(
                      child: GestureDetector(
                        child: Container(
                            height: 100,
                            margin: EdgeInsets.only(left: 5,right: 10,top: 10),
                            padding: EdgeInsets.only(top: 30,left: 10,right: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.blue[300],
                            ),
                            child: Column(children: [
                              countText(_controller.summary.value.driveredOrder.toString()),
                              descText('Delivered')
                            ],)),
                        onTap: (){
                          Navigator.push(
                              context, MaterialPageRoute(builder: (context) => OrderTracking()));
                        },
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        child: Container(
                            height: 100,
                            margin: EdgeInsets.only(left: 5,right: 10,top: 10),
                            padding: EdgeInsets.only(top: 30,left: 10,right: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.lightBlueAccent[300],
                            ),
                            child: Column(children: [
                              Obx(() => _controller.isLoadingProduct.value ?countText( "0"):countText(_controller.productList.length.toString() ) ),
                              descText('Total Product')
                            ],)),
                        onTap: (){
                          Navigator.push(
                              context, MaterialPageRoute(builder: (context) => ProductListAdmin()));
                        },
                      ),

                    ),

                    Expanded(
                      child: GestureDetector(
                        child: Container(
                            height: 100,
                            margin: EdgeInsets.only(left: 5,right: 10,top: 10),
                            padding: EdgeInsets.only(top: 30,left: 10,right: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.lightBlueAccent[300],
                            ),
                            child: Column(children: [
                              Obx(() => _controller.categoryLoading.value ?countText( "0"):countText(_controller.catList.length.toString() ) ),
                              descText('Total Category')
                            ],)),
                        onTap: (){
                          Navigator.push(
                              context, MaterialPageRoute(builder: (context) => CategoryList()));

                        },
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                          height: 100,
                          margin: EdgeInsets.only(left: 5,right: 10,top: 10),
                          padding: EdgeInsets.only(top: 20,left: 10,right: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.purple[300],
                          ),
                          child: Column(children: [
                            countText(_controller.summary.value.totalSelltoday.toString()),
                            descText('Total sell'),
                            descText('Today')
                          ],)),
                    ),
                    Expanded(
                      child: Container(
                          height: 100,
                          margin: EdgeInsets.only(left: 5,right: 10,top: 10),
                          padding: EdgeInsets.only(top: 20,left: 10,right: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.purple[300],
                          ),
                          child: Column(children: [
                            countText(_controller.summary.value.totalSellweek.toString()),
                            descText('Total Sell'),
                            descText('This week')
                          ],)),
                    ),
                    Expanded(
                      child: Container(
                          height: 100,
                          margin: EdgeInsets.only(left: 5,right: 10,top: 10),
                          padding: EdgeInsets.only(top: 20,left: 10,right: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.purple[300],
                          ),
                          child: Column(children: [
                            countText(_controller.summary.value.totalSellmonth.toString()),
                            descText('Total Sell'),
                            descText('This Month')
                          ],)),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        child: Container(
                            height: 100,
                            margin: EdgeInsets.only(left: 5,right: 10,top: 10),
                            padding: EdgeInsets.only(top: 20,left: 10,right: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.blue[300],
                            ),
                            child: Column(children: [
                              countText(_controller.summary.value.newCustomerThismonth.toString()),
                              descText('New Customar'),
                              descText('This Month')
                            ],)),
                        onTap: (){

                          Navigator.push(
                              context, MaterialPageRoute(builder: (context) => AllUSerList()));

                        },
                      ),
                    ),
                    Expanded(
                      child: Container(
                          height: 100,
                          margin: EdgeInsets.only(left: 5,right: 10,top: 10),
                          padding: EdgeInsets.only(top: 20,left: 10,right: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.lightBlueAccent
                            [300],
                          ),
                          child: Column(children: [
                            countText(_controller.summary.value.totalOrderThismonth.toString()),
                            descText('Total Order'),
                            descText('This Month')
                          ],)),
                    ),
                  ],
                ),

                Row(
                  children: [
                    Expanded(
                      child: Container(
                          height: 100,
                          margin: EdgeInsets.only(left: 5,right: 10,top: 10),
                          padding: EdgeInsets.only(top: 30,left: 10,right: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.blue[300],
                          ),
                          child: Column(children: [
                            countText(_controller.summary.value.totalCustomer.toString()),
                            descText('Total Customar')
                          ],)),
                    ),
                    Expanded(
                      child: Container(
                          height: 100,
                          margin: EdgeInsets.only(left: 5,right: 10,top: 10),
                          padding: EdgeInsets.only(top: 30,left: 10,right: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.lightBlueAccent[300],
                          ),
                          child: Column(children: [
                            countText(_controller.summary.value.totalCustomer.toString()),
                            descText('Total Order')
                          ],)),
                    ),
                  ],
                ),
              ],
            );
          }
        })
      ),
    );
  }
}
