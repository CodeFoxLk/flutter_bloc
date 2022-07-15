 import 'dart:convert';
import 'package:http/http.dart' as http;

class ProductRepository{
  Future<List<Product>?> getAllCategories(String category) async {
    final response = await http.get(
      Uri.parse("https://fakestoreapi.com/products/category/$category")
    );
    if (response.statusCode == 200) {
      if (response.body.isNotEmpty) {
        final products = List<Product>.from(json.decode(response.body).map((product) => Product.fromJson(product)));
        return products;
      }else{
        return [];
      }
    } else {
      throw Exception('product fecthing error');
    }
  }
}

class Product {
  final int? id;
  final String? title;
  final double? price;
  final String? description;
  final String? category;
  final String? image;
  final Rating? rating;

  Product({
    this.id,
    this.title,
    this.price,
    this.description,
    this.category,
    this.image,
    this.rating,
  });

  

  Product.fromJson(Map<String, dynamic> json)
    : id = json['id'] as int?,
      title = json['title'] as String?,
      price =  json['price'].toDouble(),
      description = json['description'] as String?,
      category = json['category'] as String?,
      image = json['image'] as String?,
      rating = (json['rating'] as Map<String,dynamic>?) != null ? Rating.fromJson(json['rating'] as Map<String,dynamic>) : null;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'title' : title,
    'price' : price,
    'description' : description,
    'category' : category,
    'image' : image,
    'rating' : rating?.toJson()
  };
}

class Rating {
  final double? rate;
  final int? count;

  Rating({
    this.rate,
    this.count,
  });

  Rating.fromJson(Map<String, dynamic> json)
    : rate = json['rate'].toDouble(),
      count = json['count'] as int?;

  Map<String, dynamic> toJson() => {
    'rate' : rate,
    'count' : count
  };
}