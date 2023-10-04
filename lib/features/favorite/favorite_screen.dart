import 'package:e_commerce/features/books/cubit/books_cubit.dart';
import 'package:e_commerce/features/books/cubit/books_state.dart';
import 'package:e_commerce/features/favorite/components/book_component.dart';
import 'package:e_commerce/features/home/cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../services/screen_size.dart';
import '../books/components/book_component.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BooksCubit,BooksStates>(
      listener: (context,state){},
      builder: (context,state){
        ScreenSize.init(context);
        BooksCubit cubit = BooksCubit.get(context);
        return Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height:
                ScreenSize.screenHeight * 0.7,
                child: ListView.separated(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemBuilder: (context,
                        index) => FavoriteBookComponent(model: cubit.favoriteBooks[index] ,),
                    separatorBuilder:
                        (context, index) =>
                        SizedBox(
                          height: ScreenSize
                              .screenHeight *
                              0.01,
                        ),
                    itemCount: cubit.books.length),
              ) ,
            ],
          ),
        );
      },
    );
  }
}
