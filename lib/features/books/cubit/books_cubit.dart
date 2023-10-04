import 'dart:convert';

import  'package:bloc/bloc.dart';
import 'package:e_commerce/features/books/specific_book_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../constants/constants.dart';
import '../../../models/models.dart';
import 'books_state.dart';
import 'package:http/http.dart' as http;
class BooksCubit extends Cubit<BooksStates> {

  BooksCubit() : super(InitialBooksState());

  static BooksCubit get(context) => BlocProvider.of(context);
  List<ProductModel> books=[];
  List<FavoriteModel> favoriteBooks=[];
  List<ProductModel> booksSearched=[];
  TextEditingController searchController = TextEditingController();
  bool openSearch = false ;
  Future<void> getBooks() async {
    try {
      final url = Uri.parse('$baseUrl/products');
      final response = await http.get(url,
          headers:
          {
            'Accept': 'application/json',
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $authToken'
          });
      if (response.statusCode == 200) {
        final decodedBody = json.decode(response.body);
        final List<dynamic> data = decodedBody['data']['products'];
        final products = data
            .map<ProductModel>((json) => ProductModel.fromJson(json))
            .toList();
        books=products;
        emit(HomeSuccessfulGetAllBooksState());
      } else {
        throw 'Failed to load books. Status code: ${response.statusCode}';
      }
    } catch (e) {
      throw 'Failed to load books: $e';
    }
  }
  Future<void> getFavoriteBooks() async {
    try {
      final url = Uri.parse('$baseUrl/wishlist');
      final response = await http.get(url,
          headers:
          {
            'Accept': 'application/json',
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $authToken'
          });
      if (response.statusCode == 200) {
        print(response.body);
        final decodedBody = json.decode(response.body);
        final List<dynamic> data = decodedBody['data']['data'];
        print('Hello');
        print(data);

        final favProducts = data
            .map<FavoriteModel>((json) => FavoriteModel.fromJson(json as Map<String,dynamic>))
            .toList();

        // final favproducts = data.entries
        //     .map<FavoriteModel>((entry) => FavoriteModel.fromJson(entry.value))
        //     .toList();
        favoriteBooks=favProducts;
        print(favoriteBooks);
        emit(HomeSuccessfulGetFavoriteBooksState());
      } else {
        throw 'Failed to load favorite books. Status code: ${response.statusCode}';
      }
    } catch (e) {
      throw 'Failed to load favorite books: ${e.toString()}';
    }
  }
  Future<void> addToFavorite(String id,BuildContext context) async {
    final url = Uri.parse('$baseUrl/add-to-wishlist');
    final Map<String, dynamic> data ={
      'product_id': id,
    };
    try {
      final response = await http.post(url, body: jsonEncode(data),
          headers:
          {
            'Authorization': 'Bearer $authToken',
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          }
      );
      print(response.statusCode);
      if (response.statusCode == 201 || response.statusCode == 200) {
        print('Success added to favorite');
        final jsonResponse = json.decode(response.body);
        String message = jsonResponse['message'];
        print(message);
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Successful added'),
            content: Text(message),
            actions: [
              TextButton(
                child: Text(
                  'OK',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () => Navigator.pop(context),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(defaultColor),
                ),
              ),
            ],
          ),
        );
      }
      else if (response.statusCode == 403 || response.statusCode == 401) {
        final jsonResponse = json.decode(response.body);
        print(response.body);
        final message = jsonResponse['message'];
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Error'),
            content: Text(message),
            actions: [
              TextButton(
                child: Text(
                  'OK',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () => Navigator.pop(context),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(defaultColor),
                ),
              ),
            ],
          ),
        );
        print(response.statusCode);
      }
      else if (response.statusCode == 422){
        final jsonResponse = json.decode(response.body);
        print(response.body);
        final message = jsonResponse['errors'];
        Map<String, dynamic> errors = jsonResponse['errors'];
        List<String> errorMessages = [];
        errors.forEach((key, value) {
          List<String> messages = List<String>.from(value);
          errorMessages.addAll(messages);
        });
        print(errorMessages);
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Error'),
            content: Text(errorMessages[0].toString()),
            actions: [
              TextButton(
                child: Text(
                  'OK',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () => Navigator.pop(context),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(defaultColor),
                ),
              ),
            ],
          ),
        );
      }
      else {

        print(response.statusCode);
      }
    } catch (error) {
      // Error occurred during the HTTP request
      print('Error: $error');
    }
  }
  Future<void> removeFromFavorite(String id,BuildContext context) async {
    final url = Uri.parse('$baseUrl/remove-from-wishlist');
    final Map<String, dynamic> data ={
      'product_id': id,
    };
    try {
      final response = await http.post(url, body: jsonEncode(data),
          headers:
          {
            'Authorization': 'Bearer $authToken',
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          }
      );
      print(response.statusCode);
      if (response.statusCode == 201 || response.statusCode == 200) {
        print('Success added to favorite');
        final jsonResponse = json.decode(response.body);
        String message = jsonResponse['message'];
        print(message);
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Successful added'),
            content: Text(message),
            actions: [
              TextButton(
                child: Text(
                  'OK',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () => Navigator.pop(context),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(defaultColor),
                ),
              ),
            ],
          ),
        );
      }
      else if (response.statusCode == 403 || response.statusCode == 401) {
        final jsonResponse = json.decode(response.body);
        print(response.body);
        final message = jsonResponse['message'];
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Error'),
            content: Text(message),
            actions: [
              TextButton(
                child: Text(
                  'OK',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () => Navigator.pop(context),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(defaultColor),
                ),
              ),
            ],
          ),
        );
        print(response.statusCode);
      }
      else if (response.statusCode == 422){
        final jsonResponse = json.decode(response.body);
        print(response.body);
        final message = jsonResponse['errors'];
        Map<String, dynamic> errors = jsonResponse['errors'];
        List<String> errorMessages = [];
        errors.forEach((key, value) {
          List<String> messages = List<String>.from(value);
          errorMessages.addAll(messages);
        });
        print(errorMessages);
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Error'),
            content: Text(errorMessages[0].toString()),
            actions: [
              TextButton(
                child: Text(
                  'OK',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () => Navigator.pop(context),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(defaultColor),
                ),
              ),
            ],
          ),
        );
      }
      else {

        print(response.statusCode);
      }
    } catch (error) {
      // Error occurred during the HTTP request
      print('Error: $error');
    }
  }
  Icon favoriteIcon = Icon(Icons.favorite_border);
  void disableFavoriteIcon(){

    emit(BooksChangeFavoriteIconState());
  }
  void enableFavoriteIcon(){

    emit(BooksChangeFavoriteIconState());
  }
  ProductModel specificBook = ProductModel(id: 100012,
      name:'Test name', description: 'description', price: '159', discount: '49', priceAfterDiscount: '152', stock: '45', bestSeller: '15', image: 'https://jexo.io/content/images/2021/04/image.png', category: 'AI');
  Future<void> getSpecificBook(String id,BuildContext context) async {
    try {
      final url = Uri.parse('$baseUrl/products/$id');
      final response = await http.get(url,
          headers:
          {
            'Accept': 'application/json',
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $authToken'
          });
      if (response.statusCode == 200) {
        final decodedBody = json.decode(response.body);
        // final Map<String,dynamic> data = decodedBody['data'];
        final ProductModel product = ProductModel.fromJson(decodedBody['data']);
        specificBook=product;
        Navigator.push(context, MaterialPageRoute(builder: (context)=> SpecificBookScreen(product: product,)));
        emit(BooksSuccessfulGetSpecificBookState());
      } else {
        throw 'Failed to load specific book. Status code: ${response.statusCode}';
      }
    } catch (e) {
      throw 'Failed to load specific book: $e';
    }
  }
  Future<void> search(value) async {
    try {
      final url = Uri.parse('$baseUrl/products-search?name=$value');
      final response = await http.get(url,
          headers:
          {
            'Accept': 'application/json',
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $authToken'
          });
      if (response.statusCode == 200) {
        final decodedBody = json.decode(response.body);
        final List<dynamic> data = decodedBody['data']['products'];
        final products = data
            .map<ProductModel>((json) => ProductModel.fromJson(json))
            .toList();
        booksSearched = products;
        emit(BooksSuccessfulGetResultsFromSearch());
      } else {
        throw 'Failed to load books. Status code: ${response.statusCode}';
      }
    } catch (e) {
      throw 'Failed to load books: $e';
    }
  }
  Future<void> addToCart(String id,BuildContext context) async {
    final url = Uri.parse('$baseUrl/add-to-cart');
    final Map<String, dynamic> data ={
      'product_id': id,
    };
    try {
      final response = await http.post(url, body: jsonEncode(data),
          headers:
          {
            'Authorization': 'Bearer $authToken',
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          }
      );
      print(response.statusCode);
      if (response.statusCode == 201 || response.statusCode == 200) {
        print('Success added to cart');
        final jsonResponse = json.decode(response.body);
        String message = jsonResponse['message'];
        print(message);
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Successful added'),
            content: Text(message),
            actions: [
              TextButton(
                child: Text(
                  'OK',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () => Navigator.pop(context),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(defaultColor),
                ),
              ),
            ],
          ),
        );
      }
      else if (response.statusCode == 403 || response.statusCode == 401) {
        final jsonResponse = json.decode(response.body);
        print(response.body);
        final message = jsonResponse['message'];
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Error'),
            content: Text(message),
            actions: [
              TextButton(
                child: Text(
                  'OK',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () => Navigator.pop(context),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(defaultColor),
                ),
              ),
            ],
          ),
        );
        print(response.statusCode);
      }
      else if (response.statusCode == 422){
        final jsonResponse = json.decode(response.body);
        print(response.body);
        final message = jsonResponse['errors'];
        Map<String, dynamic> errors = jsonResponse['errors'];
        List<String> errorMessages = [];
        errors.forEach((key, value) {
          List<String> messages = List<String>.from(value);
          errorMessages.addAll(messages);
        });
        print(errorMessages);
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Error'),
            content: Text(errorMessages[0].toString()),
            actions: [
              TextButton(
                child: Text(
                  'OK',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () => Navigator.pop(context),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(defaultColor),
                ),
              ),
            ],
          ),
        );
      }
      else {

        print(response.statusCode);
      }
    } catch (error) {
      // Error occurred during the HTTP request
      print('Error: $error');
    }
  }
}