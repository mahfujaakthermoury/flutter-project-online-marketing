import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Category {
  Category({this.title, this.icon});
  final String title;
  final AssetImage icon;
}

List<Category> choices =  <Category>[
  Category(title: 'Grocery', icon: AssetImage("images/grocery.png")),
  Category(title: 'Meat & Fish', icon:  AssetImage("images/grocery.png")),
  Category(title: 'Beverages', icon:  AssetImage("images/grocery.png")),
  Category(title: 'Fruits', icon:  AssetImage("images/grocery.png")),
  Category(title: 'Vegetables', icon:  AssetImage("images/grocery.png")),
  Category(title: 'Baby Care', icon:  AssetImage("images/grocery.png")),
  Category(title: 'Hygiene', icon:  AssetImage("images/grocery.png")),
  Category(title: 'Home Appliance', icon:  AssetImage("images/grocery.png")),
];

class CategoryCard extends StatelessWidget {
  const CategoryCard({Key key, this.choice}) : super(key: key);
  final Category choice;

  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle = Theme.of(context).textTheme.bodyText2;
    return ClipRRect(
      borderRadius: BorderRadius.circular(5.0),
      child: Container(
        decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(5)),
        width: MediaQuery.of(context).size.width,
        height: 20 * MediaQuery.of(context).size.height,
        child: Column(
          children: [
            SizedBox(height: 5,),
            Image(image: choice.icon,fit: BoxFit.cover,width: 22 * MediaQuery.of(context).devicePixelRatio, height: 22 * MediaQuery.of(context).devicePixelRatio,),
            SizedBox(height: 4,),
            Text(choice.title,style: TextStyle(color: Colors.black,fontSize: 11),),
          ],
        ),
      )
    );
  }
}