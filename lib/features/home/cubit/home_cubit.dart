import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:e_commerce/features/home/home_screen.dart';
import 'package:e_commerce/features/register/cubit/register_states.dart';
import 'package:e_commerce/features/register/otp_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../constants/constants.dart';
import 'package:http/http.dart' as http;

import '../../../models/models.dart';
import 'home_states.dart';




class HomeCubit extends Cubit<HomeStates> {

  HomeCubit() : super(InitialHomeState());

  static HomeCubit get(context) => BlocProvider.of(context);
  String? username;
  ProfileModel profileModel = ProfileModel(
      name: '',
      email: 'kerolos@mail.com',
      address: 'Giza',
      city: 'Giza',
      emailVerified: true,
      id: 456,
      phone: '01201007136',
      image: 'assets/images/logo.png'
  );
  Future<void> getProfileDetails() async {
    try {
      final url = Uri.parse('$baseUrl/profile');
      final response = await http.get(
          url,
          headers:
          {
            'Accept': 'application/json',
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $authToken'
          });
      print(response.statusCode);
      if (response.statusCode == 200) {
        final decodedBody = json.decode(response.body);
        final dynamic data = decodedBody['data']; // Accessing data as a single object
        ProfileModel profile = ProfileModel.fromJson(data); // Create a single instance
        username = profile.name;
        print(username);
        profileModel = profile;
        emit(HomeSuccessfullGetProfileDataState());
      } else {
        throw 'Failed to load profile data. Status code: ${response.statusCode}';
      }
    } catch (e) {
      throw 'Failed to load profile data: $e';
    }
  }
  ProfileModel profileModelTest = ProfileModel(
    name: 'Kerolos',
    email: 'kerolos@mail.com',
    address: 'Giza',
    city: 'Giza',
    emailVerified: true,
    id: 456,
    phone: '01201007136',
    image: 'assets/images/logo.png'
  );
  List<SliderModel> slidersData = [];
  Future<void> getAllSliders() async {
    try {
      final url = Uri.parse('$baseUrl/sliders');
      final response = await http.get(url,
          headers:
          {
            'Accept': 'application/json',
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $authToken'
          });
      if (response.statusCode == 200) {
        final decodedBody = json.decode(response.body);
        final List<dynamic> data = decodedBody['data']['sliders'];
        final sliders = data
            .map<SliderModel>((json) => SliderModel.fromJson(json))
            .toList();
        slidersData = sliders;
        emit(HomeSuccessfullGetSliderImagesState());
      } else {
        throw 'Failed to load sliders. Status code: ${response.statusCode}';
      }
    } catch (e) {
      throw 'Failed to load sliders: $e';
    }
  }
  List<ProductModel> bestSellingProducts=[];
  Future<void> getBestSellingProducts() async {
    try {
      final url = Uri.parse('$baseUrl/products-bestseller');
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
        bestSellingProducts=products;
        emit(HomeSuccessfullGetBestSellerState());
      } else {
        throw 'Failed to load products. Status code: ${response.statusCode}';
      }
    } catch (e) {
      throw 'Failed to load products: $e';
    }
  }
  List<ProductModel> newArrivalProducts=[];
  Future<void> getNewArrivalProducts() async {
    try {
      final url = Uri.parse('$baseUrl/products-new-arrivals');
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
        newArrivalProducts = products;
        emit(HomeSuccessfullGetNewArrivalState());
      } else {
        throw 'Failed to load products. Status code: ${response.statusCode}';
      }
    } catch (e) {
      throw 'Failed to load products: $e';
    }
  }
  List<CategoryModel> categoriesData=[];
  Future<void> getCategories() async {
    try {
      final url = Uri.parse('$baseUrl/categories');
      final response = await http.get(url,
          headers:
          {
            'Accept': 'application/json',
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $authToken'
          });
      if (response.statusCode == 200) {
        final decodedBody = json.decode(response.body);
        final List<dynamic> data = decodedBody['data']['categories'];
        final categories = data
            .map<CategoryModel>((json) => CategoryModel.fromJson(json))
            .toList();
        categoriesData = categories;
        emit(HomeSuccessfullGetCategories());
      } else {
        throw 'Failed to load categories. Status code: ${response.statusCode}';
      }
    } catch (e) {
      throw 'Failed to load categories: $e';
    }
  }
  final List<String> imgList = [
    'assets/images/sales1.jpg',
    'assets/images/sales2.jpg',
    'assets/images/sales3.jpg',

  ];
  int pageIndex = 0;
  void chanegePageIndex(int value){
    pageIndex = value;
    emit(HomeChangeSliderIndexState());
  }
}
