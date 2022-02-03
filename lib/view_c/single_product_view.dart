import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:happybuy/Controller/controller.dart';
import 'package:happybuy/Helper/SizeConfig.dart';

class SingleProductView extends StatefulWidget {
  int passIndex;
  SingleProductView(this.passIndex);

  @override
  _SingleProductViewState createState() => _SingleProductViewState();
}

class _SingleProductViewState extends State<SingleProductView> {

  final Controller _controller = Get.put(Controller());
  int index;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    index = widget.passIndex;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Dream Market",style: TextStyle(fontSize: 14),),
        centerTitle: false,
        backgroundColor: Colors.lightBlueAccent,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.shopping_cart_outlined,color: Colors.white,),
            tooltip: 'Cart',
            onPressed: (){

            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              //Slider
              Container(
                height: 20,
              ),
              Image.asset(
                'images/c.jpg',
                fit: BoxFit.fill,
                width: 100 * MediaQuery.of(context).devicePixelRatio,
                height: 100 * MediaQuery.of(context).devicePixelRatio,
              ),
              Container(
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _controller.productList[index].name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      )
                    ),
                    Text(
                      "৳"+_controller.productList[index].price,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.w500),
                    ),
                  ]
                )
              ),
              Container(
                padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.star,size: 18,color: Color(0xFFf5c44b),),
                        Icon(Icons.star,size: 18,color: Color(0xFFf5c44b),),
                        Icon(Icons.star,size: 18,color: Color(0xFFf5c44b),),
                        Icon(Icons.star_border,size: 18),
                        Icon(Icons.star_border,size: 18),
                      ],
                    ),
                    Text(
                      "৳ 120",
                      style: TextStyle(
                          decoration: TextDecoration.lineThrough,
                          decorationStyle: TextDecorationStyle.solid,
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Supplier: ",
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          )
                        ),
                        Text(
                          "Happy Buy",
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          )
                        ),
                      ],
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.red,  // red as border color
                        ),
                        borderRadius: BorderRadius.circular(5),
                      ),

                      child: Text(
                        " 16% Off ",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        )
                      ),
                    )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ClipOval(
                      child: Material(
                        color: Colors.red, // Button color
                        child: InkWell(
                          splashColor: Colors.white, // Splash color
                          onTap: () {},
                          child: Icon(Icons.add,color: Colors.white,),
                        ),
                      ),
                    ),
                    SizedBox(width: 15,),
                    Text(
                        " 1 ",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.lightBlueAccent,
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                        )
                    ),
                    SizedBox(width: 15,),
                    ClipOval(
                      child: Material(
                        color: Colors.lightBlueAccent, // Button color
                        child: InkWell(
                          splashColor: Colors.white, // Splash color
                          onTap: () {},
                          child: Icon(Icons.add,color: Colors.white,),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                        "Variants",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        )
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(10, 5, 10, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    OutlinedButton(
                      onPressed: () {},
                      child: Row(
                        children: [
                          Icon(Icons.add),
                          SizedBox(width: 5,),
                          Text(
                            "1 pc",
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.lightBlueAccent,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            )
                          ),
                        ],
                      ),
                      style: OutlinedButton.styleFrom(
                        shape: StadiumBorder(),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                        "Description",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 17,
                          fontWeight: FontWeight.w400,
                        )
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                        "Supplied by Happy Buy",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                        )
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10, left: 10, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Reviews (3)",
                      style:
                      TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "See All",
                      style: TextStyle(fontWeight: FontWeight.w400,color: Colors.lightBlueAccent),
                    ),
                  ],
                ),
              ),
              Container(
                // width: MediaQuery.of(context).size.width,
                width: SizeConfig.blockSizeHorizontal * 100,
                padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                child:  Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      child: Text(' T ',style: TextStyle(color: Colors.white),),
                      style: ElevatedButton.styleFrom(
                        shape: CircleBorder(),
                        padding: EdgeInsets.all(14),
                      ),
                    ),
                    SizedBox(width: 10,),
                    Container(
                      // width: MediaQuery.of(context).size.width * .6,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                              "Zia Khan",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              )
                          ),
                          Row(
                            children: [
                              Icon(Icons.star,color: Color(0xFFFFCF23),size: 15,),
                              Icon(Icons.star,color: Color(0xFFFFCF23),size: 15,),
                              Icon(Icons.star,color: Color(0xFFFFCF23),size: 15,),
                              Icon(Icons.star,color: Color(0xFFFFCF23),size: 15,),
                              Icon(Icons.star,color: Color(0xFFFFCF23),size: 15,),
                            ],
                          )
                        ],
                      ),
                    ),
                    SizedBox(width: SizeConfig.blockSizeHorizontal * 38,),
                    Text(
                        "Jun 13, 2021",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        )
                    ),
                  ],
                )
              ),
              Container(
                  width: SizeConfig.blockSizeHorizontal * 100,
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child:  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        child: Text(' T ',style: TextStyle(color: Colors.white),),
                        style: ElevatedButton.styleFrom(
                          shape: CircleBorder(),
                          padding: EdgeInsets.all(14),
                        ),
                      ),
                      SizedBox(width: 10,),
                      Container(
                        // width: MediaQuery.of(context).size.width * .6,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                                "Zia Khan",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                )
                            ),
                            Row(
                              children: [
                                Icon(Icons.star,color: Color(0xFFFFCF23),size: 15,),
                                Icon(Icons.star,color: Color(0xFFFFCF23),size: 15,),
                                Icon(Icons.star,color: Color(0xFFFFCF23),size: 15,),
                                Icon(Icons.star,color: Color(0xFFFFCF23),size: 15,),
                                Icon(Icons.star,color: Color(0xFFFFCF23),size: 15,),
                              ],
                            )
                          ],
                        ),
                      ),
                      SizedBox(width: SizeConfig.blockSizeHorizontal * 38,),
                      Text(
                          "Jun 13, 2021",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          )
                      ),
                    ],
                  )
              ),
              Container(
                margin: EdgeInsets.only(top: 10, left: 10, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Related Products",
                      style:
                      TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),

              GridView.count(
                padding: const EdgeInsets.only(left :15.0, right: 15,top: 2,bottom: 6),
                primary: false,
                childAspectRatio: SizeConfig.safeBlockHorizontal /
                    (SizeConfig.safeBlockVertical / 2),
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                crossAxisCount: 2,
                shrinkWrap: true,
                children: List.generate(_controller.productList.length, (index) {
                return GestureDetector(
                  child: Container(
                    // height: MediaQuery.of(context).size.height* 20,
                    decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(10),),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // SizedBox(height: 10,),
                        Image.asset(
                          'images/c.jpg',
                          fit: BoxFit.fill,
                          width: 32 * SizeConfig.safeBlockHorizontal,
                          height: 13 * SizeConfig.safeBlockVertical,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: SizeConfig.safeBlockVertical * 2.5,
                              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                              child: Text(
                                _controller.productList[index].name,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            // SizedBox(height: 2,),
                            Container(
                              height: SizeConfig.safeBlockVertical * 2.5,
                              padding: EdgeInsets.fromLTRB(10, 0, 10, 5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    "৳"+_controller.productList[index].price,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  // SizedBox(width: 15,),
                                  Text(
                                    "৳ 120",
                                    style: TextStyle(
                                        decoration: TextDecoration.lineThrough,
                                        decorationStyle: TextDecorationStyle.solid,
                                        color: Colors.black,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    "1 pc",
                                    style: TextStyle(
                                        decorationStyle: TextDecorationStyle.solid,
                                        color: Colors.black,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              )
                            ),
                            GestureDetector(
                              child: Container(
                                  width: SizeConfig.safeBlockHorizontal * 23,
                                  height: SizeConfig.safeBlockVertical * 2.5,
                                  decoration: BoxDecoration(color: Colors.lightBlueAccent,borderRadius: BorderRadius.circular(10)),
                                  child : Text("Add to Cart",style: TextStyle(color: Colors.white),textAlign: TextAlign.center,)
                              ),
                              onTap: (){

                              },
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  onTap: () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SingleProductView(index)),
                    )
                  },
                );
              })
              ),
            ],
          ),
        ),
      ),
    );
  }

}
