import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import '../model/ProductMaster.dart';
import '../services/ProductService.dart';
import '../data/db_helper.dart';
import 'dart:developer';

void main() async {
  runApp(const MyApp());
  var _productMst = ProductMaster();
  final _productService = ProductService();

  List<ProductMaster> _productList = <ProductMaster>[];
  var products = await _productService.getProduct();
  _productList = <ProductMaster>[];
  products.forEach((product) {
    var productModel = ProductMaster();
    productModel.id = product['id'];
    productModel.product_name_mst = product['product_name_mst'];
    productModel.product_number_mst = product['product_number_mst'];
    _productList.add(productModel);
  });
  inspect(_productList);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
    );
  }
}
