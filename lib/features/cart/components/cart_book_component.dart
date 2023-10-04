import 'package:e_commerce/constants/constants.dart';
import 'package:e_commerce/features/books/cubit/books_cubit.dart';
import 'package:e_commerce/features/books/cubit/books_state.dart';
import 'package:e_commerce/features/cart/cubit/cart_cubit.dart';
import 'package:e_commerce/features/cart/cubit/cart_cubit.dart';
import 'package:e_commerce/features/cart/cubit/cart_cubit.dart';
import 'package:e_commerce/features/cart/cubit/cart_states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/models.dart';
import '../../../services/screen_size.dart';

class CartBookComponent extends StatefulWidget {
  final CartBookModel model;
  const CartBookComponent({super.key,
  required this.model});

  @override
  State<CartBookComponent> createState() => _CartBookComponentState();
}

class _CartBookComponentState extends State<CartBookComponent> {

  @override
  Widget build(BuildContext context) {
   // print(model.image);
    return BlocConsumer<CartCubit,CartStates>(
      listener: (context,state){},
      builder: (context,state){
        ScreenSize.init(context);
        CartCubit cubit = CartCubit.get(context);
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
              height: ScreenSize.screenHeight*0.2,
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                      width: ScreenSize.screenWidth*0.3,
                      height: ScreenSize.screenHeight*0.15,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(image: NetworkImage(widget.model.itemProductImage,),fit: BoxFit.contain,),)
                  ),
                  SizedBox(width: ScreenSize.screenWidth*0.01),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: ScreenSize.screenHeight*0.04),
                      Container(
                        width: ScreenSize.screenWidth*0.4,
                        child: Text(widget.model.itemProductName, maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            )),
                      ),
                      SizedBox(height: ScreenSize.screenHeight*0.03),
                      Container(
                        height: ScreenSize.screenHeight*0.05,
                        width: ScreenSize.screenWidth*0.3,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(10)),

                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            IconButton(onPressed: (){
                                cubit.addToCart(widget.model.itemProductId.toString(), context);
                                setState(() {
                                  widget.model.itemQuantity=widget.model.itemQuantity+1;
                                    cubit.getCartProducts();
                                });
                            }, icon: Icon(Icons.add)),
                            Text(widget.model.itemQuantity.toString()),
                            IconButton(onPressed: (){}, icon: Icon(Icons.remove)),
                          ],
                        ),
                      )
                    ],
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        IconButton(onPressed: (){
                          cubit.removeFromCart(widget.model.itemId.toString(),context);
                          setState(() {
                            cubit.getCartProducts();
                            cubit.getUpdatedTotal();
                          });
                        }, icon: Icon(Icons.delete,color: Colors.red.shade900,)),
                        Spacer(),
                        Text(widget.model.itemProductPrice, maxLines: 1,
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough,
                            )),
                        SizedBox(height: ScreenSize.screenHeight*0.01),
                        Text(widget.model.itemProductPriceAfterDiscount.toString(), maxLines: 1,
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.green
                            )),
                      ],
                    ),
                  )
                ],
              )
          ),
        );
      },
    );
  }
}
