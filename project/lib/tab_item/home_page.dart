import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:project/http/custom_http_req.dart';
import 'package:project/model/order_model.dart';
import 'package:http/http.dart' as http;
import 'package:project/provider/order_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    Provider.of<OrderProvider>(context, listen: false).getOrderData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //final categories = Provider.of<OrderProvider>(context).orderData;
    final categories = Provider.of<OrderProvider>(context);
    return Scaffold(
      body: ListView.builder(
          itemCount: categories.orderData.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("${categories.orderData[index].price}"),
                  Text(
                      "${categories.orderData[index].orderStatus?.orderStatusCategory?.name}"),
                ],
              ),
            );
          }),
    );
  }
}
