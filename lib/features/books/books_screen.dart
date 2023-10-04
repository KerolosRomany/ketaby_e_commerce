import 'package:e_commerce/features/books/cubit/books_cubit.dart';
import 'package:e_commerce/features/books/cubit/books_state.dart';
import 'package:e_commerce/services/screen_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'components/book_component.dart';

class BooksScreen extends StatelessWidget {
  const BooksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BooksCubit,BooksStates>(
        builder: (context,state){
          ScreenSize.init(context);
          BooksCubit cubit = BooksCubit.get(context);
      return Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: SearchBar(
                    leading: Icon(Icons.search),
                    controller: cubit.searchController,
                    hintText: 'Search',
                    hintStyle: MaterialStateProperty.resolveWith<TextStyle>(
                          (Set<MaterialState> states) {
                        return TextStyle(
                            color: Colors.grey.shade500,
                            fontWeight: FontWeight.w600
                        );
                      },
                    ),
                    onTap: (){
                      cubit.openSearch =true;
                    },
                    backgroundColor:  MaterialStateProperty.resolveWith<Color?>(
                          (Set<MaterialState> states) {
                        return Colors.grey.shade200;
                      },
                    ),
                    onChanged: (value){
                      cubit.search(value);
                    },
                    trailing: [
                      IconButton(onPressed: (){
                        if (cubit.booksSearched == []){
                          cubit.searchController.clear();
                          cubit.openSearch = false;
                        }
                          else
                          {
                            cubit.searchController.clear();
                            cubit.openSearch = false;
                            cubit.getBooks();
                          }

                      }, icon: Icon(Icons.clear) )
                    ],

                  ),
                ),
              cubit.openSearch == true ?
                Container(
                  height:
                  ScreenSize.screenHeight * 0.7,
                  child: ListView.separated(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemBuilder: (context,
                          index) => BookComponent(model: cubit.booksSearched[index] ,),
                      separatorBuilder:
                          (context, index) =>
                          SizedBox(
                            height: ScreenSize
                                .screenHeight *
                                0.01,
                          ),
                      itemCount: cubit.booksSearched.length),
                ) :
              Container(
                height:
                ScreenSize.screenHeight * 0.7,
                child: ListView.separated(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemBuilder: (context,
                        index) => BookComponent(model: cubit.books[index] ,),
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
          ),
        ),

      );
    });
  }
}
