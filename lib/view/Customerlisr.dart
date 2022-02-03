import 'package:flutter/material.dart';
import 'package:happybuy/GlobalSetting/GlobalColor.dart';
import 'package:happybuy/Controller/controller.dart';
import 'package:get/get.dart';
import 'package:happybuy/Helper/helper.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomerList extends StatefulWidget {
  @override
  _CustomerListState createState() => _CustomerListState();
}

class _CustomerListState extends State<CustomerList> {
  final Controller _controller = Get.put(Controller());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _controller.fetchallUserList();
  }
  @override
  Widget build(BuildContext context) {
    return   Scaffold(
        appBar: AppBar(
          backgroundColor: GlobalColor.appbarColor,
          centerTitle: true,
          title: Title(color: Colors.blue, child: Text("Customers")),
          //   leading: Icon(Icons.arrow_back),
        ),
        body:SingleChildScrollView(
          child:  Column(
            children: [
              Obx((){
                if(_controller.isLoading.value){
                  return Center(child: CircularProgressIndicator(),);
                }
                else{
                  return Container(
                    color: Colors.grey[300],
                    height: MediaQuery.of(context).size.height-80,
                    child: ListView.builder(
                        itemCount: _controller.allUserList.length,
                        itemBuilder: (BuildContext context, int index){
                          return Container(
                              height: 100,
                              margin: EdgeInsets.only(top: 10,right: 10,left: 10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)
                              ),
                              child:Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                Container(
                                  margin: EdgeInsets.only(top: 10,bottom: 10),
                                  height: 80,
                                  width: 80,

                                  decoration: BoxDecoration(
                                      color: Colors.lightBlueAccent,
                                    borderRadius: BorderRadius.circular(45)
                                  ),
                                  // child: ClipRRect(
                                  //   borderRadius: BorderRadius.circular(8.0),
                                  //   child: FadeInImage.assetNetwork(
                                  //     height: 100,
                                  //     width: 100,
                                  //     placeholder: 'assets/img.jpg',
                                  //     image: Helper.baseurl+_controller.allUserList[index].profileimage,
                                  //     imageScale: 1.2,
                                  //   ),
                                  // ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(top: 10,bottom: 10),
                                  width: MediaQuery.of(context).size.width-250,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                    Text(_controller.allUserList[index].name),
                                    Text(_controller.allUserList[index].phone),
                                      Text(_controller.allUserList[index].email==null ? "Emial":_controller.allUserList[index].email),
                                      Text(_controller.allUserList[index].address==null?"Address":_controller.allUserList[index].address),
                                  ],),
                                ),
                                IconButton(
                                    onPressed: (){
                                      launch("tel:+88"+_controller.allUserList[index].phone);
                                    },
                                    icon: Icon(Icons.phone))
                              ],) );

                        }),

                  );
                }
              }),

            ],
          )
        ));
  }
}
////$device_id =  DB::table('tbl_user')->where('type', 'admin')->take(1)->pluck('token');