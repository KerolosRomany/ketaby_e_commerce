import 'dart:convert';

import 'package:e_commerce/features/home/abstract.dart';
import 'package:e_commerce/features/home/cubit/home_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../constants/constants.dart';
import '../../../models/models.dart';
import 'checkout_states.dart';
import 'package:http/http.dart' as http;

class CheckoutCubit extends Cubit<CheckoutStates> {

  CheckoutCubit() : super(InitialCheckoutState());

  static CheckoutCubit get(context) => BlocProvider.of(context);
  var checkoutFormKey = GlobalKey<FormState>();
  String selectedItem = 'Cairo';
  void changeCity(value){
    selectedItem = value;
    emit(SuccessfulChangeCityState());
  }
  List<GovernorateModel> cities = [];
  Future<void> getCities() async {
    try {
      final url = Uri.parse('$baseUrl/governorates');
      final response = await http.get(url,
          headers:
          {
            'Accept': 'application/json',
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $authToken'
          });
      if (response.statusCode == 200) {
        final decodedBody = json.decode(response.body);
        final List<dynamic> data = decodedBody['data'];
        final citiesFromData = data
            .map<GovernorateModel>((json) => GovernorateModel.fromJson(json))
            .toList();
        cities = citiesFromData;
        emit(HomeSuccessfulGetCitiesState());
      } else {
        throw 'Failed to load cities. Status code: ${response.statusCode}';
      }
    } catch (e) {
      throw 'Failed to load cities: $e';
    }
  }

  var profileNameController = TextEditingController();
  var profileEmailController = TextEditingController();
  var profilePhoneController = TextEditingController();
  var profileAddressController = TextEditingController();
  OrderModel orderModel = OrderModel(id: 1564, user: UserModel(
      userId: 15464, userName: 'K', userEmail: 'k@k.com',
      address: '1 Gizaa', phone: '01013245645'), total: '100', cartItems: [

  ]);
  Future<void> getCheckout() async {
    try {
      final url = Uri.parse('$baseUrl/checkout');
      final response = await http.get(url,
          headers:
          {
            'Accept': 'application/json',
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $authToken'
          });
      if (response.statusCode == 200) {
        final decodedBody = json.decode(response.body);
        // final List<dynamic> data = decodedBody['data'];
        final String total = decodedBody['data']['total'];
        final OrderModel order = OrderModel.fromJson(decodedBody['data']);
        profileNameController.text = order.user.userName;
        profileEmailController.text = order.user.userEmail;
        profilePhoneController.text = order.user.phone;
        profileAddressController.text = order.user.address;
        orderModel=order;
        totalInCart=total;
        emit(CartSuccessfulGetCheckoutState());
      } else {
        throw 'Failed to load checkout. Status code: ${response.statusCode}';
      }
    } catch (e) {
      throw 'Failed to load checkout: $e';
    }
  }

  int cityId = 1;
  void saveCityId(GovernorateModel value){
    cityId = value.id;
    emit(CheckoutSelectCityState());
  }
  Future<void> checkout(BuildContext context) async {
    final url = Uri.parse('$baseUrl/place-order');
    final Map<String, dynamic> data ={
      'name': profileNameController.text,
      'email': profileEmailController.text,
      'phone': profilePhoneController.text,
      'address': profileAddressController.text,
      'governorate_id': cityId
    };
    try {
      final response = await http.post(url, body: jsonEncode(data),
          headers:
          {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $authToken'
          }
      );
      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 201 || response.statusCode == 200) {
        print('Success order');
        final jsonResponse = json.decode(response.body);
        final message = jsonResponse['message'];
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Succuss order'),
            content: Text(message),
            actions: [
              TextButton(
                child: Text(
                  'OK',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => AbstractScreen()),
                ),
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









  String? totalInCart;

}