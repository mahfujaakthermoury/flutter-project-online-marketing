import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:happybuy/Controller/controller.dart';
class AllUSerList extends StatefulWidget {
  @override
  _AllUSerListState createState() => _AllUSerListState();
}

class _AllUSerListState extends State<AllUSerList> {
  final Controller _controller = Get.put(Controller());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller.fetchallUserList();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("All User List"),),
      body: Container(
        child:Obx((){
          if(_controller.isLoading.value){
            return Center(child: CircularProgressIndicator(),);
          }
          else{
            
            return  ListView.builder(
                itemCount:_controller.allUserList.length ,
                itemBuilder: (BuildContext context, int index){
                  return Container();
                });
          }
        })
      ),);
  }
}
