import 'package:flutter/cupertino.dart';
import 'package:project/http/custom_http_req.dart';
import 'package:project/model/category_model.dart';
import 'package:project/model/order_model.dart';
import 'package:project/model/product_model.dart';

class ProductProvider with ChangeNotifier {
  List<ProductModel> productList = [];

  getProductData() async {
    productList = await CustomhttpRequest().fatchProductData();
    notifyListeners();
  }
}
