import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../models/models.dart';
import '../../../services/screen_size.dart';

class CategoryComponent extends StatelessWidget {
  final CategoryModel model;
  const CategoryComponent({super.key,
    required this.model});

  @override
  Widget build(BuildContext context) {
    // print(model.image);
    return Container(
        height: ScreenSize.screenHeight*0.3,
        width: ScreenSize.screenWidth*0.3,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: MaterialButton(
            onPressed: (){},
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                    width: ScreenSize.screenWidth*0.25,
                    height: ScreenSize.screenHeight*0.13,
                    decoration: BoxDecoration(
                      image: DecorationImage(image: AssetImage('assets/images/books.jpg',),fit: BoxFit.cover,opacity: 0.5),
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                     )
                ),
                Text(model.name, maxLines: 2,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    )),
              ],
            ),
            padding: EdgeInsets.zero,
          ),
        )
    );
  }
}
