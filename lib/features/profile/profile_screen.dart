import 'package:e_commerce/components/components.dart';
import 'package:e_commerce/constants/constants.dart';
import 'package:e_commerce/features/home/cubit/home_cubit.dart';
import 'package:e_commerce/features/home/cubit/home_states.dart';
import 'package:e_commerce/services/screen_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit,HomeStates>(
      listener: (context,state) {},
      builder: (context,state) {
        ScreenSize.init(context);
        HomeCubit cubit = HomeCubit.get(context);
        return Scaffold(
          body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                   children: [
                     Container(
                       width: double.infinity,
                       height: ScreenSize.screenHeight*0.15,
                       decoration: BoxDecoration(
                         color: defaultColor,
                         borderRadius: BorderRadius.only(bottomLeft: Radius.circular(90), bottomRight: Radius.circular(90)),
                       ),
                       child: Stack(
                         alignment: Alignment.topRight,
                         children: [
                           Center(
                             child: Text('Profile',style: TextStyle(
                               fontWeight: FontWeight.bold,
                               fontSize: 25,
                               color: Colors.white,
                             ),),
                           ),
                           IconButton(onPressed: (){}, icon: Icon(Icons.logout_outlined, color: Colors.white,))
                         ],
                       ),
                     ),
                     SizedBox(height: ScreenSize.screenHeight*0.03,),
                     CircleAvatar(
                       backgroundImage: NetworkImage(cubit.profileModel.image,),
                       radius: 60,
                     ),
                     Form(
                       key: cubit.profileFormKey,
                       child: Padding(
                         padding: const EdgeInsets.all(20.0),
                         child: Column(
                           children: [
                             TextFieldComponent(
                               label: 'Name',
                               controller: cubit.profileNameController,
                               picon: Icon(Icons.person),
                               validator: (value) {
                                 if (value.isEmpty) {
                                   return 'please enter your updated name';
                                 }
                                 if (value.length < 3) {
                                   return 'name must be at least 3 characters';
                                 }
                                 return null;
                               },
                             ),
                             SizedBox(height: ScreenSize.screenHeight*0.03,),
                             TextFieldComponent(
                               label: 'Email',
                               controller: cubit.profileEmailController,
                               picon: Icon(Icons.email_outlined),
                               keyType: TextInputType.emailAddress,
                               validator: (value) {
                                 bool emailValid = RegExp(
                                     r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]")
                                     .hasMatch(value);
                                 if (value.isEmpty) {
                                   return 'please enter your updated email';
                                 } else if (!emailValid) {
                                   return "Enter a valid email";
                                 }
                                 return null;
                               },
                             ),
                             SizedBox(height: ScreenSize.screenHeight*0.03,),
                             TextFieldComponent(
                               label: 'Phone',
                               controller: cubit.profilePhoneController,
                               picon: Icon(Icons.call),
                               keyType: TextInputType.number,
                               validator: (value) {
                                 if (value.isEmpty) {
                                   return 'please enter your updated phone number';
                                 }
                                 if (value.length != 11) {
                                   return 'phone number must be 11 chars';
                                 }
                                 return null;
                               },
                             ),
                             SizedBox(height: ScreenSize.screenHeight*0.03,),
                             TextFieldComponent(
                               label: 'City',
                               controller: cubit.profileCityController,
                               picon: Icon(Icons.location_city_sharp),
                               validator: (value) {
                                 if (value.isEmpty) {
                                   return 'please enter your updated city';
                                 }
                                 return null;
                               },
                             ),
                             SizedBox(height: ScreenSize.screenHeight*0.03,),
                             TextFieldComponent(
                               label: 'Address',
                               controller: cubit.profileAddressController,
                               picon: Icon(Icons.location_on_outlined),
                               validator: (value) {
                                 if (value.isEmpty) {
                                   return 'please enter your updated address';
                                 }
                                 return null;
                               },
                             ),
                             Padding(
                               padding: const EdgeInsets.all(18.0),
                               child: defaultButton(text: 'Edit profile', onpressed: (){
                                 if (cubit.profileFormKey.currentState!.validate()) {
                                   print('Validated');
                                   cubit.updateUserDetails(context);
                                 }
                               },),
                             ),
                           ],
                         ),
                       ),
                     )

                   ],
                ),
              )),
        );
      },
        );
  }
}
