import 'package:e_commerce/features/checkout/components/checkout_component.dart';
import 'package:e_commerce/features/home/cubit/home_cubit.dart';
import 'package:e_commerce/features/home/cubit/home_states.dart';
import 'package:e_commerce/models/models.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../components/components.dart';
import '../../constants/constants.dart';
import '../../services/screen_size.dart';
import 'cubit/checkout_cubit.dart';
import 'cubit/checkout_states.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CheckoutCubit,CheckoutStates>(
      builder: (context,state){
        CheckoutCubit cubit = CheckoutCubit.get(context);
        ScreenSize.init(context);
        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text('Checkout',style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 25,
                    ),),
                  ),
                  Form(
                    key: cubit.checkoutFormKey,
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
                          SizedBox(height: ScreenSize.screenHeight*0.02,),
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
                          SizedBox(height: ScreenSize.screenHeight*0.02,),
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

                          SizedBox(height: ScreenSize.screenHeight*0.02,),
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
                          SizedBox(height: ScreenSize.screenHeight*0.02,),
                          DropdownButton<String>(
                            value: cubit.selectedItem,
                            onChanged: (value) {
                              cubit.changeCity(value);
                            },
                            items: cubit.cities.map((city) => DropdownMenuItem<String>(
                              value: city.governorateNameEn,
                              onTap: (){
                                cubit.saveCityId(city);
                              },
                              child: Text(city.governorateNameEn),
                            )).toList(),
                            isExpanded: true,
                          ),
                          Divider(
                            height: 1,
                            color: Colors.grey,
                          ),
                          Container(
                            height:
                            ScreenSize.screenHeight * 0.2,
                            child: ListView.separated(
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemBuilder: (context,
                                    index) => CheckoutComponent(model: cubit.orderModel.cartItems[index] ,),
                                separatorBuilder:
                                    (context, index) =>
                                    Divider(color: Colors.grey,height: 1,),
                                itemCount: cubit.orderModel.cartItems.length),
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
                                      smalldefaultButton(text: 'Order now',
                                          onpressed: (){
                                            if (cubit.checkoutFormKey.currentState!.validate()) {
                                              print('Validated');
                                              cubit.checkout(context);
                                            }
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
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
