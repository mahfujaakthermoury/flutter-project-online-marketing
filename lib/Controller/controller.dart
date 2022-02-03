import 'package:get/get.dart';
import 'package:happybuy/Model/CartList.dart';
import 'package:happybuy/Model/OrderModel.dart';
import 'package:happybuy/Model/ProductListModel.dart';
import 'package:happybuy/Model/SliderModel.dart';
import 'package:happybuy/Model/Summary.dart';
import 'package:happybuy/Model/UserModel.dart';
import 'package:happybuy/Service/remote_service.dart';
import 'package:happybuy/db/dbModel.dart';


class Controller extends GetxController{

  var isLoading = true.obs;
  var categoryLoading = true.obs;
  var isLoadringSlider = true.obs;
  var isLoadingProduct = true.obs;
  var userData = List<UserModel>.empty().obs;
  var orderList = List<ModelOrder>.empty().obs;
  var allOrderList = List<ModelOrder>.empty().obs;
  var allUserList = List<UserModel>.empty().obs;
  var catList = List<ModelCatList>.empty().obs;
  var productList = List<ModelProductList>.empty().obs;
  var catProductList = List<ModelProductList>.empty().obs;
  var cartList = List<Model>().obs;
  var summary = Summary().obs;
  var sliderlist = List<SliderModel>.empty().obs;
  @override
  void onInit() {
    fetchCatList();
    fetchProductList();
    fetchSliderList();
    summaryList();
    // TODO: implement onInit
    super.onInit();
  }

  // void addProductToCart(ModelProductList product) {
  //   try {
  //     if (_isItemAlreadyAdded(product)) {
  //       Get.snackbar("Check your cart", "${product.name} is already added");
  //     } else {
  //       print("added");
  //       catList.value.add(product);
  //       // String itemId = Uuid().toString();
  //       // userController.updateUserData({
  //       //   "cart": FieldValue.arrayUnion([
  //       //     {
  //       //       "id": itemId,
  //       //       "productId": product.id,
  //       //       "name": product.name,
  //       //       "quantity": 1,
  //       //       "price": product.price,
  //       //       "image": product.image,
  //       //       "cost": product.price
  //       //     }
  //       //   ])
  //       // });
  //       Get.snackbar("Item added", "${product.name} was added to your cart");
  //     }
  //   } catch (e) {
  //     Get.snackbar("Error", "Cannot add this item");
  //
  //   }
  // }

  bool _isItemAlreadyAdded(ModelProductList product) =>
      catList.where((item) => item.id == product.id)
          .isNotEmpty;

  // call api for category
  void fetchCatList() async {
    try {
      categoryLoading(true);
      var data = await RemoteServices.getCategotyList();
      if (data != null) {
        catList.value = data;
      }
    } finally {
      categoryLoading(false);
    }
  }
  // call api for csummary
  void summaryList() async {
    try {
      categoryLoading(true);
      var data = await RemoteServices.getSummry();
      if (data != null) {
        summary.value = data;
      }
    } finally {
      categoryLoading(false);
    }
  }


  // call api for category
  void fetchProductList() async {
    try {
      isLoadingProduct(true);
      var data = await RemoteServices.getProductList();
      if (data != null) {
        productList.value = data;
      }
    } finally {
      isLoadingProduct(false);
    }
  }

  // call api for category
  void fetchSliderList() async {
    try {
      isLoadringSlider(true);
      var data = await RemoteServices.getSliderList();
      if (data != null) {
        sliderlist.value = data;
      }
    } finally {
      isLoadringSlider(false);
    }
  }

  // call api for category
  void fetchCatroductList(catId) async {
    try {
      isLoading(true);
      var data = await RemoteServices.getCatProductList(catId);
      if (data != null) {
        catProductList.value = data;
      }
    } finally {
      isLoading(false);
    }
  }

  // call for order by id
  void fetchOrderList(userID) async {
    try {
      isLoading(true);
      var data = await RemoteServices.getOrderList(userID);
      if (data != null) {
        orderList.value = data;
      }
    } finally {
      isLoading(false);
    }
  }

// call for order
  void fetchallOrderList() async {
    try {
      isLoading(true);
      var data = await RemoteServices.getAllOrderList();
      if (data != null) {
        allOrderList.value = data;
      }
    } finally {
      isLoading(false);
    }
  }

  // call all user
  void fetchallUserList() async {
    try {
      isLoading(true);
      var data = await RemoteServices.getAllUserList();
      if (data != null) {
        allUserList.value = data;
      }
    } finally {
      isLoading(false);
    }
  }
//single user list
  void singleUser(id) async {
    try {
      isLoading(true);
      var data = await RemoteServices.singleUserData(id);
      if (data != null) {
        userData.value = data;
      }
    } finally {
      isLoading(false);
    }
  }



}