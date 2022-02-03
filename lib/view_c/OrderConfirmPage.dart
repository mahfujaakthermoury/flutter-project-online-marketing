import 'package:flutter/material.dart';
import 'package:happybuy/view_c/OrderList.dart';
class OrderConfirm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Order Submit"),),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Thank You ",style: TextStyle(fontSize: 18),),
              Text(" Your Order Placed ",style: TextStyle(fontSize: 22,color: Colors.lightBlueAccent),),
              Text(" We deliver Your Order Soon",style: TextStyle(fontSize: 18),),
              SizedBox(height: 50,),
              InkWell(child: Text("View Order >>"),onTap: (){
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => OrderList()));
              },)
            ],
          ),
        ),
      ),
    );
  }
}
