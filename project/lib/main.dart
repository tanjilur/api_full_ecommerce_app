import 'package:flutter/material.dart';
import 'package:project/provider/category_provider.dart';
import 'package:project/provider/order_provider.dart';
import 'package:project/provider/product_provider.dart';
import 'package:project/screen/login_page.dart';
import 'package:project/screen/registration_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<OrderProvider>(
      create: (_) => OrderProvider(),
    ),
    ChangeNotifierProvider<CategoryProvider>(
      create: (_) => CategoryProvider(),
    ),
    ChangeNotifierProvider<ProductProvider>(
      create: (_) => ProductProvider(),
    ),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
    );
  }
}
