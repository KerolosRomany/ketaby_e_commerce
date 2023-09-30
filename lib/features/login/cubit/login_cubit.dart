import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:e_commerce/features/home/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../constants/constants.dart';
import 'package:http/http.dart' as http;

import 'login_state.dart';


class LoginCubit extends Cubit<LoginStates> {

  LoginCubit() : super(InitialLoginState());

  static LoginCubit get(context) => BlocProvider.of(context);

  // Login
  var loginEmailController = TextEditingController();
  var loginPasswordController = TextEditingController();
  var loginFormKey = GlobalKey<FormState>();

  Future<void> loginUser(BuildContext context) async {
    String email = loginEmailController.text;
    String password = loginPasswordController.text;
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/login'),
        body: json.encode({
          'email': email,
          'password': password,
        }),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      );
      print(response.statusCode);
      if (response.statusCode == 202 || response.statusCode == 200) {
        print('Success logged in ');
        final jsonResponse = json.decode(response.body);
        authToken = jsonResponse['data']['token'];
        print(authToken);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
        loginEmailController.clear();
        loginPasswordController.clear();
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
        final message = jsonResponse['message'];
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

      print(error);
    }
  }

  bool keepLogedInChecked = false;

  // This function is called when the checkbox is checked or unchecked.
  void handleCheckboxChanged(bool value) {
    keepLogedInChecked = value;
  }

}
