import 'package:carousel_indicator/carousel_indicator.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_commerce/constants/constants.dart';
import 'package:e_commerce/features/home/cubit/home_cubit.dart';
import 'package:e_commerce/features/home/cubit/home_states.dart';
import 'package:e_commerce/features/login/login_screen.dart';
import 'package:e_commerce/models/models.dart';
import 'package:e_commerce/services/screen_size.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'components/category_component.dart';
import 'components/item_component.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit,HomeStates>(
      listener: (context,state){},
        builder: (context,state){
          ScreenSize.init(context);
          HomeCubit cubit = HomeCubit.get(context);
          GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
          return Scaffold(
            key: _scaffoldKey,
            drawer: Drawer(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    DrawerHeader(
                      decoration: BoxDecoration(
                        color: Color(0xff174068),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            backgroundImage: NetworkImage(cubit.profileModel.image,),
                            radius: 30,
                          ),
                          SizedBox(height: ScreenSize.screenHeight*0.018,),
                          Text('${cubit.profileModel.name}',style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w700,
                             color: Colors.white
                          ), ),
                          SizedBox(height: ScreenSize.screenHeight*0.018,),
                          Text('${cubit.profileModel.email}',style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w700,
                              color: Colors.white
                          ), ),
                        ],
                      )

                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                            title: const Text('Order history',style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey
                            ),),
                            onTap: () {

                            },
                            leading: Icon(Icons.history),
                          ),
                          Divider(height: 1,color: Colors.grey,),
                          ListTile(
                            title: const Text('Edit profile',style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey
                            ),),
                            onTap: () {

                            },
                            leading: Icon(Icons.edit),
                          ),
                          Divider(height: 1,color: Colors.grey,),
                          ListTile(
                            title: const Text('Change password',style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey
                            ),),
                            onTap: () {

                            },
                            leading: Icon(Icons.password_outlined),
                          ),
                          Divider(height: 1,color: Colors.grey,),
                          ListTile(
                            title: const Text('Logout',style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey
                            ),),
                            onTap: () {
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> LoginScreen()));
                            },
                            leading: Icon(Icons.logout_outlined,color: Colors.red),
                          ),
                        ],
                      ),
                    )


                  ],
                ),
            ),
            body: SafeArea(
              child:
            SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        IconButton(onPressed: (){
                          _scaffoldKey.currentState?.openDrawer();
                        }, icon: Icon(Icons.menu)),
                        SizedBox(width: ScreenSize.screenWidth*0.025),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Hi, ${cubit.profileModel.name}',style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w700
                            ), ),
                            SizedBox(
                              height: ScreenSize.screenHeight*0.01,
                            ),
                            Text('What will you read today?',style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey
                            ), ),

                          ],
                        ),
                        Spacer(),
                        CircleAvatar(
                          backgroundImage: NetworkImage(cubit.profileModel.image,),
                          radius: 30,
                        )
                      ],
                    ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.all(15.0),
                  //   child: Row(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: [
                  //       IconButton(onPressed: (){}, icon: Icon(Icons.menu)),
                  //       Column(
                  //         crossAxisAlignment: CrossAxisAlignment.start,
                  //         children: [
                  //           Text('Hi, ${cubit.profileModelTest.name}',style: TextStyle(
                  //               fontSize: 17,
                  //               fontWeight: FontWeight.w700
                  //           ), ),
                  //           SizedBox(
                  //             height: ScreenSize.screenHeight*0.01,
                  //           ),
                  //           Text('What will you read today?',style: TextStyle(
                  //               fontSize: 15,
                  //               fontWeight: FontWeight.w500,
                  //               color: Colors.grey
                  //           ), ),
                  //
                  //         ],
                  //       ),
                  //       Spacer(),
                  //       CircleAvatar(
                  //         backgroundImage: AssetImage(cubit.profileModelTest.image,),
                  //         radius: 30,
                  //       )
                  //     ],
                  //   ),
                  // ),
                  Column(
                    children: [

                      CarouselSlider(
                        options: CarouselOptions(
                          aspectRatio: 2,
                          viewportFraction: .9,
                          disableCenter: true,
                          autoPlay: true,
                          autoPlayAnimationDuration: Duration(milliseconds: 2000),

                        ),
                        items:  cubit.slidersData
                            .map((item) => Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            decoration: BoxDecoration(
                                color:Colors.black,
                                borderRadius: BorderRadius.all(Radius.circular(20)),
                                image: DecorationImage(
                                    image: Image.network(item.image,).image,
                                    fit: BoxFit.cover
                                )
                            ),
                            height: 50,
                          ),
                        ))
                            .toList(),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text('Best Seller',style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w800,

                            ),),
                            Spacer(),
                            IconButton(onPressed: (){}, icon: Icon(Icons.keyboard_arrow_right))
                          ],
                        ),
                        cubit.bestSellingProducts.isNotEmpty?
                        Column(
                          children: [
                            Container(
                              height:
                              ScreenSize.screenHeight * 0.33,
                              child: ListView.separated(
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  itemBuilder: (context,
                                      index) => ItemComponent (model:cubit.bestSellingProducts[index] ,),
                                  separatorBuilder:
                                      (context, index) =>
                                      SizedBox(
                                        width: ScreenSize
                                            .screenWidth *
                                            0.01,
                                      ),
                                  itemCount: cubit.bestSellingProducts.length),
                            ),
                          ],
                        ):
                        Text(""),
                        CarouselSlider(
                          options: CarouselOptions(
                            aspectRatio: 2,
                            viewportFraction: .9,
                            disableCenter: true,
                            onPageChanged: (index,i) {
                              cubit.chanegePageIndex(index);
                              // setState(() {
                              //   pageIndex = index;
                              //   print(i);
                              // });
                            },

                          ),

                          items: cubit.imgList
                              .map((item) => Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  color:Colors.black,
                                  borderRadius: BorderRadius.all(Radius.circular(20)),
                                  image: DecorationImage(
                                      image: AssetImage(item,),
                                      fit: BoxFit.cover
                                  )
                              ),
                              height: 50,
                            ),
                          ))
                              .toList(),

                        ),
                        Center(
                          child: CarouselIndicator(
                            count: cubit.imgList.length,
                            index: cubit.pageIndex,
                            color: Colors.grey,
                            activeColor: defaultColor,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text('Categories',style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w800,

                            ),),
                            Spacer(),
                            IconButton(onPressed: (){}, icon: Icon(Icons.keyboard_arrow_right))
                          ],
                        ),
                        cubit.categoriesData.isNotEmpty?
                        Column(
                          children: [
                            Container(
                              height:
                              ScreenSize.screenHeight * 0.2,
                              child: ListView.separated(
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  itemBuilder: (context,
                                      index) => CategoryComponent (model:cubit.categoriesData[index] ,),
                                  separatorBuilder:
                                      (context, index) =>
                                      SizedBox(
                                        width: ScreenSize
                                            .screenWidth *
                                            0.01,
                                      ),
                                  itemCount: cubit.categoriesData.length),
                            ),
                          ],
                        ) :
                        Text(""),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text('New Arrival',style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w800,

                            ),),
                            Spacer(),
                            IconButton(onPressed: (){}, icon: Icon(Icons.keyboard_arrow_right))
                          ],
                        ),
                        cubit.newArrivalProducts.isNotEmpty?
                        Column(
                          children: [
                            Container(
                              height:
                              ScreenSize.screenHeight * 0.33,
                              child: ListView.separated(
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  itemBuilder: (context,
                                      index) => ItemComponent(model:cubit.newArrivalProducts[index] ,),
                                  separatorBuilder:
                                      (context, index) =>
                                      SizedBox(
                                        width: ScreenSize
                                            .screenWidth *
                                            0.01,
                                      ),
                                  itemCount: cubit.newArrivalProducts.length),
                            ),
                          ],
                        ) :
                        Text(""),
                      ],
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
