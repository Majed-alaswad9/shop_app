import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/login_signup/login_screen.dart';
import 'package:shop_app/NetWork/Local/cach_helper.dart';
import 'package:shop_app/shop_app/shop_layout_screen.dart';
import 'package:shop_app/shop_layout/cubit/shop_layout_cubit.dart';
import 'package:shop_app/shop_layout/cubit/shop_layout_state.dart';
import 'package:shop_app/login_signup/palette.dart';
import 'package:shop_app/shared/const.dart';

class SettingLayout extends StatelessWidget {

  SettingLayout({Key? key}) : super(key: key);
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var imageController = TextEditingController();
  var nameController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopLayoutCubit, ShopLayoutstate>(
      listener: (context, state) {
        if (state is ShopUpdateDataSuccessesState) {
          if (state.update!.status!) {
            showMsg(msg: state.update!.message, color: colorMsg.success);
          } else {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const ShopAppScreen()),
                (route) => false);
            showMsg(msg: state.update!.message, color: colorMsg.error);
          }
        }
      },
      builder: (context, state) {
        var cubit = ShopLayoutCubit.get(context);
        nameController.text = cubit.user!.data!.name!;
        emailController.text = cubit.user!.data!.email!;
        phoneController.text = cubit.user!.data!.phone!;
        return ConditionalBuilder(
          condition: state is! ShopLoadingProfileState,
          builder: (context) => Padding(
            padding: const EdgeInsets.all(10.0),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  if (state is ShopLoadingUpdateDataState)
                    const LinearProgressIndicator(),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: nameController,
                    keyboardType: TextInputType.text,
                    validator: validateName,
                    decoration:const  InputDecoration(
                      prefixIcon:  Icon(
                        Icons.person,
                        color: Palette.iconColor,
                      ),
                      enabledBorder:  OutlineInputBorder(
                        borderSide: BorderSide(color: Palette.textColor1),
                        borderRadius: BorderRadius.all(Radius.circular(35.0)),
                      ),
                      focusedBorder:  OutlineInputBorder(
                        borderSide: BorderSide(color: Palette.textColor1),
                        borderRadius: BorderRadius.all(Radius.circular(35.0)),
                      ),
                      contentPadding:  EdgeInsets.all(10),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    validator: validateEmail,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(
                        Icons.email,
                        color: Palette.iconColor,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Palette.textColor1),
                        borderRadius: BorderRadius.all(Radius.circular(35.0)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Palette.textColor1),
                        borderRadius: BorderRadius.all(Radius.circular(35.0)),
                      ),
                      contentPadding: EdgeInsets.all(10),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: phoneController,
                    keyboardType: TextInputType.phone,
                    validator: validateMobile,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(
                        Icons.phone,
                        color: Palette.iconColor,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Palette.textColor1),
                        borderRadius: BorderRadius.all(Radius.circular(35.0)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Palette.textColor1),
                        borderRadius: BorderRadius.all(Radius.circular(35.0)),
                      ),
                      contentPadding: EdgeInsets.all(10),
                    ),
                  ),
                  const Spacer(),
                  Container(
                    width: double.infinity,
                    height: 50,
                    color: Colors.blue,
                    child: TextButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          ShopLayoutCubit.get(context).updateUserData(
                              email: emailController.text,
                              name: nameController.text,
                              phone: phoneController.text);
                        }
                      },
                      child: const Text('Update',
                          style: TextStyle(fontSize: 20, color: Colors.white)),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: double.infinity,
                    height: 50,
                    color: Colors.red,
                    child: TextButton(
                      onPressed: () {
                        CachHelper.remove(key: 'token').then((value) {
                          ShopLayoutCubit.get(context).indexBottom = 0;
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>  LoginScreen()),
                              (route) => false);
                        });
                      },
                      child: const Text('LOG OUT',
                          style: TextStyle(fontSize: 20, color: Colors.white)),
                    ),
                  )
                ],
              ),
            ),
          ),
          fallback: (context) => const CircularProgressIndicator(),
        );
      },
    );
  }

  Widget buildProfile(context) => Padding(
        padding: const EdgeInsets.all(10.0),
        child: Form(
          child: Column(
            children: [
              TextFormField(
                controller: nameController,
                keyboardType: TextInputType.text,
                validator: (String? value) {
                  if (value != null) return null;
                  return 'must be not empty';
                },
                decoration: const InputDecoration(
                  prefixIcon: Icon(
                    Icons.person,
                    color: Palette.iconColor,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Palette.textColor1),
                    borderRadius: BorderRadius.all(Radius.circular(35.0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Palette.textColor1),
                    borderRadius: BorderRadius.all(Radius.circular(35.0)),
                  ),
                  contentPadding: EdgeInsets.all(10),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                validator: (String? value) {
                  if (value != null) return null;
                  return 'must be not empty';
                },
                decoration: const InputDecoration(
                  prefixIcon: Icon(
                    Icons.email,
                    color: Palette.iconColor,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Palette.textColor1),
                    borderRadius: BorderRadius.all(Radius.circular(35.0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Palette.textColor1),
                    borderRadius: BorderRadius.all(Radius.circular(35.0)),
                  ),
                  contentPadding: EdgeInsets.all(10),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: phoneController,
                keyboardType: TextInputType.phone,
                validator: (String? value) {
                  if (value != null) return null;
                  return 'must be not empty';
                },
                decoration: const InputDecoration(
                  prefixIcon: Icon(
                    Icons.email,
                    color: Palette.iconColor,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Palette.textColor1),
                    borderRadius: BorderRadius.all(Radius.circular(35.0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Palette.textColor1),
                    borderRadius: BorderRadius.all(Radius.circular(35.0)),
                  ),
                  contentPadding: EdgeInsets.all(10),
                ),
              ),
              const Spacer(),
              Container(
                width: double.infinity,
                height: 50,
                color: Colors.blue,
                child: TextButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      ShopLayoutCubit.get(context).updateUserData(
                          email: emailController.text,
                          name: nameController.text,
                          phone: phoneController.text);
                    }
                  },
                  child: const Text('Update',
                      style: TextStyle(fontSize: 20, color: Colors.white)),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                width: double.infinity,
                height: 50,
                color: Colors.red,
                child: TextButton(
                  onPressed: () {
                    CachHelper.remove(key: 'token').then((value) {
                      ShopLayoutCubit.get(context).indexBottom = 0;
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>  LoginScreen()),
                          (route) => false);
                    });
                  },
                  child: const Text('LOG OUT',
                      style: TextStyle(fontSize: 20, color: Colors.white)),
                ),
              )
            ],
          ),
        ),
      );

  String? validateEmail(String? value) {
    if (value != null) {
      if (value.length > 5 && value.contains('@') && value.endsWith('.com')) {
        return null;
      }
      return 'Enter a Valid Email Address';
    }
  }

  String? validateName(String? value) {
    if (value!.length < 3) {
      return 'Name must be more than 2 charter';
    }
    return null;
  }

  String? validateMobile(String? value) {
    if (value!.length != 10) {
      return 'Mobile Number must be of 10 digit';
    }
    return null;
  }
}
