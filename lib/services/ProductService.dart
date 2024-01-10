import '../data/repository.dart';
import '../model/ProductMaster.dart';
import 'dart:convert';
import 'dart:io';

class ProductService {
  late Repository _repository;
  ProductService() {
    _repository = Repository();
  }

  SaveProductMst(ProductMaster productMst) async {
    return await _repository.insertData('product_mst', productMst.productMap());
  }

  //Read All Users
  getProduct() async {
    return await _repository.readData('product_mst');
  }
}
