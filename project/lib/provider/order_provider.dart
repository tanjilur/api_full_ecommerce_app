import 'package:flutter/cupertino.dart';
import 'package:project/http/custom_http_req.dart';
import 'package:project/model/order_model.dart';

class OrderProvider with ChangeNotifier {
  List<OrderModel> orderData = [];
  late OrderModel orderModel;

  getOrderData() async {
    orderData = await CustomhttpRequest().fatchOrderData();
    notifyListeners();
  }
}
