class Product {
   int? id;
   String? product_name;
   int? item_num;
   int? quantity;
   String? ptype;

  pMap() {
    var mapping = Map<String, dynamic>();
    mapping['id'] = id ?? null;
    mapping['product_name'] = product_name!;
    mapping['item_num'] = item_num!;
    mapping['quantity'] = quantity!;
    mapping['ptype'] = ptype!;
    return mapping;
  }
}
