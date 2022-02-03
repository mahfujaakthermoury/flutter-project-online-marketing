class Model {

  int _id;
  int proId;
  String pName;
  int pPrice;
  int pQuantity;
  int discount;
  int tPrice;
  String pImg;

  Model(this._id, this.proId, this.pName, this.pPrice, this.pQuantity,
      this.discount, this.tPrice, this.pImg);



  int get id => _id;
  int get pid =>proId;
  String get productName => pName;
  int get productPrice => pPrice;
  int get productQuantity => pQuantity;
  int get productDiscount =>discount;
  int get t_price =>tPrice;
  String get productImg => pImg;

  // Convert a Note object into a Map object
  Map<String, dynamic> toMap() {

    var map = Map<String, dynamic>();
    if (id != null) {
      map['product_id'] = _id;
    }
    map['pro_name'] = pName;
    map['quantity']=pQuantity;
    map['price']=pPrice;
    map['discount'] = discount;
    map['tPrice']=tPrice;
    map['product_img']=pImg;

//    map['description'] = _description;
//    map['priority'] = _priority;
//    map['date'] = _date;

    return map;
  }

  Model.map(dynamic obj){

    this._id=obj['product_id'];

    this.pName=obj['pro_name'];
    this.pQuantity=obj['quantity'];

    this.pPrice=obj['price'];
    this.discount=obj['discount'];
    this.tPrice=obj['tPrice'];
    this.pImg=obj['product_img'];
  }


  // Extract a Note object from a Map object
  Model.fromMapObject(Map<String, dynamic> map) {
    this._id = map['product_id'];
    this.pName=map['product_name'];
    this.pQuantity=map['quantity'];
    this.pPrice=map['price'];

    this.discount = map['discount'];
    this.tPrice=map['tPrice'];
    this.pImg=map['pImg'];

  }


}
