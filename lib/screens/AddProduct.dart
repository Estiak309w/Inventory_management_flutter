import 'package:flutter/material.dart';
import '../services/ProductService.dart';
import '../model/ProductMaster.dart';
import '../model/Product.dart';
import 'dart:developer';

class AddProduct extends StatefulWidget {
  final barcodeValue;
  const AddProduct({Key? key, required this.barcodeValue}) : super(key: key);

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  var _productService = ProductService();
  var productModelMst = ProductMaster();
  var productModel = Product();
  Color _containerColor1 = Colors.pink.shade50;
  Color _containerColor2 = Colors.white;
  var status = '入庫';
  var operationType;
  bool checkProduct = true;
  int itemCount = 0;
  // List<ProductMaster> _pList = <ProductMaster>[];

  //Get product details from Product master table retrieve by barcode value/product number
  getProductMstDetails() async {
    var product_info_mst;
    try {
      product_info_mst =
          await _productService.getProductMstByNumber(widget.barcodeValue);
      product_info_mst.forEach((product) {
        setState(() {
          productModelMst.id = product['id'] ?? '';
          productModelMst.product_name_mst = product['product_name_mst'] ?? '';
          productModelMst.product_number_mst =
              product['product_number_mst'] ?? '';
        });
      });
    } catch (e) {
      print('Failed to get master data: $e');
    }
    // inspect(productModelMst);
  }

//Get product details from Product table retrieve by item number
  getProductByItemNum(itemNum) async {
    var product_info = [];
    try {
      product_info = await _productService.getProductByItemNum(itemNum);
      if (!product_info.isEmpty) {
        product_info.forEach((product) {
          setState(() {
            productModel.id = product['id'];
            productModel.quantity = product['quantity'];
            productModel.item_num = product['item_num'];
            operationType = 'update';
          });
        });
      } else {
        operationType = 'register';
      }
    } catch (e) {
      print('Failed to get product data: $e');
    }
  }

  _showSnackBar(String message) async {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.orange[200],
      ),
    );
  }

  insertProduct() async {
      var _product = Product();
      _product.id = productModel.id;
      _product.item_num = productModelMst.product_number_mst;
      _product.product_name = productModelMst.product_name_mst;
      _product.ptype = status;
      if (status == '入庫') {
        _product.quantity = (productModel?.quantity ?? 0) + itemCount;
      } else if (status == '出庫') {
        checkProduct = false;
      }
      // inspect(_product);
      if (checkProduct == true) {
        var result = await _productService.setProduct(_product);
        return result;
      } else {
        _showSnackBar('failed to insert product data');
      }
  }

  updateProduct() async {
    try {
      var _product = Product();
      _product.id = productModel.id;
      _product.item_num = productModelMst.product_number_mst;
      _product.product_name = productModelMst.product_name_mst;
      _product.ptype = status;
      if (status == '入庫') {
        _product.quantity = (productModel?.quantity ?? 0) + itemCount;
      } else if (status == '出庫') {
        if (productModel.quantity! < itemCount) {
          checkProduct = false;
        } else {
          _product.quantity = (productModel?.quantity ?? 0) - itemCount;
        }
      }
      // inspect(_product);
      if (checkProduct == true && operationType == 'update') {
        var result = await _productService.updateProduct(_product);
        return result;
      } else {
        _showSnackBar(
            'failed to update product data ! Number of item is less than expected');
      }
    } catch (e) {
      print('failed to update product');
    }
  }

  @override
  void initState() {
    getProductMstDetails().then((_) {
      getProductByItemNum(productModelMst.product_number_mst);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('入出庫登録'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // First Row: Dropdown
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      // Handle click for Text 1
                      setState(() {
                        _containerColor1 = Colors.pink.shade50;
                        _containerColor2 = Colors.white;
                        status = '入庫';
                      });
                    },
                    child: Container(
                      width: double.infinity, // Full width
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(8),
                        color: _containerColor1,
                      ),
                      child: Text(
                        '入庫',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _containerColor2 = Colors.pink.shade50;
                        _containerColor1 = Colors.white;
                        status = '出庫';
                        // if (operationType == 'register') {
                        //   _showSnackBar('登録は入庫のみ可能 ');
                        // }
                      });
                    },
                    child: Container(
                      width: double.infinity, // Full width
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(8),
                        color: _containerColor2,
                      ),
                      child: Text(
                        '出庫',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),

            // Second Row: Disabled Text Field
            Row(
              children: [
                Text('品番', textAlign: TextAlign.left),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      labelText:
                          productModelMst.product_number_mst?.toString() ??
                              widget.barcodeValue,
                    ),
                    enabled: false,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),

            Row(
              children: [
                Text('品名', textAlign: TextAlign.left),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: productModelMst.product_name_mst ??
                          'No Product available',
                    ),
                    enabled: false,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),

            // Third Row: Increase Decrease Buttons
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      itemCount = itemCount > 0 ? itemCount - 1 : 0;
                    });
                  },
                  icon: Icon(Icons.remove),
                ),
                SizedBox(width: 16),
                Text(
                  '$itemCount',
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(width: 16),
                IconButton(
                  onPressed: () {
                    setState(() {
                      itemCount = itemCount + 1;
                    });
                  },
                  icon: Icon(Icons.add),
                ),
              ],
            ),
            SizedBox(height: 20),

            const SizedBox(
              width: 10.0,
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () {
                  if (productModelMst.product_name_mst?.isEmpty ?? true) {
                    _showSnackBar('No product is available for this number ');
                  } else if (operationType == 'register') {
                    var result = insertProduct();
                    if(result != null){
                      Navigator.pop(context, result+'Product inserted');
                    }
                  } else if (operationType == 'update') {
                    var result = updateProduct();
                    if(result != null){
                      Navigator.pop(context, 'product updated');
                    }
                  }
                },
                child: Text('確定'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
