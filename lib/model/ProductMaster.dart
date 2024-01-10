class ProductMaster {
   int? id;
   String? product_name_mst;
   int? product_number_mst;

  productMap() {
    var mapping = Map<String, dynamic>();
    mapping['id'] = id ;
    mapping['product_name_mst'] = product_name_mst!;
    mapping['product_number_mst'] = product_number_mst!;
    return mapping;
  }
}
