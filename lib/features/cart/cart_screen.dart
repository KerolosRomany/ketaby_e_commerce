
import 'package:e_commerce/components/components.dart';
import 'package:e_commerce/constants/constants.dart';
import 'package:e_commerce/features/cart/components/cart_book_component.dart';
import 'package:e_commerce/services/screen_size.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../checkout/checkout_screen.dart';
import 'cubit/cart_cubit.dart';
import 'cubit/cart_states.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    CartCubit.get(context).getCartProducts();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit,CartStates>(
        builder: (context,state){
          ScreenSize.init(context);
          CartCubit cubit = CartCubit.get(context);
          return Scaffold(
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height:
                      ScreenSize.screenHeight * 0.7,
                      child: ListView.separated(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemBuilder: (context,
                              index) => CartBookComponent(model: cubit.cartBooks[index] ,),
                          separatorBuilder:
                              (context, index) =>
                              SizedBox(
                                height: ScreenSize
                                    .screenHeight *
                                    0.01,
                              ),
                          itemCount: cubit.cartBooks.length),
                    ) ,
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Container(
                        width: double.infinity,
                        height: ScreenSize.screenHeight*0.12,
                        decoration: BoxDecoration(
                          color: defaultColor,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text('Total price: ${cubit.totalInCart}',style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700
                                ),),
                                Spacer(),
                                smalldefaultButton(text: 'Checkout',
                                    onpressed: (){
                                  Navigator.push(context,MaterialPageRoute(builder: (context)=> CheckoutScreen()));
                                    }, color: Colors.white, context: context,textColor: defaultColor)
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
