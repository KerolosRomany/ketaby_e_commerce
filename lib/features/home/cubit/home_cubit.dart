import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:e_commerce/features/books/books_screen.dart';
import 'package:e_commerce/features/cart/cart_screen.dart';
import 'package:e_commerce/features/favorite/favorite_screen.dart';
import 'package:e_commerce/features/home/home_screen.dart';
import 'package:e_commerce/features/profile/profile_screen.dart';
import 'package:e_commerce/features/register/cubit/register_states.dart';
import 'package:e_commerce/features/register/otp_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../constants/constants.dart';
import 'package:http/http.dart' as http;

import '../../../models/models.dart';
import '../../books/specific_book_screen.dart';
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
      image: "https://static.vecteezy.com/system/resources/previews/000/439/863/original/vector-users-icon.jpg"
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
      print(response.body);
      if (response.statusCode == 200) {
        final decodedBody = json.decode(response.body);
        final dynamic data = decodedBody['data']; // Accessing data as a single object
        ProfileModel profile = ProfileModel.fromJson(data); // Create a single instance
        username = profile.name;
        profileNameController.text = profile.name;
        profileEmailController.text = profile.email;
        profilePhoneController.text = profile.phone == "null" ? "" : profile.phone ;
        profileCityController.text = profile.city == "null" ? "" :profile.city ;
        profileAddressController.text = profile.address == "null" ? "" : profile.address;
        print(username);
        profileModel = profile;
        emit(HomeSuccessfulGetProfileDataState());
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
        emit(HomeSuccessfulGetSliderImagesState());
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
        emit(HomeSuccessfulGetBestSellerState());
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
        emit(HomeSuccessfulGetNewArrivalState());
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
        emit(HomeSuccessfulGetCategories());
      } else {
        throw 'Failed to load categories. Status code: ${response.statusCode}';
      }
    } catch (e) {
      throw 'Failed to load categories: $e';
    }
  }
  ProductModel specificBook = ProductModel(
      id: 100012,
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
      print(response.statusCode);
      if (response.statusCode == 200) {
        final decodedBody = json.decode(response.body);
        // final Map<String,dynamic> data = decodedBody['data'];
        final ProductModel product = ProductModel.fromJson(decodedBody['data']);
        specificBook=product;
        Navigator.push(context, MaterialPageRoute(builder: (context)=> SpecificBookScreen(product: product)));
        emit(HomeSuccessfulGetSpecificBookState());
      } else {
        throw 'Failed to load specific book. Status code: ${response.statusCode}';
      }
    } catch (e) {
      throw 'Failed to load specific book: $e';
    }
  }

  var profileNameController = TextEditingController();
  var profileEmailController = TextEditingController();
  var profilePhoneController = TextEditingController();
  var profileCityController = TextEditingController();
  var profileAddressController = TextEditingController();
  var profileFormKey = GlobalKey<FormState>();
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


  int currentIndex = 0;

  void onTabTapped(int index) {
      currentIndex = index;
      emit(HomeSuccessfulChangeNavigationBarState());
  }
  List<Widget> screens = [
    HomeScreen(),
    BooksScreen(),
    FavoriteScreen(),
    CartScreen(),
    ProfileScreen(),
  ];

  Future<void> updateUserDetails(BuildContext context) async {
    final url = Uri.parse('$baseUrl/update-profile');
    final Map<String, dynamic> data ={
      'name': profileNameController.text,
      'email': profileEmailController.text,
      'city': profileCityController.text,
      'phone': profilePhoneController.text,
      'address': profileAddressController.text,
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
        print('Success update');
        final jsonResponse = json.decode(response.body);
        String message = jsonResponse['message'];
        print(message);
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Successful update'),
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
