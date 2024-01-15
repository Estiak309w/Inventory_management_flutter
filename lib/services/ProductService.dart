import '../data/repository.dart';
import '../model/ProductMaster.dart';
import '../model/Product.dart';
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



  getProductMst() async {
    return await _repository.readData('product_mst');
  }

  getProductMstByNumber(productNum) async{
    return await _repository.readDataById('product_mst',productNum);
  }

  //for product table only
  setProduct(Product product) async{
    return await _repository.insertData('product', product.pMap());
  }

  getProduct() async{
    return await _repository.readData('product'); 
  }
  deleteProducTable() async{
    return await _repository.dropTable('product_mst');
  }

  getProductByItemNum(productNum) async{
    return await _repository.getProductByItemNum('product',productNum);
  }

  updateProduct(Product product) async{
    return await _repository.updateData('product', product.pMap());
  }

  deleteById(productId) async{
    return await _repository.deleteDataById('product', productId);
  }

}
