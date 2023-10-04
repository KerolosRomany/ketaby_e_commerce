
import 'package:e_commerce/features/books/cubit/books_cubit.dart';
import 'package:e_commerce/features/cart/cubit/cart_cubit.dart';
import 'package:e_commerce/features/checkout/cubit/checkout_cubit.dart';
import 'package:e_commerce/features/home/abstract.dart';
import 'package:e_commerce/features/home/cubit/home_cubit.dart';
import 'package:e_commerce/features/home/home_screen.dart';
import 'package:e_commerce/features/register/register_screen.dart';
import 'package:e_commerce/services/bloc_observer.dart';
import 'package:e_commerce/splash_screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/login/cubit/login_cubit.dart';
import 'features/login/login_screen.dart';
import 'features/onboarding/onboarding_screen.dart';
import 'features/register/cubit/register_cubit.dart';
import 'features/register/otp_screen.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LoginCubit(),),
        BlocProvider(create: (context) => RegisterCubit(),),
        BlocProvider(create: (context) => BooksCubit()..getBooks()/*..getFavoriteBooks(),*/),
        BlocProvider(create: (context) => HomeCubit().. getProfileDetails()..getAllSliders()..getBestSellingProducts()..getCategories()..getNewArrivalProducts(),),
        BlocProvider(create: (context) => CartCubit()..getCartProducts()),
        BlocProvider(create: (context) => CheckoutCubit()..getCheckout()..getCities()),
      ],
      child: MaterialApp(
        title: 'E-commerce',
        theme: ThemeData(

        ),
        home: AbstractScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

