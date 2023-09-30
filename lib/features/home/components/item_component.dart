import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../models/models.dart';
import '../../../services/screen_size.dart';

class ItemComponent extends StatelessWidget {
  final ProductModel model;
  const ItemComponent({super.key,
  required this.model});

  @override
  Widget build(BuildContext context) {
   // print(model.image);
    return Container(
        height: ScreenSize.screenHeight*0.4,
        width: ScreenSize.screenWidth*0.4,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: MaterialButton(
            onPressed: (){},
            child: Column(
              children: [
                Container(
                  width: ScreenSize.screenWidth*0.3,
                    height: ScreenSize.screenHeight*0.15,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(image: NetworkImage(model.image,),fit: BoxFit.contain,),)
                    ),
                    // child: Image.network(model.image,fit: BoxFit.contain,)),
                SizedBox(height: ScreenSize.screenHeight*0.01),
                Text(model.name, maxLines: 2,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                    fontSize: 15,
                      fontWeight: FontWeight.w700,
                )),
                SizedBox(height: ScreenSize.screenHeight*0.005),
                Text(model.category, maxLines: 1,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey
                    )),
                Text(model.price, maxLines: 1,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey,
                      decoration: TextDecoration.lineThrough,
                    )),
                SizedBox(height: ScreenSize.screenHeight*0.005),
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
            padding: EdgeInsets.zero,
          ),
        )
    );
  }
}
