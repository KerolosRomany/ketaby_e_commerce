import 'package:e_commerce/constants/constants.dart';
import 'package:e_commerce/features/books/cubit/books_cubit.dart';
import 'package:e_commerce/features/books/cubit/books_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/models.dart';
import '../../../services/screen_size.dart';

class BookComponent extends StatelessWidget {
  final ProductModel model;
  const BookComponent({super.key,
  required this.model});

  @override
  Widget build(BuildContext context) {
   // print(model.image);
    Icon favoriteIcon = Icon(Icons.favorite_border);
    return BlocConsumer<BooksCubit,BooksStates>(
      listener: (context,state){},
      builder: (context,state){
        ScreenSize.init(context);
        BooksCubit cubit = BooksCubit.get(context);
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
              height: ScreenSize.screenHeight*0.25,
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: MaterialButton(
                onPressed: (){
                  cubit.getSpecificBook(model.id.toString(),context);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Stack(
                      alignment: Alignment.topLeft,
                      children: [
                        Container(
                            width: ScreenSize.screenWidth*0.3,
                            height: ScreenSize.screenHeight*0.15,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              image: DecorationImage(image: NetworkImage(model.image,),fit: BoxFit.contain,),)
                        ),
                        Container(
                          width: ScreenSize.screenWidth*0.1,
                          height: ScreenSize.screenHeight*0.04,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: defaultColor
                          ),
                          child: Center(child: Text('${model.discount.toString()}%',style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                              fontSize: 13
                          ),)),
                        ),
                      ],
                    ),
                    SizedBox(width: ScreenSize.screenWidth*0.01),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: ScreenSize.screenHeight*0.01),
                        Container(
                          width: ScreenSize.screenWidth*0.4,
                          child: Text(model.name, maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                              )),
                        ),
                        SizedBox(height: ScreenSize.screenHeight*0.01),
                        Text(model.category, maxLines: 1,
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey
                            )),
                        SizedBox(height: ScreenSize.screenHeight*0.01),
                        Text(model.price, maxLines: 1,
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough,
                            )),
                        SizedBox(height: ScreenSize.screenHeight*0.01),
                        Text(model.priceAfterDiscount.toString(), maxLines: 1,
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.green
                            )),
                      ],
                    ),
                    Spacer(),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        IconButton(onPressed: (){
                          if (cubit.favoriteBooks.contains(model)){
                            cubit.removeFromFavorite(model.id.toString(), context);
                            cubit.disableFavoriteIcon();
                            favoriteIcon = Icon(Icons.favorite_border);
                          }
                          else{
                            cubit.addToFavorite(model.id.toString(), context);
                            cubit.enableFavoriteIcon();
                            favoriteIcon = Icon(Icons.favorite);
                          }
                        }, icon: Builder(
                          builder:
                            (context) {
                          if (cubit.favoriteBooks.contains(model)) {
                            return Icon(Icons.favorite);
                          } else {
                            return Icon(Icons.favorite_border);
                          }
                        },)),
                        Spacer(),
                        IconButton(onPressed: (){}, icon: Icon(Icons.add_shopping_cart)),
                      ],
                    )
                  ],
                ),
                padding: EdgeInsets.zero,
              )
          ),
        );
      },
    );
  }
}

