import 'package:ecommerce/data_model/product_insert_data_model.dart';
import 'package:http/http.dart' as http;
import 'package:ecommerce/data_model/index.dart';

class NetworkManager {

  static NetworkManager _instance;
  static NetworkManager getInstance(){
    if(_instance == null) _instance = new NetworkManager();
    return _instance;
  }

  Future<List<ProductsDm>> getProducts() async {
    var url = "https://ds-ecom.azurewebsites.net/products";
    var response = await http.get(url);
    if (response.statusCode == 200) {
      if(response.body != null && response.body.isNotEmpty) {
        return productsDmFromJson(response.body);
      } else {
        return new List();
      }
    } else {
      print('Request for $url has failed with status: ${response.statusCode}.');
      return null;
    }
  }

  Future<List<ProductInsertDm>> getProductInsertItems(var url) async {
    var response = await http.get(url);
    if (response.statusCode == 200) {
      if(response.body != null && response.body.isNotEmpty) {
        return productInsertDmFromJson(response.body);
      } else {
        return new List();
      }
    } else {
      print('Request for $url has failed with status: ${response.statusCode}.');
      return null;
    }
  }

}