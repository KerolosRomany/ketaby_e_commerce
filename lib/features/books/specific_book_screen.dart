import 'package:e_commerce/components/components.dart';
import 'package:e_commerce/features/books/cubit/books_cubit.dart';
import 'package:e_commerce/models/models.dart';
import 'package:e_commerce/services/screen_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/books_state.dart';

class SpecificBookScreen extends StatelessWidget {
  final ProductModel product;
  const SpecificBookScreen({super.key,required this.product});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BooksCubit,BooksStates>(
      listener: (context,state){},
      builder: (context,state){
        ScreenSize.init(context);
        BooksCubit cubit =BooksCubit.get(context);
        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                    Container(
                      width: double.infinity,
                      height: ScreenSize.screenHeight*0.4,
                      decoration: BoxDecoration(
                        image: DecorationImage(image: NetworkImage(product.image,),fit: BoxFit.cover)
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(product.name,maxLines: 2,overflow: TextOverflow.ellipsis,style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w700
                          ),),
                          SizedBox(height: ScreenSize.screenHeight*0.01,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(product.category,maxLines: 2,overflow: TextOverflow.ellipsis,style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                              color: Colors.grey
                  ),),
                              Spacer(),
                              Column(
                                children: [
                                  Text(product.price, maxLines: 1,
                                      textAlign: TextAlign.center,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.grey,
                                        decoration: TextDecoration.lineThrough,
                                      )),
                                  SizedBox(height: ScreenSize.screenHeight*0.005),
                                  Text(product.priceAfterDiscount.toString(), maxLines: 1,
                                      textAlign: TextAlign.center,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.green
                                      )),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: ScreenSize.screenHeight*0.02,),
                          Text('Description:',style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                          ),),
                          Text(product.description,maxLines: 10,overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: Colors.grey
                          ),),
                          SizedBox(height: ScreenSize.screenHeight*0.02,),
                          defaultButton(text: 'Add to cart', onpressed: (){
                            cubit.addToCart(product.id.toString(),context);
                          })

                        ],
                      ),
                    ),

                ],

              ),
            ),
          ),
        );
      },
    );
  }
}
