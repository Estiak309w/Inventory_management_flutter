import 'dart:async';

import 'package:flutter/material.dart';
import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:flutter/services.dart';
import '../model/ProductMaster.dart';
import '../model/Product.dart';
import '../services/ProductService.dart';
import '../screens/AddProduct.dart';
import 'dart:developer';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  var product_name = '';
  var product_number = '';
  List<Product> _pList = <Product>[];
  final _productService = ProductService();

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  // Get Product List from Product table to display in first page
  getAllProductDetails() async {
    var products = await _productService.getProduct();
    _pList = [];
    products.forEach((product) {
      setState(() {
        var productModel = Product();
        productModel.id = product['id'];
        productModel.product_name = product['product_name'];
        productModel.item_num = product['item_num'];
        productModel.quantity = product['quantity'];
        productModel.ptype = product['ptype'];
        _pList.add(productModel);
      });
    });
  }

  @override
  void initState() {
    getAllProductDetails();
    super.initState();
  }

  _deleteFormDialog(BuildContext context, productId) {
    return showDialog(
        context: context,
        builder: (param) {
          return AlertDialog(
            title: const Text(
              'Are You Sure to Delete',
              style: TextStyle(color: Colors.teal, fontSize: 20),
            ),
            actions: [
              TextButton(
                  style: TextButton.styleFrom(
                      primary: Colors.white, // foreground
                      backgroundColor: Colors.red),
                  onPressed: () async {
                    var result = await _productService.deleteById(productId);
                    if (result != null) {
                      Navigator.pop(context);
                      _showSnackBar('Product Detail Deleted Success');
                      getAllProductDetails();
                    }
                  },
                  child: const Text('Delete')),
              TextButton(
                  style: TextButton.styleFrom(
                      primary: Colors.white, // foreground
                      backgroundColor: Colors.teal),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Close'))
            ],
          );
        }).then((_)=>setState((){getAllProductDetails();}));
  }

  _scanBar() async {
    String readData = "";
    String typeData = "";
    try {
      var scan = await BarcodeScanner.scan();
      typeData = scan.type.name;
      if (typeData != 'Barcode') {
        setState(() => {
              readData = 'Only barcode is allowed',
            });
      } else {
        setState(() => {
              readData = scan.rawContent,
            });
      }
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.cameraAccessDenied) {
        setState(() {
          readData = 'Camera permissions are not valid.';
        });
      } else {
        setState(() => readData = 'Unexplained error : $e');
      }
    } on FormatException {
      setState(() => readData =
          'Failed to read (I used the back button before starting the scan).');
    } catch (e) {
      setState(() => readData = 'Unknown error : $e');
    }
    return readData;
  }

  _showSnackBar(String message) async {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: ListView.builder(
          itemCount: _pList.length,
          itemBuilder: (context, int index) {
            return Card(
              child: ListTile(
                title: Text(_pList[index].product_name ?? ''),
                subtitle: Text(_pList[index].ptype ?? ''),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(_pList[index].quantity.toString() ?? ''),
                    IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AddProduct(
                                        barcodeValue:
                                            _pList[index]?.item_num?.toString(),
                                      ))).then((data) {
                            if (data != null) {
                              getAllProductDetails();
                              _showSnackBar('Product edited Success');
                            }
                          });
                        },
                        icon: const Icon(
                          Icons.edit,
                          color: Colors.teal,
                        )),
                    IconButton(
                        onPressed: () {
                          _deleteFormDialog(context, _pList[index].id);
                        },
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        ))
                  ],
                ),
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var barcodeValue = await _scanBar();
          var result = int.tryParse(barcodeValue);
          if (result != null) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AddProduct(
                          barcodeValue: barcodeValue,
                        ))).then((data) {
              if (data != null) {
                getAllProductDetails();
              }
            });
          } else {
            await _showSnackBar(barcodeValue);
          }
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
