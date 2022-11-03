import 'package:flutter/cupertino.dart';
import 'package:project/http/custom_http_req.dart';
import 'package:project/model/category_model.dart';
import 'package:project/model/order_model.dart';

class CategoryProvider with ChangeNotifier {
  List<CategoryModel> categoryList = [];

  getCategoryData() async {
    categoryList = await CustomhttpRequest().fatchCategoryData();
    notifyListeners();
  }
}
