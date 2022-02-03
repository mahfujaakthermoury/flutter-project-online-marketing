import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:happybuy/Controller/controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:happybuy/GlobalSetting/GlobalColor.dart';
import 'package:happybuy/Helper/helper.dart';
import 'package:happybuy/Model/ProductListModel.dart';
import 'package:get/get.dart';
import 'package:happybuy/db/dbModel.dart';
import 'package:happybuy/db/db_helper.dart';
import 'package:happybuy/view/CartList.dart';
import 'package:happybuy/view_c/checkoutPage.dart';

class ProductView extends StatefulWidget {
  ModelProductList product;
  ProductView(this.product);
  @override
  _CreateCategoryState createState() => _CreateCategoryState();
}

class _CreateCategoryState extends State<ProductView> {
  final Controller _controller = Get.put(Controller());
 int quantity = 0;
  nothing(){}
  List<String> imgList = List();
  addImageInList(){


  widget.product.img1 != null ? imgList.add(widget.product.img1) :  nothing();
  widget.product.img2 != null ? imgList.add(widget.product.img2) :  nothing();
  widget.product.img3 != null ? imgList.add(widget.product.img3) :  nothing();
  widget.product.img4 != null ? imgList.add(widget.product.img4) :  nothing();
  widget.product.img5 != null ? imgList.add(widget.product.img5) :  nothing();
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   addImageInList();
  }



  final dbHelper = DatabaseHelper.instance;
  //var cartList = List<Model>.empty();
 // List<Model> cartList = new List();
  List<int> test = List();

  Future<List> _Dataquery() async {
    _controller.cartList.clear();
    final allRows = await dbHelper.queryAllRows();
    print('query all rows:');
    allRows.forEach((row) => print(row));
   // print(allRows[0]["_id"]);
    print("no data printed");
    dbHelper.queryAllRows().then((notes) {
    // print(notes);
        notes.forEach((note) {
         // print(note);
        _controller.cartList.add(Model.fromMapObject(note));
          test.add(1);
          // d_items.add(Model.fromMapObject(notes));
          // count.add((Model.fromMapObject(notes).pQuantity));
        });


    });
  }


  void indertUpdate() async {
    print("add to card");
    Map<String, dynamic> row = {
      DatabaseHelper.proid:  widget.product.id,
      DatabaseHelper.proName:  widget.product.name,
      DatabaseHelper.proQuantity: quantity+1,
      DatabaseHelper.pImg : widget.product.img1,
      DatabaseHelper.proPrice:  widget.product.price,
      DatabaseHelper.discount:  '0',
      DatabaseHelper.tPrice:(double.parse(widget.product.price) * quantity).toString(),

    };
    final checkPro =
    await dbHelper.checkProduct(widget.product.id.toString());
    if (checkPro == null) {
      final idupdate = await dbHelper.insert(row);
      print(idupdate.toString() + "insert");
    } else {
      setState(() {
      //  count[index]++;
      });

      final updatedata = await dbHelper.updateCartList(
          row, widget.product.id);
      print(updatedata.toString() + "update");
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Container(
        height: MediaQuery.of(context).size.height,
        color: Colors.white,
        child: Column(
          children: [
            Container(
                height: MediaQuery.of(context).size.height - 60,
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 30),
                          height: 300,
                          width: MediaQuery.of(context).size.width,
                          child: CarouselSlider.builder(
                            itemCount: imgList.length,
                            itemBuilder: (BuildContext contex, int index, int realIdx){
                              return Container(
                                height: 300,
                                width: MediaQuery.of(context).size.width,
                                child:
                                FadeInImage(
                                  image: NetworkImage(Helper.baseurl+imgList[index]
                                  ),
                                  placeholder: AssetImage('images/gif-logo.gif'),
                                  fit: BoxFit.cover,
                                ),
                                // CachedNetworkImage(
                                //   imageUrl:NetworkImage(Helper.baseurl+imgList[index]).toString(),
                                //   placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                                //   errorWidget: (context, url, error) => Icon(Icons.error),
                                //   fit: BoxFit.fill,
                                // ),
                              );
                            },
                            //Slider Container properties
                            options: CarouselOptions(
                              autoPlay: true,
                              height: 300,
                              viewportFraction: 1.0,
                              enlargeCenterPage: false,

                            ),
                          ),
                        ),

                        Container(
                          margin: EdgeInsets.only(top: 40, left: 10, right: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                               icon:Icon(Icons.arrow_back_ios,),
                                color: Colors.black,
                                onPressed: (){
                                 Navigator.pop(context);
                                },
                              ),
                              Icon(
                                Icons.share,
                                color: Colors.grey,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        //price
                        Container(
                          margin: EdgeInsets.only(
                              left: 20, right: 20, top: 15, bottom: 10),
                          child: Text("",
                              style:
                                  TextStyle(fontSize: 24, color: Colors.red)),
                        ),
                       widget.product.selling==null ?  Container(
                         margin: EdgeInsets.only(
                             left: 20, right: 20, top: 15, bottom: 10),
                         child: Text("\৳ "+widget.product.price,
                             style:
                             TextStyle(fontSize: 24, color: Colors.red)),
                       ):Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(
                                  left: 20, right: 20, top: 10, bottom: 00),
                              child: Text("\৳ "+widget.product.selling,
                                  style:
                                      TextStyle(fontSize: 24, color: Colors.red)),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                  left: 20, right: 20, top: 0, bottom: 10),
                              child: Text("\৳ "+widget.product.price,
                                  style:
                                  TextStyle(fontSize: 16, color: Colors.grey,decoration: TextDecoration.lineThrough)),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Container(
                      color: Colors.grey[200],
                      height: 5,
                      width: MediaQuery.of(context).size.width,
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          left: 20, right: 20, top: 15, bottom: 10),
                      child: Text(widget.product.name,
                          style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold)),
                    ),
                    Container(
                      color: Colors.grey[200],
                      height: 5,
                      width: MediaQuery.of(context).size.width,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          padding:
                              EdgeInsets.only(left: 15, top: 15, bottom: 10,right: 10),
                          child: Text(widget.product.description,
                            maxLines: 10,
                              style: TextStyle(fontSize: 18),),
                        ),
                        // Container(
                        //   margin:
                        //       EdgeInsets.only(right: 20, top: 15, bottom: 10),
                        //   child: Icon(Icons.arrow_forward_ios_outlined),
                        // )
                      ],
                    ),
                    // Container(
                    //   color: Colors.grey[200],
                    //   height: 5,
                    //   width: MediaQuery.of(context).size.width,
                    // ),
                  ],
                )),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 1,
              color: Colors.grey[300],
            ),
            Container(
              height: 58,

              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    child: Stack(
                      children: [
                        Container(
                          padding: EdgeInsets.only(top: 5, bottom: 4,left: 10,right: 10),
                          margin: EdgeInsets.only(left: 10,top: 8),
                          height: 50,
                          width:50,

                          decoration: BoxDecoration(
                            color: GlobalColor.highlightTextColor,
                            border: Border.all(color: Colors.green),
                            borderRadius: BorderRadius.circular(45)
                          ),
                          child: Center(
                            child: Column(
                              children: [
                                Icon( Icons.shopping_cart_outlined,size: 24,color: Colors.white),
                                Text(
                                  "Cart",
                                  style: TextStyle(fontSize: 12,color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: Container(
                            padding: EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              color: Colors.lightBlueAccent,
                              borderRadius: BorderRadius.circular(45),
                            ),
                              margin: EdgeInsets.only(left: 42,top: 6),
                              child: Text(quantity.toString(),style: TextStyle(fontSize:10,fontWeight:FontWeight.bold,color: Colors.white),)),
                        )
                      ],
                    ),
                    onTap: (){
                      Navigator.push(
                          context, MaterialPageRoute(builder: (context) =>CheckoutPageView()));
                    //  indertUpdate();
                    },
                  ),
                  GestureDetector(
                    child: Container(
                      margin: EdgeInsets.only(left: 10, right: 10),
                      padding: EdgeInsets.only(left: 10, right: 10),
                      height: 40,
                      width: 120,
                      decoration: BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Center(
                          child: Text(
                        "Add to Card",
                        style: TextStyle(color: Colors.white),
                      )),
                    ),
                    onTap: (){
                      indertUpdate();
                      setState(() {
                        quantity++;
                      });

                    },
                  ),
                  GestureDetector(
                    child: Container(
                      margin: EdgeInsets.only(left: 10, right: 10),
                      padding: EdgeInsets.only(left: 10, right: 10),
                      height: 40,
                      width: 120,
                      decoration: BoxDecoration(
                        color: Colors.red[400],
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Center(
                          child: Text(
                        "Buy Now",
                        style: TextStyle(color: Colors.white),
                      )),
                    ),
                    onTap: (){
                      indertUpdate();
                      setState(() {
                        quantity++;
                      });
                      Navigator.push(
                          context, MaterialPageRoute(builder: (context) =>CheckoutPageView()));

                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
