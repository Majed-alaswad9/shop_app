
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubit/app_cubit.dart';
import 'package:shop_app/shop_app/shop_layout_screen.dart';
import 'package:shop_app/login_signup/cubit/login_register_cubit.dart';
import 'package:shop_app/login_signup/cubit/login_register_state.dart';
import 'package:shop_app/NetWork/Local/cach_helper.dart';
import 'package:shop_app/login_signup/palette.dart';
import 'package:shop_app/shared/const.dart';
import 'package:shop_app/shared/end_points.dart';

class RegisterScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginSignUpCubit, LogInSIgnUpState>(
      listener: (context, state) {
        if (state is SignUpSuccessState) {
          if (state.userSign.status!) {
            CachHelper.saveData(key: 'token', value: state.userSign.data!.token)
                .then((value) {
              token = state.userSign.data!.token;
            }).then((value) {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ShopAppScreen()),
                  (route) => false);
            });
            showMsg(msg: state.userSign.message, color: colorMsg.success);
          } else {
            showMsg(msg: state.userSign.message, color: colorMsg.inCorrect);
          }
        }
      },
      builder: (context, state) {
        var cubit = LoginSignUpCubit.get(context);

        return Scaffold(
          appBar: AppBar(),
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                       Text('SIGN UP',
                          style: TextStyle(
                              color: AppCubit.get(context).isDark?Colors.white:Colors.black,
                              fontSize: 35
                          ),),
                      const SizedBox(
                        height: 20,
                      ),
                       const Text('Sign Up To brows our hot offers',
                          style: TextStyle(
                              fontSize: 17,
                              color: Palette.textColor1
                          ),),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        validator: validateEmail,
                        decoration:  InputDecoration(
                            prefixIcon: const Icon(
                              Icons.alternate_email,
                            ),
                            hintText: 'Email',
                            hintStyle: Theme.of(context).textTheme.subtitle2,
                            border: const OutlineInputBorder(),
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Palette.textColor1),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Palette.textColor1),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                            ),
                            contentPadding: const EdgeInsets.all(10)),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: passController,
                        keyboardType: TextInputType.visiblePassword,
                        validator: validatePass,
                        obscureText: cubit.isPassword,
                        decoration:  InputDecoration(
                          prefixIcon: const Icon(
                            Icons.lock,
                          ),
                          hintText: 'Password',
                          hintStyle: Theme.of(context).textTheme.subtitle2,
                          contentPadding: const EdgeInsets.all(10),
                          border: const OutlineInputBorder(),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Palette.textColor1),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Palette.textColor1),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: nameController,
                        keyboardType: TextInputType.text,
                        validator: validateName,
                        decoration:  InputDecoration(
                            prefixIcon: const Icon(
                              Icons.person,
                            ),
                            hintText: 'name',
                            hintStyle: Theme.of(context).textTheme.subtitle2,
                            border: const OutlineInputBorder(),
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Palette.textColor1),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Palette.textColor1),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                            ),
                            contentPadding: const EdgeInsets.all(10)),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: phoneController,
                        keyboardType: TextInputType.phone,
                        validator: validateMobile,
                        decoration:  InputDecoration(
                          prefixIcon: const Icon(
                            Icons.phone,
                          ),
                          hintText: 'Phone number',
                          hintStyle: Theme.of(context).textTheme.subtitle2,
                          contentPadding: const EdgeInsets.all(10),
                          border: const OutlineInputBorder(),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Palette.textColor1),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Palette.textColor1),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ConditionalBuilder(
                        condition: state is! SignUpLoadState,
                        builder: (context) => Container(
                          width: double.infinity,
                          color: Colors.blue,
                          child: TextButton(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                LoginSignUpCubit.get(context).userSignUp(
                                    email: emailController.text,
                                    password: passController.text,
                                    name: nameController.text,
                                    phone: phoneController.text);
                              }
                            },
                            child:  Text(
                              'REGISTER',
                              style:Theme.of(context).textTheme.bodyText1,
                            ),
                          ),
                        ),
                        fallback: (context) => const Center(
                          child: CircularProgressIndicator(
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  String? validateEmail(String? value) {
    if (value != null) {
      if (value.length > 5 && value.contains('@') && value.endsWith('.com')) {
        return null;
      }
      return 'Enter a Valid Email Address';
    }
  }

  String? validatePass(String? value) {
    if (value != null) {
      if (value.length >= 6) {
        return null;
      }
      return 'Password must be more than six characters';
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

