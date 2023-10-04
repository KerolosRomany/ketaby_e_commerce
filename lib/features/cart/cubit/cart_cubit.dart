
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import '../../../constants/constants.dart';
import '../../../models/models.dart';
import 'cart_states.dart';
class CartCubit extends Cubit<CartStates> {

  CartCubit() : super(InitialCartState());
  static CartCubit get(context) => BlocProvider.of(context);
  List<CartBookModel> cartBooks=[];
  String? totalInCart;
  Future<void> getCartProducts() async {
    try {
      final url = Uri.parse('$baseUrl/cart');
      final response = await http.get(url,
          headers:
          {
            'Accept': 'application/json',
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $authToken'
          });
      if (response.statusCode == 200) {
        final decodedBody = json.decode(response.body);
        final List<dynamic> data = decodedBody['data']['cart_items'];
        final String total = decodedBody['data']['total'];
        final products = data
            .map<CartBookModel>((json) => CartBookModel.fromJson(json))
            .toList();
        cartBooks=products;
        totalInCart=total;
        emit(CartSuccessfulGetCartBooksState());
      } else {
        throw 'Failed to load cart books. Status code: ${response.statusCode}';
      }
    } catch (e) {
      throw 'Failed to load cart books: $e';
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
        emit(CartSuccessfullBookAddedState());
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
  Future<void> removeFromCart(String cart_item_id,BuildContext context) async {
    final url = Uri.parse('$baseUrl/remove-from-cart');
    final Map<String, dynamic> data ={
      'cart_item_id': cart_item_id,
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
      if (response.statusCode == 201 || response.statusCode == 200) {
        print('Success removed');
        final jsonResponse = json.decode(response.body);
        String message = jsonResponse['message'];
        print(message);
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Successful removed'),
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
        emit(CartSuccessfullRemovedBookState());
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
  void getUpdatedTotal(){
    emit(CartGetUpdatedTotalState());
  }

}