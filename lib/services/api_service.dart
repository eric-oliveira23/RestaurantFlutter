import 'package:http/http.dart' as http;
import 'package:restaurant_go/model/product_model.dart';

import '../model/table_model.dart';

class ApiService {
  static Future<List<TableModel>> getAllTables() async {
    var url = Uri.parse('http://localhost:8080/mesas');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      return tableModelFromJson(response.body);
    } else {
      throw Exception('Não foi possível conectar-se aos serviços.');
    }
  }

  static Future<List<ProductModel>> getAllProducts() async {
    var url = Uri.parse('http://localhost:8080/produtos');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      return productModelFromJson(response.body);
    } else {
      throw Exception('Não foi possível conectar-se aos serviços.');
    }
  }
}
