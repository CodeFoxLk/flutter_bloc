import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class CategoriesRepository{
  Future<List<String>?> getAllCategories() async {
  
    final response = await http.get(
      Uri.parse("https://fakestoreapi.com/products/categories")
    );
    print(response.body);
    if (response.statusCode == 200) {
      if (response.body.isNotEmpty) {
        
        return List<String>.from(json.decode(response.body).map((category) => category));
      }else{
        return [];
      }
    } else {
      throw IOException;
    }
  }
}
