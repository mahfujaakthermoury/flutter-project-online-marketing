import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:happybuy/Controller/controller.dart';
import 'package:happybuy/GlobalSetting/GlobalColor.dart';
import 'package:happybuy/Helper/helper.dart';
import 'package:happybuy/Model/CartList.dart';
import 'package:happybuy/view/product_upload.dart';
import 'package:get/get.dart';
import 'package:happybuy/view/product_view.dart';
class CategoryProduct extends StatefulWidget {
  ModelCatList category;
  CategoryProduct(this.category);
  @override
  _CategoryProductState createState() => _CategoryProductState();
}

class _CategoryProductState extends State<CategoryProduct> {
  final Controller _controller = Get.put(Controller());
  Future onRefresh() async{
    _controller.fetchProductList();

  }

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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller.fetchCatroductList(widget.category.id);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.category.name),),
    body:Container(
        height: MediaQuery.of(context).size.height ,
        width: MediaQuery.of(context).size.width,
        child: Obx((){
          if(_controller.isLoading.value){
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
                  itemCount: _controller.catProductList.length,
                  itemBuilder: (BuildContext contex, int index) {
                    return  _controller.catProductList.length==0 ? Center(child: Text("No product Available"),) :
                    GestureDetector(
                      child: Container(
                        margin: EdgeInsets.only(
                            left: 10, right: 10, bottom: 12),
                        width: MediaQuery.of(context).size.width,
                        height: 150,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.grey[300], width: 1),
                            borderRadius: BorderRadius.circular(15),
                            color: colorlist[index % 10]),
                        child: Row(
                          children: [
                            Container(
                              height:
                              MediaQuery.of(context).size.width / 2 -
                                  40,
                              width:
                              MediaQuery.of(context).size.width / 2 -
                                  20,
                              child: ClipRRect(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(15),
                                    bottomLeft: Radius.circular(15)),
                                child:FadeInImage(
                                  image: NetworkImage(_controller
                                      .catProductList[index].img1==null ? "https://geagletkd.com/wp-content/uploads/2017/04/default-image-620x600.jpg": Helper.baseurl+_controller.catProductList[index].img1),
                                  placeholder: AssetImage(
                                      'images/gif-logo.gif'),
                                  fit: BoxFit.fill,
                                ),

                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(
                                  left: 8, top: 10, right: 5),
                              width:
                              MediaQuery.of(context).size.width / 2 -
                                  20,
                              child: Column(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    child: Text(
                                      _controller.catProductList[index].name,
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      _controller.catProductList[index]
                                          .selling ==
                                          null
                                          ? Container(
                                        width: 80,
                                        padding: EdgeInsets.only(
                                            left: 5,
                                            top: 8,
                                            bottom: 15),
                                        child: Text(
                                          "৳ " +
                                              _controller
                                                  .catProductList[
                                              index]
                                                  .price,
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight:
                                              FontWeight.w500,
                                              color: Colors.white),
                                        ),
                                      )
                                          : Column(
                                        children: [
                                          Container(
                                            width: 80,
                                            padding:
                                            EdgeInsets.only(
                                                left: 5,
                                                top: 8,
                                                bottom: 0),
                                            child: Text(
                                              "৳ " +
                                                  _controller
                                                      .catProductList[
                                                  index]
                                                      .selling,
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight:
                                                  FontWeight
                                                      .w500,
                                                  color:
                                                  Colors.white),
                                            ),
                                          ),
                                          Container(
                                            width: 80,
                                            padding:
                                            EdgeInsets.only(
                                                left: 5,
                                                top: 0,
                                                bottom: 15),
                                            child: Text(
                                              "৳ " +
                                                  _controller
                                                      .catProductList[
                                                  index]
                                                      .price,
                                              style: TextStyle(
                                                  decoration:
                                                  TextDecoration
                                                      .lineThrough,
                                                  fontSize: 16,
                                                  fontWeight:
                                                  FontWeight
                                                      .w500,
                                                  color:
                                                  Colors.white),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Container(
                                        width: 60,
                                        height: 20,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                            BorderRadius.circular(15),
                                            border: Border.all(
                                                color: Colors.grey[300],
                                                width: 1)),
                                        child: Center(
                                            child: Text(
                                              "View",
                                              style: TextStyle(fontSize: 10),
                                            )),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProductView(
                                    _controller.catProductList[index])));
                      },
                    );
                  }),
            );
          }
        })

    ),
    );
  }
}
